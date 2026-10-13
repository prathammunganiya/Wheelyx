-- =====================================================================
-- Wheelyx Vehicle Rental and Fleet Management Platform
-- Performance Indexes: indexes.sql
-- =====================================================================

USE wheelyx_vehicle_rental;

DELIMITER $$

DROP PROCEDURE IF EXISTS CreateIndexIfNotExists $$
CREATE PROCEDURE CreateIndexIfNotExists(
    IN tableName VARCHAR(64),
    IN indexName VARCHAR(64),
    IN columnList VARCHAR(255)
)
BEGIN
    DECLARE idxCount INT;
    SELECT COUNT(*) INTO idxCount
    FROM information_schema.statistics
    WHERE table_schema = DATABASE()
      AND table_name = tableName
      AND index_name = indexName;

    IF idxCount = 0 THEN
        SET @sqlStatement = CONCAT('CREATE INDEX ', indexName, ' ON ', tableName, ' (', columnList, ')');
        PREPARE stmt FROM @sqlStatement;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

DELIMITER ;

-- Create search optimization indexes safely
CALL CreateIndexIfNotExists('vehicles', 'idx_vehicles_search', 'city_id, category_id, status');
CALL CreateIndexIfNotExists('vehicles', 'idx_vehicles_fuel', 'fuel_type');
CALL CreateIndexIfNotExists('vehicles', 'idx_vehicles_price', 'price_per_day');
CALL CreateIndexIfNotExists('vehicles', 'idx_vehicles_featured', 'is_featured');
CALL CreateIndexIfNotExists('bookings', 'idx_bookings_vehicle_dates', 'vehicle_id, start_date, end_date, status');
CALL CreateIndexIfNotExists('rentals', 'idx_rentals_status', 'status');
CALL CreateIndexIfNotExists('vehicle_locations', 'idx_vehicle_locations_tracking', 'vehicle_id, recorded_at');
CALL CreateIndexIfNotExists('maintenance', 'idx_maintenance_vehicle_dates', 'vehicle_id, start_date, end_date, status');

DROP PROCEDURE IF EXISTS CreateIndexIfNotExists;
