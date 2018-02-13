DROP TABLE IF EXISTS bounty_tracker;

CREATE TABLE bounty_tracker(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT2,
  last_known_location VARCHAR(255),
  collected_by VARCHAR(255)
);
