Drop Table formula1.constructor_standings;


CREATE TABLE formula1.constructor_results (
    constructorResultsId SERIAL PRIMARY KEY,  
    raceId INTEGER,                 
    constructorId INTEGER,           
    points DOUBLE PRECISION,                          
    status VARCHAR(50)                        
);

CREATE TABLE formula1.constructor_standings (
    constructorStandingsId SERIAL PRIMARY KEY,   -- Auto-incrementing ID
    raceId INTEGER NOT NULL,                     -- Reference to the race
    constructorId INTEGER NOT NULL,              -- Reference to the constructor
    points DOUBLE PRECISION,                                -- Points (nullable)
    position INTEGER,                            -- Position (nullable)
    positionText Varchar(50),                    -- Position as text (nullable)
    wins INTEGER                                 -- Wins (nullable)
);


