CREATE TABLE Spotify_1
LIKE spotify_dataset;

INSERT INTO spotify_1
SELECT*
FROM spotify_dataset;

SELECT*
FROM spotify_1;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY Spotify_id, `Name`, Artists, Daily_rank, Daily_movement, 
Weekly_movement, Country, Snapshot_date, Popularity, Is_explicit, Duration_ms, Album_name,
Album_release_date, Danceability, Energy, `Key`, Loudness, `Mode`, Speechiness, Acousticness, 
Instrumentalness, Liveness, Valence, Tempo, Time_signature
ORDER BY Spotify_id) AS Row_Num
FROM spotify_1;

WITH Spotify_CTE AS
(SELECT*,
ROW_NUMBER() OVER(PARTITION BY Spotify_id, `Name`, Artists, Daily_rank, Daily_movement, 
Weekly_movement, Country, Snapshot_date, Popularity, Is_explicit, Duration_ms, Album_name,
Album_release_date, Danceability, Energy, `Key`, Loudness, `Mode`, Speechiness, Acousticness, 
Instrumentalness, Liveness, Valence, Tempo, Time_signature
ORDER BY Spotify_id) AS Row_Num
FROM spotify_1)
SELECT*
FROM Spotify_CTE
WHERE Row_Num <> 1;

SELECT Spotify_id, TRIM(Spotify_id)
FROM spotify_1;

UPDATE spotify_1
SET Spotify_id = TRIM(Spotify_id);

UPDATE spotify_1
SET `Name` = TRIM(`Name`);

UPDATE spotify_1
SET Artists = TRIM(Artists);

UPDATE spotify_1
SET Is_explicit = TRIM(Is_explicit);

UPDATE spotify_1
SET Album_name = TRIM(Album_name);

SELECT*
FROM spotify_1;

SELECT Snapshot_date, STR_TO_DATE(Snapshot_date, '%m/%d/%Y')
FROM spotify_1;

UPDATE spotify_1
SET Snapshot_date = STR_TO_DATE(Snapshot_date, '%m/%d/%Y');

UPDATE spotify_1
SET Album_release_date = STR_TO_DATE(Album_release_date, '%m/%d/%Y');

ALTER TABLE spotify_1
MODIFY COLUMN Snapshot_date DATE;

ALTER TABLE spotify_1
MODIFY COLUMN Album_release_date DATE;

SELECT Daily_rank, Daily_movement
FROM spotify_1
WHERE Daily_rank IS NULL
AND Daily_movement IS NULL;

SELECT Daily_rank, Daily_movement
FROM spotify_1
WHERE Daily_rank = ''
AND Daily_movement = '';

SELECT*
FROM spotify_1;

UPDATE spotify_1
SET Daily_rank = TRIM(Daily_rank);

SELECT Country
FROM spotify_1
WHERE Country = '';

UPDATE spotify_1
SET Country = NULL
WHERE Country = '';

SELECT Country
FROM spotify_1;

UPDATE spotify_1
SET Daily_movement = TRIM(Daily_movement);

UPDATE spotify_1
SET Duration_ms = TRIM(Duration_ms);

SELECT S1.Spotify_id, S1.`Name`, S1.Artists, S1.Daily_rank, S1.Daily_movement, 
S1.Weekly_movement, S1.Country, S1.Snapshot_date, S1.Popularity, S1.Is_explicit, S1.Duration_ms, S1.Album_name,
S1.Album_release_date
FROM spotify_1 AS S1
JOIN spotify_dataset AS S2
	ON S1.`Name` = S2.`Name`
ORDER BY S1.Artists;

SELECT COUNT(`Name`)
FROM spotify_1
where `Name` =
'????????';

DELETE
FROM spotify_1
WHERE `Name` =
'????????';


