-- SQL script that creates a stored procedure ComputeAverageScoreForUser
DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE avg_score FLOAT;

    -- Calculate the average score
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE corrections.user_id = user_id;

    -- Update the user's average score
    UPDATE users
    SET average_score = avg_score
    WHERE users.id = user_id;
END $$

DELIMITER ;
