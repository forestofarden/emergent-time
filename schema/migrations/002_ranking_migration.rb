migration 2, :ranking  do
  up do
    
    sql = []
    
      # A naive implementation of Google PageRank using events and timelines as nodes in a non-directional graph
      #   damping:    as defined by PageRank
      #   tolerance:  precision after which algorithm stops calculating
    sql << <<-TXT
      CREATE OR REPLACE FUNCTION update_rankings(damping REAL, tolerance REAL) RETURNS VOID AS $$
      DECLARE
        change REAL := tolerance + 1.0;
      BEGIN
        -- update counts of links for all nodes in graph
        UPDATE events    SET links = (SELECT count(*) FROM timeline_events WHERE event_id = events.id);
        UPDATE timelines SET links = (SELECT count(*) FROM timeline_events WHERE timeline_id = timelines.id);
        -- clear existing rankings (TODO: not sure if necessary...
        UPDATE events SET rank = 1.0;
        UPDATE timelines SET rank = 1.0;
        -- prepare to update rankings
        CREATE TEMPORARY TABLE _temp(id INTEGER, rank REAL, series_sum REAL) ON COMMIT DROP;
        -- loop until largest changed value is below tolerance
        WHILE change > tolerance LOOP
          -- calculate step in event rankings
          INSERT INTO _temp(id, series_sum)
            SELECT te.event_id, sum(tl.rank / tl.links::REAL)
            FROM timeline_events te JOIN timelines tl ON (te.timeline_id = tl.id)
            GROUP BY te.event_id;
          -- factor in damping
          UPDATE _temp SET rank = (1.0 - damping) + (damping * series_sum);
          -- check greatest change this cycle
          SELECT max(abs) INTO change FROM (
            SELECT abs(events.rank - _temp.rank) FROM events JOIN _temp USING (id)
          ) AS change_summary;
          -- propagate new rankings to core table
          UPDATE events SET rank = coalesce((SELECT rank FROM _temp WHERE id = events.id), 0.0);
          -- remove intermediate results            
          DELETE FROM _temp;
      
          -- calculate step in timeline rankings
          INSERT INTO _temp(id, series_sum)
            SELECT te.timeline_id, sum(e.rank / e.links::REAL)
            FROM timeline_events te JOIN events e ON (te.event_id = e.id)
            GROUP BY te.timeline_id;
          -- factor in damping
          UPDATE _temp SET rank = (1.0 - damping) + (damping * series_sum);
          -- check greatest change this cycle, including events' change value
          SELECT max(abs) INTO change FROM (
            SELECT change AS abs
            UNION
            SELECT abs(timelines.rank - _temp.rank) FROM timelines JOIN _temp USING (id)
          ) AS change_summary;
          -- propagate new rankings to core table
          UPDATE timelines SET rank = coalesce((SELECT rank FROM _temp WHERE id = timelines.id), 0.0);
          -- remove intermediate results            
          DELETE FROM _temp;    
        END LOOP;
      END;
      $$ LANGUAGE plpgsql
    TXT

    # recalculate rankings periodically
    sql << "INSERT INTO crontab(notice, role, interval, task) VALUES('Emergent Time event ranking', 'emt', '5 minutes', 'SELECT update_rankings(0.85, 0.000001);')"

    #garbage collect unused events
    sql << <<-TXT
      CREATE OR REPLACE FUNCTION events_gc() RETURNS VOID AS $$
        -- usign actual counts avoid edge case where event has just been added to a timeline
        DELETE FROM events WHERE 0 = (SELECT count(*) FROM timeline_events WHERE event_id = events.id);
      $$ LANGUAGE sql
    TXT
    sql << "INSERT INTO crontab(notice, role, interval, task) VALUES('Emergent Time garbage collection', 'emt', '24 hours', 'SELECT events_gc();')"

    # Date support functions for event suggestion
    sql << <<-TXT
     CREATE OR REPLACE FUNCTION distance(start1 TIMESTAMP, end1 TIMESTAMP, start2 TIMESTAMP, end2 TIMESTAMP) RETURNS interval AS $$
     DECLARE
     avg1 TIMESTAMP;
     avg2 TIMESTAMP;
     dist INTERVAL;
     BEGIN
       avg1 = (start1 + ((coalesce(end1, start1) - start1) / 2));
       avg2 = (start2 + ((coalesce(end2, start2) - start2) / 2));
       dist = avg2 - avg1;
       IF dist < '0 days'::interval THEN
         dist = -dist;
       END IF;
       RETURN dist;
     END;
     $$ LANGUAGE plpgsql
    TXT

     sql.each do |line|
       repository.adapter.execute(line)
     end
  end

  down do
    sql = []
    sql << "DELETE FROM crontab WHERE notice IN ('Emergent Time event ranking', 'Emergent Time garbage collection')"
    sql << "DROP FUNCTION update_rankings(REAL, REAL)"
    sql << "DROP FUNCTION distance(TIMESTAMP, TIMESTAMP, TIMESTAMP, TIMESTAMP)"
    
    sql.each do |line|
      repository.adapter.execute(line)
    end
  end
end
