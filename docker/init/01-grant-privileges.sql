-- Grant TestUser full privileges for integration testing
-- This runs once when the container is first initialized

-- Grant ability to create/drop any database
GRANT CREATE, DROP ON *.* TO 'TestUser'@'%';

-- Grant all privileges on any database (using wildcards)
GRANT ALL PRIVILEGES ON `TestMain%`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `TestSecondary%`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `TongsTest%`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `DataTongsTest%`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `sakila%`.* TO 'TestUser'@'%';

-- Grant privileges for SchemaQuench integration test databases
GRANT ALL PRIVILEGES ON `ModifyConstraintTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `DropColumnsTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `AlterColumnTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `ModifyIndexTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `AddMissingItemsTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `MiscellaneousTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `CustomIndexTests`.* TO 'TestUser'@'%';
GRANT ALL PRIVILEGES ON `LargeSchemaTests`.* TO 'TestUser'@'%';

-- Grant INDEX privilege for creating/dropping indexes on any database
GRANT INDEX ON *.* TO 'TestUser'@'%';

-- Grant SYSTEM_USER privilege required for dropping/recreating functions
-- This is needed when ForgeKindler recreates functions with different DEFINERs
GRANT SYSTEM_USER ON *.* TO 'TestUser'@'%';

-- Grant SET_USER_ID to allow creating routines with any definer
GRANT SET_USER_ID ON *.* TO 'TestUser'@'%';

FLUSH PRIVILEGES;

-- Create marker table to signal init script has completed
-- The healthcheck verifies this table exists before reporting healthy
CREATE TABLE IF NOT EXISTS `TestMain`.`_init_complete` (
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO `TestMain`.`_init_complete` VALUES (NOW());
