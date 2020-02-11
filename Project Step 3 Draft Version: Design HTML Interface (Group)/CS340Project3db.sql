CREATE DATABASE mcnalld_CS340P3;
USE mcnalld_CS340P3;

/* Create tables for database */

/*LaunchDates: Records the details relating to a potential launch setting and environment. 

Day: date, unique, not NULL, PK
Location: varchar[50], not NULL
Weather: varchar[ 50 ], not NULL
Relationship: M:M relationship between LaunchDates and Rockets, bridged by the RocketLaunch table with Day as the FK inside RocketLaunch. 
*/

-- Create a new table called 'TableName' in schema 'SchemaName'
-- Drop the table if it already exists

CREATE TABLE mcnalld_CS340P3.LaunchDates
(
    Day DATE NOT NULL PRIMARY KEY, 
    Location VARCHAR(50) NOT NULL,
    Weather VARCHAR(50) NOT NULL 
);

/*
RocketLaunches: Many to many bridge table between rockets and launchdates

LaunchID: int, auto_increment, unique, not NULL, PK
Day: date, not NULL, PK, FK1
RocketName: varchar[ 50 ], not NULL, PK, FK2
Relationship: Serves as a bridge table between LaunchDates and Rockets with Day as the FK from LaunchDates and RocketName as the FK from Rockets. A launch date can have many rockets launched on it, and a rocket can be reused and launched again on another launch date. Note: A rocket would not be able to be recovered, reassembled and relaunched on the same day, as it takes weeks to months to recover, assess, repair, reassemble, prepare, and relaunch a rocket. 
*/
CREATE TABLE mcnalld_CS340P3.RocketLaunches
(
    LaunchID int not NULL  AUTO_INCREMENT,
    Day date not NULL Foreign Key
    RocketName varchar[ 50 ], not NULL FOREIGN KEY
    REFERENCES LaunchDates (Day), 
    REFERENCES Rockets (RocketName),
    Primary Key(LaunchID)

);

/*
Rockets: Table containing data relating to a full rocket

RocketName: varchar[ 50 ], unique, not NULL, PK
RocketLength: float, not NULL
MaxRocketDiameter: float, not NULL 
TotalWeight: float, not NULL
StageCount: int, not NULL
LaunchTime: datetime, not NULL
CompleteLandingTime: datetime, not NULL
Relationship: M:M relationship between LaunchDates and Rockets with, bridged by the RocketLaunch table with RocketName as the FK inside RocketLaunch. 1:M relationship between Rockets and Stages with RocketName serving as the FK inside Stages.
*/
CREATE TABLE mcnalld_CS340P3.Rockets
(
    RocketName varchar(50) not NULL Primary KEY,
    RocketLength float not NULL,
    MaxRocketDiameter float not NULL,
    TotalWeight float not NULL,
    StageCount int not NULL,
    LaunchTime datetime not NULL,
    CompleteLandingTime datetime not NULL
);

/*
Stages: Table containing data relating to various stages of a rocket. A rocket could contain 1 or more stages and can relate only to a single rocket. 

StageID: int, auto_increment, unique, not NULL, PK
RocketName: varchar[ 50 ], not NULL, FK 
FuelID: int, not NULL, FK
StageClass: varchar[ 50 ], not NULL
SeperationTime: datetime, not NULL
LandingTime: datetime not NULL
Relationship: 1:M relationship between Rockets and Stages with RocketName serving as the FK inside Stages. A rocket can be made up of many stages but a stage may only be part of 1 rocket. 1:1 relationship between Stages and StageParts with StageID serving as the FK inside StageParts. A stage may only have 1 set of parts and parts are only part of one stage. 1:1 between Stages and Telemetry with StageID serving as the FK inside of Telemetry. Each stage can only have a single set of Telemetry, and Telemetry can only be associated with a single stage. M:1 relationship between Stages and Fuel with FuelID serving at the FK within Stages. A stage can only use 1 kind of fuel but a kind of fuel can be used in many different stages.
*/
CREATE TABLE mcnalld_CS340P3.Stages
(
    StageID int not NULL Primary KEY auto_increment,
    RocketName varchar(50) not NULL FK
    FuelID int not NULL FK,
    StageClass varchar(50) not NULL,
    SeperationTime: datetime not NULL,
    LandingTime: datetime not NULL
);

/*
Fuels: Table containing information on the fuel used for a rocket stage. A stage can only use one type of fuel it was designed for but many stages can be designed for the same fuel type.

FuelsID: int, auto_increment, unique, not NULL, PK
FuelState: varchar[ 50 ], not NULL
Composition: varchar[ 50 ], not NULL
Relationship: 1:M relationship between Stages and Fuel with FuelID serving as the FK within Stages. A fuel can be used in many stages, but a stage is designed to utilize a single type of fuel.
*/
CREATE TABLE mcnalld_CS340P3.Fuels
(
    FuelsID int not NULL Primary Key auto increment,
    FuelState varchar(50) NOT NULL
    Composition varchar(50) NOT NULL
);

/*
StageParts: Information on the parts a rocket stage is comprised of.

StagePartsID: int, auto_increment, unique, not NULL, PK
StageID: int, not NULL, FK
Frame: varchar[ 50 ], not NULL
FinCount: int, not NULL
FinShape: varchar[ 50 ], not NULL
Engine: varchar[ 50 ], not NULL
AvionicsBay: varchar[ 50 ], not NULL
Coupling: varchar[ 50 ], not NULL
Relationship: 1:1 relationship between Stages and StageParts with StageID serving as the FK inside StageParts. A stage may only have 1 set of parts and parts are only part of one stage.
*/
CREATE TABLE mcnalld_CS340P3.StageParts
(
    StagePartsID int not NULL Primary Key auto_increment,
    StageID int not NULL FK
    Frame varchar(50) not NULL
    FinCount int not NULL
    FinShape varchar(50) not NULL
    Engine varchar(50) not NULL
    AvionicsBay varchar(50) not NULL
    Coupling varchar(50) not NULL
);

/*
Telemetries: Telemetry information of a rocket stage. 

TelemetryID: int, auto_increment, unique, not NULL, PK
StageID: int, not NULL, FK
AverageVelocity: float, not NULL
AverageAcceleration: float, not NULL
LandingLatitude: float, not NULL
LandingLongitude: float, not NULL
MaxFlightAngle: float, not NULL
Apogee: float, not NULL
Relationship: 1:1 between Stages and Telemetry with StageID serving as the FK inside of Telemetry. Each stage can only have a single set of Telemetry, and Telemetry can only be associated with a single stage.
*/
CREATE TABLE mcnalld_CS340P3.Telemetries
(
    TelemetryID int not NULL Primary Key auto_increment,
    StageID int not NULL FK,
    AverageVelocity float not NULL,
    AverageAcceleration float not NULL,    
    LandingLatitude float not NULL,
    LandingLongitude float not NULL,
    MaxFlightAngle float not NULL,
    Apogee: float not NULL
);

/* Insert into tables */

mysql -u root -p
GRANT ALL PRIVILEGES ON *.* TO 'mcnalld'@'localhost' IDENTIFIED BY '7000';
\q