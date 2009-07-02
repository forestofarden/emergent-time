migration 1, :full_text  do
  up do
    
    # NOTE.  you must grant the emt user access to the crontab table first...
    #
    #        - follow Repertoire instructions for creating a new user & schema, 'emt'
    #
    #        GRANT ALL ON crontab TO emt ;
    #        GRANT ALL ON crontab_id_seq TO emt ;
    # 
    #        then [Event, EventComment, Timeline, TimelineComment, TimelineEvent].each { |m| m.auto_migrate! } in merb console
    #
    
    sql = []
    sql << "CREATE AGGREGATE tsvector_accum (tsvector) (sfunc = tsvector_concat, stype = tsvector, initcond = '')"
      
    sql << "ALTER TABLE timelines ADD COLUMN _fulltext tsvector"
    sql << "ALTER TABLE events ADD COLUMN _fulltext tsvector"
        
    # Events as indexed with their interpretations
    sql << <<-TXT.compress_lines
        CREATE OR REPLACE FUNCTION update_event_fulltext() RETURNS VOID AS $$
          UPDATE events SET _fulltext = to_tsvector(coalesce(title, '') || ' ' || description) || 
                                                   (SELECT tsvector_accum(to_tsvector(interpretation)) 
                                                    FROM timeline_events 
                                                    WHERE event_id = events.id);
        $$ LANGUAGE sql
        TXT
        
    # Timelines are indexed with their events and users    
    sql << <<-TXT.compress_lines
        CREATE OR REPLACE FUNCTION update_timeline_fulltext() RETURNS VOID AS $$
          UPDATE timelines SET _fulltext = to_tsvector(title || coalesce(intro, '')) ||
                                                      (SELECT tsvector_accum(to_tsvector(first_name || ' ' || last_name || ' ' || coalesce(shortname, '')))
                                                       FROM users
                                                       WHERE user_id = users.id) ||
                                                      (SELECT tsvector_accum(_fulltext)
                                                       FROM timeline_events JOIN events ON (event_id = events.id)
                                                       WHERE timeline_id = timelines.id);
        $$ LANGUAGE sql
    TXT
        
    # Update timeline and event full text indices
    sql << <<-TXT.compress_lines
        INSERT INTO crontab(notice, role, interval, task) VALUES('Emergent Time full text index', 'emt', '5 minutes',
$$SELECT update_event_fulltext();
SELECT update_timeline_fulltext();$$);
    TXT

    sql.each do |line|
      repository.adapter.execute(line)
    end
  end

  down do
    sql = []
    sql << "DELETE FROM crontab WHERE role = 'emt'"
    
    sql << "ALTER TABLE timelines DROP COLUMN _fulltext"
    sql << "ALTER TABLE events DROP COLUMN _fulltext"
        
    sql << "DROP FUNCTION update_event_fulltext()"
    sql << "DROP FUNCTION update_timeline_fulltext()"
      
    sql << "DROP AGGREGATE tsvector_accum(tsvector)"
    
    sql.each do |line|
      repository.adapter.execute(line)
    end
  end
end
