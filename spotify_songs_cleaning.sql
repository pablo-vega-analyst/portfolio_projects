-- Cleaning Most Popular Songs of 2024 Dataset

-- 1. Remove Duplicates

SELECT *
FROM spotify_songs.songs_table;

CREATE TABLE songs_table_staging
LIKE songs_table;

SELECT *
FROM spotify_songs.songs_table_staging;

INSERT songs_table_staging
SELECT *
FROM songs_table;

SELECT *
FROM songs_table_staging;

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY track, album_name, artist) AS row_num
FROM songs_table_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY track, album_name, artist) AS row_num
FROM songs_table_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM songs_table_staging
WHERE track = 'Espresso';

CREATE TABLE `songs_table_staging2` (
  `track` varchar(255) DEFAULT NULL,
  `album_name` varchar(255) DEFAULT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `release_date` varchar(255) DEFAULT NULL,
  `isrc` varchar(255) DEFAULT NULL,
  `all_time_rank` varchar(255) DEFAULT NULL,
  `track_score` varchar(255) DEFAULT NULL,
  `spotify_streams` bigint DEFAULT NULL,
  `spotify_playlist_count` varchar(255) DEFAULT NULL,
  `spotify_playlist_reach` varchar(255) DEFAULT NULL,
  `spotify_popularity` varchar(255) DEFAULT NULL,
  `youtube_views` varchar(255) DEFAULT NULL,
  `youtube_likes` varchar(255) DEFAULT NULL,
  `tiktok_posts` bigint DEFAULT NULL,
  `tiktok_likes` varchar(255) DEFAULT NULL,
  `tiktok_views` bigint DEFAULT NULL,
  `youtube_playlist_reach` varchar(255) DEFAULT NULL,
  `apple_music_playlist_count` varchar(255) DEFAULT NULL,
  `airplay_spins` varchar(255) DEFAULT NULL,
  `siriusxm_spins` varchar(255) DEFAULT NULL,
  `deezer_playlist_count` varchar(255) DEFAULT NULL,
  `deezer_playlist_reach` varchar(255) DEFAULT NULL,
  `amazon_playlist_count` varchar(255) DEFAULT NULL,
  `pandora_streams` varchar(255) DEFAULT NULL,
  `pandora_track_stations` varchar(255) DEFAULT NULL,
  `soundcloud_streams` varchar(255) DEFAULT NULL,
  `shazam_counts` varchar(255) DEFAULT NULL,
  `tidal_popularity` varchar(255) DEFAULT NULL,
  `explicit_track` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM songs_table_staging2;

INSERT INTO songs_table_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY track, album_name, artist, release_date, isrc, all_time_rank, track_score, spotify_streams,
spotify_playlist_count, spotify_playlist_reach, spotify_popularity, youtube_views, youtube_likes,
tiktok_posts, tiktok_likes, tiktok_views, youtube_playlist_reach, apple_music_playlist_count,
airplay_spins, siriusxm_spins, deezer_playlist_count, deezer_playlist_reach, amazon_playlist_count,
pandora_streams, pandora_track_stations, soundcloud_streams, shazam_counts, tidal_popularity, explicit_track) AS row_num
FROM songs_table_staging;

SELECT *
FROM songs_table_staging2
WHERE row_num > 1;

DELETE
FROM songs_table_staging2
WHERE row_num > 1;

-- 2. Standardize Data

UPDATE songs_table_staging2
SET track = TRIM(track);

UPDATE songs_table_staging2
SET album_name = TRIM(album_name);

UPDATE songs_table_staging2
SET artist = TRIM(artist);

UPDATE songs_table_staging2
SET `release_date` = STR_TO_DATE(`release_date`,'%m/%d/%Y');

ALTER TABLE songs_table_staging2
MODIFY COLUMN `release_date` DATE;

SELECT all_time_rank FROM songs_table_staging2 WHERE all_time_rank REGEXP '[^0-9]';

