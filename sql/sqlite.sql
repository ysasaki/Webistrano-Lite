
BEGIN TRANSACTION;

--
-- Table: stages
--
CREATE TABLE stages (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(1,128) NOT NULL,
  updated_on TIMESTAMP NOT NULL,
  created_on DATETIME NOT NULL
);

--
-- Table: tasks
--
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY NOT NULL,
  name TEXT NOT NULL,
  updated_on TIMESTAMP NOT NULL,
  created_on DATETIME NOT NULL
);

COMMIT;

