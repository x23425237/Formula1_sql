-- constructorResults,raceid
ALTER TABLE FORMULA1.CONSTRUCTORRESULTS
DROP CONSTRAINT IF EXISTS CONSTRUCTORRESULTS_RACEID_FKEY;

ALTER TABLE FORMULA1.CONSTRUCTORRESULTS
ADD CONSTRAINT CONSTRUCTORRESULTS_RACEID_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- constructorStandings,raceid
ALTER TABLE FORMULA1.CONSTRUCTORSTANDINGS
DROP CONSTRAINT IF EXISTS CONSTRUCTORSTANDINGS_RACEID_FKEY;

ALTER TABLE FORMULA1.CONSTRUCTORSTANDINGS
ADD CONSTRAINT CONSTRUCTORSTANDINGS_RACEID_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- constructorStandings,constructorId
ALTER TABLE FORMULA1.CONSTRUCTORSTANDINGS
DROP CONSTRAINT IF EXISTS CONSTRUCTORSTANDINGS_CONSTRUCTORID_FKEY;

ALTER TABLE FORMULA1.CONSTRUCTORSTANDINGS
ADD CONSTRAINT CONSTRUCTORSTANDINGS_CONSTRUCTORID_FKEY FOREIGN KEY (CONSTRUCTORID) REFERENCES FORMULA1.CONSTRUCTORS (CONSTRUCTORID);

-- driverStandings, driverid 
ALTER TABLE FORMULA1.DRIVERSTANDINGS
DROP CONSTRAINT IF EXISTS DRIVERSTANDINGS_DRIVERID_FKEY;

ALTER TABLE FORMULA1.DRIVERSTANDINGS
ADD CONSTRAINT DRIVERSTANDINGS_DRIVERID_FKEY FOREIGN KEY (DRIVERID) REFERENCES FORMULA1.DRIVERS (DRIVERID);

-- driverStandings, raceId 
ALTER TABLE FORMULA1.DRIVERSTANDINGS
DROP CONSTRAINT IF EXISTS DRIVERSTANDINGS_RACEID_FKEY;

ALTER TABLE FORMULA1.DRIVERSTANDINGS
ADD CONSTRAINT DRIVERSTANDINGS_RACEID_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- laptimes, raceid
ALTER TABLE FORMULA1.LAPTIMES
DROP CONSTRAINT IF EXISTS LAPTIMES_RACEID_FKEY;

ALTER TABLE FORMULA1.LAPTIMES
ADD CONSTRAINT LAPTIMES_RACEID_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- laptimes , driverid
ALTER TABLE FORMULA1.LAPTIMES
DROP CONSTRAINT IF EXISTS LAPTIMES_DRIVERID_FKEY;

ALTER TABLE FORMULA1.LAPTIMES
ADD CONSTRAINT LAPTIMES_DRIVERID_FKEY FOREIGN KEY (DRIVERID) REFERENCES FORMULA1.DRIVERS (DRIVERID);

-- pitstops.raceId
ALTER TABLE FORMULA1.PITSTOPS
DROP CONSTRAINT IF EXISTS PITSTOPS_RACEID_FKEY;

ALTER TABLE FORMULA1.PITSTOPS
ADD CONSTRAINT PITSTOPS_RACEID_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- pitstops.driverid
ALTER TABLE FORMULA1.PITSTOPS
DROP CONSTRAINT IF EXISTS PITSTOPS_DRIVERID_FKEY;

ALTER TABLE FORMULA1.PITSTOPS
ADD CONSTRAINT PITSTOPS_DRIVERID_FKEY FOREIGN KEY (DRIVERID) REFERENCES FORMULA1.DRIVERS (DRIVERID);

-- qualifying raceid  
ALTER TABLE FORMULA1.QUALIFYING
DROP CONSTRAINT IF EXISTS QUALIFYING_RACES_FKEY;

ALTER TABLE FORMULA1.QUALIFYING
ADD CONSTRAINT QUALIFYING_RACES_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);

-- qualifying,driverid
ALTER TABLE FORMULA1.QUALIFYING
DROP CONSTRAINT IF EXISTS QUALIFYING_DRIVERS_FKEY;

ALTER TABLE FORMULA1.QUALIFYING
ADD CONSTRAINT QUALIFYING_DRIVERS_FKEY FOREIGN KEY (DRIVERID) REFERENCES FORMULA1.DRIVERS (DRIVERID);

-- qualifying, constructorid
ALTER TABLE FORMULA1.QUALIFYING
DROP CONSTRAINT IF EXISTS QUALIFYING_CONSTRUCTORS_FKEY;

ALTER TABLE FORMULA1.QUALIFYING
ADD CONSTRAINT QUALIFYING_CONSTRUCTORS_FKEY FOREIGN KEY (CONSTRUCTORID) REFERENCES FORMULA1.CONSTRUCTORS (CONSTRUCTORID);

-- races, CIRCUITID
ALTER TABLE FORMULA1.RACES
DROP CONSTRAINT IF EXISTS RACES_CIRCUITID_FKEY;

ALTER TABLE FORMULA1.RACES
ADD CONSTRAINT RACES_CIRCUITID_FKEY FOREIGN KEY (CIRCUITID) REFERENCES FORMULA1.CIRCUITS(CIRCUITID);


-- RESULTS, CONSTRUCTORID
ALTER TABLE FORMULA1.RESULTS
DROP CONSTRAINT IF EXISTS RESULTS_CONSTRUCTORID_FKEY;

ALTER TABLE FORMULA1.RESULTS
ADD CONSTRAINT RESULTS_CONSTRUCTORID_FKEY FOREIGN KEY (CONSTRUCTORID) REFERENCES FORMULA1.CONSTRUCTORS(CONSTRUCTORID);

-- RESULTS, DRIVERID
ALTER TABLE FORMULA1.RESULTS
DROP CONSTRAINT IF EXISTS RESULTS_DRIVERS_FKEY;

ALTER TABLE FORMULA1.RESULTS
ADD CONSTRAINT RESULTS_DRIVERS_FKEY FOREIGN KEY (DRIVERID) REFERENCES FORMULA1.DRIVERS (DRIVERID);


-- RESULTS, RACEID
ALTER TABLE FORMULA1.RESULTS
DROP CONSTRAINT IF EXISTS RESULTS_RACES_FKEY;

ALTER TABLE FORMULA1.RESULTS
ADD CONSTRAINT RESULTS_RACES_FKEY FOREIGN KEY (RACEID) REFERENCES FORMULA1.RACES (RACEID);


-- sprintresults, raceid 
alter table formula1.sprintresults
drop constraint if exists sprintresults_raceid_fkey;

alter table formula1.sprintresults
add constraint sprintresults_raceid_fkey foreign key (raceId) references formula1.races (raceId)


-- sprintresults, driver id 
alter table formula1.sprintresults
drop constraint if exists sprintresults_driverid_fkey;

alter table formula1.sprintresults
add constraint sprintresults_driverid_fkey foreign key (driverId) references formula1.drivers (driverId)

-- sprintresults, constructors
alter table formula1.sprintresults
drop constraint if exists sprintresults_constructorid_fkey;

alter table formula1.sprintresults
add constraint sprintresults_constructorid_fkey foreign key (constructorId) references formula1.constructors (constructorId)



-- status 










