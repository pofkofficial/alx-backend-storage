-- Active: 1695137323808@@127.0.0.1@3306@holberton
-- SQL script that creates a stored procedure AddBonus
-- that adds a new correction for a student.
-- Requirements:
-- Procedure AddBonus is taking 3 inputs (in this order):
-- user_id, a users.id value (you can assume user_id is linked to an existing users)
-- project_name, a new or already exists projects -
-- if no projects.name found in the table, you should create it
-- score, the score value for the correction

DELIMITER $$

CREATE PROCEDURE AddBonus(
    IN user_id INT,
    IN project_name VARCHAR(255),
    IN score INT
)
BEGIN
    -- Check if the project exists, and if not, insert it
    IF NOT EXISTS(SELECT name FROM projects WHERE name = project_name) THEN
        INSERT INTO projects (name) VALUES (project_name);
    END IF;

    -- Insert into corrections, using a subquery to get the project ID
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (
        user_id,
        (SELECT id FROM projects WHERE name = project_name),
        score
    );
END $$

DELIMITER ;