UPDATE songs_table_staging2
SET all_time_rank = REPLACE(all_time_rank,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN all_time_rank INT;

UPDATE songs_table_staging2
SET track_score = REPLACE(track_score,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN track_score INT;

SELECT *
FROM songs_table_staging2;

UPDATE songs_table_staging2
SET spotify_playlist_count = null
WHERE spotify_playlist_count = '';

UPDATE songs_table_staging2
SET spotify_playlist_count = REPLACE(spotify_playlist_count,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN spotify_playlist_count INT;

UPDATE songs_table_staging2
SET spotify_playlist_reach = null
WHERE spotify_playlist_reach = '';

UPDATE songs_table_staging2
SET spotify_playlist_reach = REPLACE(spotify_playlist_reach,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN spotify_playlist_reach INT;

UPDATE songs_table_staging2
SET spotify_popularity = null
WHERE spotify_popularity = '';

UPDATE songs_table_staging2
SET spotify_popularity = REPLACE(spotify_popularity,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN spotify_popularity INT;

UPDATE songs_table_staging2
SET youtube_views = null
WHERE youtube_views = '';

UPDATE songs_table_staging2
SET youtube_views = REPLACE(youtube_views,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN youtube_views BIGINT;

UPDATE songs_table_staging2
SET youtube_likes = null
WHERE youtube_likes = '';

UPDATE songs_table_staging2
SET youtube_likes = REPLACE(youtube_likes,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN youtube_likes INT;

UPDATE songs_table_staging2
SET tiktok_likes = null
WHERE tiktok_likes = '';

UPDATE songs_table_staging2
SET tiktok_likes = REPLACE(tiktok_likes,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN tiktok_likes BIGINT;

UPDATE songs_table_staging2
SET youtube_playlist_reach = null
WHERE youtube_playlist_reach = '';

UPDATE songs_table_staging2
SET youtube_playlist_reach = REPLACE(youtube_playlist_reach,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN youtube_playlist_reach BIGINT;

UPDATE songs_table_staging2
SET apple_music_playlist_count = NULL
WHERE apple_music_playlist_count = '';

UPDATE songs_table_staging2
SET apple_music_playlist_count = REPLACE(apple_music_playlist_count,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN apple_music_playlist_count INT;

UPDATE songs_table_staging2
SET airplay_spins = NULL
WHERE airplay_spins = '';

UPDATE songs_table_staging2
SET airplay_spins = REPLACE(airplay_spins,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN airplay_spins INT;

UPDATE songs_table_staging2
SET siriusxm_spins = NULL
WHERE siriusxm_spins = '';

UPDATE songs_table_staging2
SET siriusxm_spins = REPLACE(siriusxm_spins,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN siriusxm_spins INT;

UPDATE songs_table_staging2
SET deezer_playlist_count = NULL
WHERE deezer_playlist_count = '';

UPDATE songs_table_staging2
SET deezer_playlist_count = REPLACE(deezer_playlist_count,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN deezer_playlist_count INT;

UPDATE songs_table_staging2
SET deezer_playlist_reach = NULL
WHERE deezer_playlist_reach = '';

UPDATE songs_table_staging2
SET deezer_playlist_reach = REPLACE(deezer_playlist_reach,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN deezer_playlist_reach INT;

UPDATE songs_table_staging2
SET amazon_playlist_count = NULL
WHERE amazon_playlist_count = '';

UPDATE songs_table_staging2
SET amazon_playlist_count = REPLACE(amazon_playlist_count,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN amazon_playlist_count INT;

UPDATE songs_table_staging2
SET pandora_streams = NULL
WHERE pandora_streams = '';

UPDATE songs_table_staging2
SET pandora_streams = REPLACE(pandora_streams,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN pandora_streams INT;

UPDATE songs_table_staging2
SET pandora_track_stations = null
WHERE pandora_track_stations = '';

UPDATE songs_table_staging2
SET pandora_track_stations = REPLACE(pandora_track_stations,',','');

ALTER TABLE songs_table_staging2
MODIFY COLUMN pandora_track_stations INT;

UPDATE songs_table_staging2
SET soundcloud_streams = NULL
WHERE soundcloud_streams = '';

UPDATE songs_table_staging2
SET soundcloud_streams = REPLACE(soundcloud_streams, ',', '');

ALTER TABLE songs_table_staging2
MODIFY COLUMN soundcloud_streams INT;

UPDATE songs_table_staging2
SET shazam_counts = null
WHERE shazam_counts = '';

UPDATE songs_table_staging2
SET shazam_counts = REPLACE(shazam_counts, ',', '');

ALTER TABLE songs_table_staging2
MODIFY COLUMN shazam_counts INT;

UPDATE songs_table_staging2
SET tidal_popularity = NULL
WHERE tidal_popularity = '';

UPDATE songs_table_staging2
SET tidal_popularity = REPLACE(tidal_popularity, ',', '');

ALTER TABLE songs_table_staging2
MODIFY COLUMN tidal_popularity INT;

UPDATE songs_table_staging2
SET explicit_track = null
WHERE explicit_track = '';

UPDATE songs_table_staging2
SET explicit_track = 0
WHERE explicit_track IS NULL;

SELECT *
FROM songs_table_staging2;

-- 3. Address Null or Blank Values

SELECT *
FROM songs_table_staging2
WHERE track IS NULL
OR track = '';

SELECT *
FROM songs_table_staging2
WHERE album_name IS NULL
OR album_name = '';

SELECT *
FROM songs_table_staging2
WHERE artist IS NULL
OR artist = '';

-- 4. Remove Unecessary Columns or Rows

ALTER TABLE songs_table_staging2
DROP COLUMN row_num;