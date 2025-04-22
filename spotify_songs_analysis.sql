-- Exploratory Analysis of Most Popular Songs of 2024 Dataset

SELECT *
FROM songs_spotify_staging2;

SELECT *
FROM songs_table_staging2
ORDER BY spotify_streams DESC
LIMIT 1;

SELECT *
FROM songs_table_staging2
ORDER BY spotify_streams DESC
LIMIT 10;

SELECT track, album_name, artist, release_date, spotify_streams, tiktok_posts, tiktok_views, pandora_streams
FROM songs_table_staging2
ORDER BY spotify_streams DESC LIMIT 100;

DELETE
FROM songs_table_staging2
WHERE artist = 'xSyborg';

SELECT track, artist, release_date, spotify_streams, tiktok_posts, tiktok_views
FROM songs_table_staging2
ORDER BY tiktok_posts DESC LIMIT 100;

SELECT track, artist, release_date, spotify_streams, tiktok_posts, tiktok_views,
DENSE_RANK() OVER(ORDER BY tiktok_views DESC) AS `rank`
FROM songs_table_staging2
LIMIT 100;

SELECT track, artist, release_date, spotify_streams, tiktok_posts, tiktok_views,
DENSE_RANK() OVER(ORDER BY spotify_streams DESC) AS `rank`
FROM songs_table_staging2
LIMIT 100;

SELECT track, artist, release_date, spotify_streams, tiktok_posts, tiktok_views,
DENSE_RANK() OVER(ORDER BY spotify_streams DESC) AS `rank`
FROM songs_table_staging2
WHERE YEAR(release_date) = '2024'
LIMIT 100;

DELETE
FROM songs_table_staging2
WHERE track = 'Danza Kuduro - Cover' AND artist = 'MUSIC LAB JPN' AND release_date = '2024-06-09';

DELETE
FROM songs_table_staging2
WHERE track = 'Danza Kuduro - Cover' AND artist = 'MUSIC LAB JPN' AND release_date = '2024-04-29';

DELETE
FROM songs_table_staging2
WHERE track = 'Danza Kuduro - Cover' AND artist = 'MUSIC LAB JPN' AND release_date = '2024-05-21';

# the artist ati2x06 is associated with songs that aren't there's.
# the songs that are associated with them in this datatable aren't even listed with them on Spotify anymore.
SELECT *
FROM songs_table_staging2
WHERE artist = 'ati2x06';

DELETE
FROM songs_table_staging2
WHERE artist = 'ati2x06';

SELECT MAX(release_date)
FROM songs_table_staging2;

SELECT artist,
	SUM(spotify_streams) as total_streams,
    DENSE_RANK() OVER(ORDER BY SUM(spotify_streams) DESC) AS `rank`
FROM songs_table_staging2
GROUP BY artist
LIMIT 100;

WITH artist_total_streams AS
(
SELECT artist,
	SUM(spotify_streams) as total_streams,
    DENSE_RANK() OVER(ORDER BY SUM(spotify_streams) DESC) AS `rank`
FROM songs_table_staging2
GROUP BY artist
)
SELECT *
FROM artist_total_streams
WHERE artist = 'Sabrina Carpenter';
