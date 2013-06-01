CREATE SEQUENCE demographics_demoid_seq;
CREATE TABLE IF NOT EXISTS demographics (
demoId integer PRIMARY KEY DEFAULT nextval('demographics_demoid_seq'),
name varchar,
description text);
ALTER SEQUENCE demographics_demoid_seq OWNED BY demographics.demoId;

CREATE SEQUENCE notification_type_notifytypeid_seq;
CREATE TABLE IF NOT EXISTS notification_type (
notifyTypeId integer PRIMARY KEY DEFAULT nextval('notification_type_notifytypeid_seq'),
name varchar,
description text);
ALTER SEQUENCE notification_type_notifytypeid_seq OWNED BY notification_type.notifyTypeId;

CREATE SEQUENCE groups_groupid_seq;
CREATE TABLE IF NOT EXISTS groups (
groupId integer PRIMARY KEY DEFAULT nextval('groups_groupid_seq'),
name varchar,
description text);
ALTER SEQUENCE groups_groupid_seq OWNED BY groups.groupId;

CREATE SEQUENCE clinic_clinicid_seq;
CREATE TABLE IF NOT EXISTS clinic (
clinicId integer PRIMARY KEY DEFAULT nextval('clinic_clinicid_seq'),
name varchar,
description text,
address varchar,
city varchar,
state varchar,
postalCode varchar,
phone varchar,
fax varchar,
email varchar,
website varchar);
ALTER SEQUENCE clinic_clinicid_seq OWNED BY clinic.clinicid;

CREATE SEQUENCE users_userid_seq;
CREATE TABLE IF NOT EXISTS users (
userId integer PRIMARY KEY DEFAULT nextval('users_userid_seq'),
username varchar NOT NULL,
credential varchar NOT NULL);
ALTER SEQUENCE users_userid_seq OWNED BY users.userId;

CREATE TABLE IF NOT EXISTS user_group (
date_modified timestamp NOT NULL,
userId integer REFERENCES users(userId) NOT NULL,
groupId integer REFERENCES groups(groupId) NOT NULL,
modified_by_userId integer REFERENCES users(userId) NOT NULL);


CREATE TABLE IF NOT EXISTS users_access (
access_date timestamp NOT NULL,
userId integer REFERENCES users(userId) NOT NULL,
access_ip varchar,
access_agent varchar);

CREATE TABLE IF NOT EXISTS user_clinic (
assignement_date timestamp NOT NULL,
userId integer REFERENCES users(userId) NOT NULL,
clinicId integer REFERENCES clinic(clinicId) NOT NULL);

CREATE SEQUENCE patient_patientid_seq;
CREATE TABLE IF NOT EXISTS patient (
patientId integer PRIMARY KEY DEFAULT nextval('patient_patientid_seq'),
credential varchar,
contact varchar,
opt_in_sms boolean,
demoId integer REFERENCES demographics(demoId) NOT NULL);
ALTER SEQUENCE patient_patientid_seq OWNED BY patient.patientId;

CREATE SEQUENCE test_types_testtypeid_seq;
CREATE TABLE IF NOT EXISTS test_types (
testTypeId integer PRIMARY KEY DEFAULT nextval('test_types_testtypeid_seq'),
name varchar NOT NULL,
description text NOT NULL,
modified_by_userId integer REFERENCES users(userId) NOT NULL,
version integer);
ALTER SEQUENCE test_types_testtypeid_seq OWNED BY test_types.testTypeId;

CREATE SEQUENCE messages_messageid_seq;
CREATE TABLE IF NOT EXISTS messages (
messageId integer PRIMARY KEY DEFAULT nextval('messages_messageid_seq'),
name varchar,
description text,
modified_by_userId integer REFERENCES users(userId) NOT NULL,
version integer);
ALTER SEQUENCE messages_messageid_seq OWNED BY messages.messageId;

CREATE SEQUENCE notification_notifyid_seq;
CREATE TABLE IF NOT EXISTS notification(
notifyId integer PRIMARY KEY DEFAULT nextval('notification_notifyid_seq'),
date_sent timestamp,
link_sent varchar,
viewed boolean,
messageId integer REFERENCES messages(messageId) NOT NULL,
notifyTypeId integer REFERENCES notification_type(notifyTypeId) NOT NULL);
ALTER SEQUENCE notification_notifyid_seq OWNED BY notification.notifyId;

CREATE SEQUENCE test_testid_seq;
CREATE TABLE IF NOT EXISTS test(
testId integer PRIMARY KEY DEFAULT nextval('test_testid_seq'),
date_of_test timestamp,
sample_from varchar,
treated boolean,
testTypeId integer REFERENCES test_types(testTypeId) NOT NULL);
ALTER SEQUENCE test_testid_seq OWNED BY test.testId;

CREATE TABLE IF NOT EXISTS patient_test (
patientId integer REFERENCES patient(patientId) NOT NULL,
notifyId integer REFERENCES notification(notifyId) NOT NULL,
testId integer REFERENCES test(testId) NOT NULL,
result boolean,
follow_up_by_dis boolean);

CREATE TABLE IF NOT EXISTS patient_dis (
date_assigned timestamp NOT NULL,
userId integer REFERENCES users(userId) NOT NULL,
patientId integer REFERENCES patient(patientId) NOT NULL);
