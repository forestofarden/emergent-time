--
-- Keep this file!
-- 
-- This is a simple sql implementation of Page & Brin's Pagerank algorithm,
--   basis of the Emergent time citation ranker.  Implemented for proof of correctness.
--
-- As described in pseudocode at http://pr.efactory.de/e-pagerank-algorithm.shtml
--

DROP TABLE node CASCADE;
DROP TABLE edge CASCADE;

CREATE TABLE node(id SERIAL PRIMARY KEY, name TEXT, rank REAL DEFAULT 1.0, outgoing INTEGER);
CREATE TABLE edge(id SERIAL PRIMARY KEY, source_id INTEGER REFERENCES node(id), target_id INTEGER REFERENCES node(id));

CREATE OR REPLACE FUNCTION update_rankings(damping REAL, tolerance REAL) RETURNS VOID AS $$
DECLARE
  change REAL := tolerance + 1.0;
  n RECORD;
BEGIN
  -- update counts of links for all nodes in graph
  UPDATE node SET outgoing = (SELECT count(*) FROM edge WHERE source_id = node.id);
  -- clear existing rankings (TODO: necessary?)
  UPDATE node SET rank = 1.0;
  -- prepare to update rankings
  CREATE TEMPORARY TABLE _ranking(node_id INTEGER, rank REAL, series_sum REAL) ON COMMIT DROP;
  -- loop until largest changed value is below tolerance
  WHILE change > tolerance LOOP
    -- calculate step in event rankings
    INSERT INTO _ranking(node_id, series_sum)
      SELECT n1.id, sum(n2.rank / n2.outgoing::REAL)
      FROM node n1 JOIN edge ON (target_id = n1.id) JOIN node n2 ON (source_id = n2.id)
      GROUP BY n1.id;
    -- factor in damping
    UPDATE _ranking SET rank = (1.0 - damping) + (damping * series_sum);
    -- check greatest change this cycle
    SELECT max(abs) INTO change FROM (
      SELECT abs(node.rank - _ranking.rank) FROM node JOIN _ranking ON (node.id = node_id)
    ) AS change_summary;
    -- propagate new rankings to core table
    UPDATE node SET rank = coalesce((SELECT rank FROM _ranking WHERE node_id = node.id), 0.0);
    -- remove intermediate results            
    DELETE FROM _ranking;
  END LOOP;
END;
$$ LANGUAGE plpgsql;


-- http://pr.efactory.de/e-pagerank-algorithm.shtml example
INSERT INTO node(name) VALUES ('A');
INSERT INTO node(name) VALUES ('B');
INSERT INTO node(name) VALUES ('C');
INSERT INTO edge(source_id, target_id) VALUES (1, 2);
INSERT INTO edge(source_id, target_id) VALUES (1, 3);
INSERT INTO edge(source_id, target_id) VALUES (2, 3);
INSERT INTO edge(source_id, target_id) VALUES (3, 1);

SELECT update_rankings(0.5, 0.00001);
SELECT name, rank FROM node;
