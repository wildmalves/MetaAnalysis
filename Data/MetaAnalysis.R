library(DBI)

#### establish database connection ####
metabeaver_db <- dbConnect(RSQLite::SQLite(), "../../MASTERS/MetaAnalysis/Data/metabeaver.db")

#### add tables to the database ####
dbExecute(metabeaver_db, "CREATE TABLE projects (
          proj_id varchar(5) PRIMARY KEY
          proj_email text,
          proj_name text,
          proj_agency varchar (15) CHECK (proj_agency IN ('State', 'Federal', 'Tribal', 'Non Profit', 'For Profit')),
          proj_501c3 varchar (15) CHECK (proj_501c3 IN ('501c3', 'fiscal sponsor')),
          proj_called text,
          proj_lead varchar (5) CHECK (proj_lead IN ('yes', 'no')),
          proj_lead_alt text,
          proj_location text
          );")

dbExecute(metabeaver_db, "CREATE TABLE responses (
          resp_id varchar (5) NOT NULL PRIMARY KEY,
          FOREIGN KEY(proj_id) REFERENCES projects(proj_id)
          );")

dbExecute(metabeaver_db, "CREATE TABLE questions (
          quest_id varchar text PRIMARY KEY
          questions text,
          answer_type text
          );")

dbExecute(metabeaver_db, "CREATE TABLE answers_text (
          text_id text PRIMARY KEY,
          answer text,
          FOREIGN KEY(resp_id) REFERENCES responses(resp_id)
          FOREIGN KEY(quest_id) REFERENCES questions(quest_id)
          );")

dbExecute(metabeaver_db, "CREATE TABLE answers_mc (
          mc_id text PRIMARY KEY,
          answer text,
          FOREIGN KEY(resp_id) REFERENCES responses(resp_id)
          FOREIGN KEY(quest_id) REFERENCES questions(quest_id)
          );")

dbExecute(metabeaver_db, "CREATE TABLE answers_ls (
          ls_id text PRIMARY KEY,
          answer text,
          FOREIGN KEY(resp_id) REFERENCES responses(resp_id)
          FOREIGN KEY(quest_id) REFERENCES questions(quest_id)
          );")

dbExecute(metabeaver_db, "CREATE TABLE answers_ca (
          ca_id text PRIMARY KEY,
          answer text,
          FOREIGN KEY(resp_id) REFERENCES responses(resp_id)
          FOREIGN KEY(quest_id) REFERENCES questions(quest_id)
          );")

dbExecute(metabeaver_db, "CREATE TABLE answer_type (
          answer_type text PRIMARY KEY,
          FOREIGN KEY (text_id) REFERENCES answers_text(text_id)
          FOREIGN KEY (mc_id) REFERENCES answers_mc(mc_id)
          FOREIGN KEY (ls_id) REFERENCES answers_ls(ls_id)
          FOREIGN KEY (ca_id) REFERENCES answers_ca(ca_id)
          FOREIGN KEY (quest_id) REFERENCES questions(quest_id)
          );")
