DROP TABLE date_ranges PURGE;

CREATE TABLE date_ranges
 (range_id     number  primary key,
  range_start  date    NOT NULL,
  range_end    date    NOT NULL)
;

INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (1, to_date('2018-Jan-01','YYYY-Mon-DD'), to_Date('2018-May-28','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (2, to_date('2018-May-29','YYYY-Mon-DD'), to_Date('2018-Jul-31','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (3, to_date('2018-Feb-01','YYYY-Mon-DD'), to_Date('2018-Mar-10','YYYY-Mon-DD'));

INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (4, to_date('2018-Oct-01','YYYY-Mon-DD'), to_Date('2018-Oct-02','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (5, to_date('2018-Oct-02','YYYY-Mon-DD'), to_Date('2018-Oct-05','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (6, to_date('2018-Oct-02','YYYY-Mon-DD'), to_Date('2018-Oct-05','YYYY-Mon-DD'));

INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (9, to_date('2018-Oct-07','YYYY-Mon-DD'), to_Date('2018-Oct-15','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (7, to_date('2018-Nov-01','YYYY-Mon-DD'), to_Date('2018-Dec-31','YYYY-Mon-DD'));
INSERT INTO date_ranges (range_id, range_start, range_end) 
VALUES (8, to_date('2019-Jan-01','YYYY-Mon-DD'), to_Date('2019-Mar-20','YYYY-Mon-DD'));


COMMIT;

-- setting a format string at the session level to not have to worry about it in following queries
ALTER SESSION SET nls_date_format = 'YYYY-Mon-DD';

-- run dev queries
@merge_assignments.sql

