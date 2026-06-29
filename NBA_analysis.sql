-- NBA Player Performance Analysis
-- Dataset: NBA Players Data (Kaggle)
-- Season: 2022-23
-- Author: [Your Name]


-- Query 1: Top 10 Scorers
-- This query returns the top 10 scorers in the 2022-23 NBA season. Joel Embiid led 
-- the league with 33.1 points per game, making him the most valuable offensive asset 
-- among elite scorers that season. Opposing coaches should prioritize defensive schemes 
-- targeting Embiid and the other players on this list.


SELECT player_name,
       pts AS avg_points
FROM all_seasons
WHERE season = (SELECT MAX(season) FROM all_seasons)
ORDER BY pts DESC
LIMIT 10;


-- Query 2: Average Stats by Team
-- This query examines each NBA team's average points, rebounds, and assists per player.
-- The Phoenix Suns led with 10.8 average points per player despite having only 16 players.
-- Portland ranked 13th with 21 players, indicating roster size alone does not drive efficiency.


SELECT team_abbreviato,
       COUNT(*) AS num_players,
       ROUND(AVG(pts), 1) AS avg_points,
       ROUND(AVG(reb), 1) AS avg_rebounds,
       ROUND(AVG(ast), 1) AS avg_assists
FROM all_seasons
WHERE season = (SELECT MAX(season) FROM all_seasons)
GROUP BY team_abbreviato
ORDER BY avg_points DESC;


-- Query 3: Top Scorer Per Team
-- This query identifies the leading scorer on every NBA team in the 2022-23 season.
-- Joel Embiid topped the list at 33.1 points. Nikola Jokic led Denver at 24.5 points 
-- as a center, suggesting Denver should recruit a high-scoring guard to complement him.


WITH team_rankings AS (
    SELECT player_name,
           team_abbreviato,
           pts,
           RANK() OVER(PARTITION BY team_abbreviato ORDER BY pts DESC) AS team_rank
    FROM all_seasons
    WHERE season = (SELECT MAX(season) FROM all_seasons)
)
SELECT *
FROM team_rankings
WHERE team_rank = 1
ORDER BY pts DESC;


-- Query 4: Players Scoring Above Team Average
-- This query identifies players who scored significantly above their team's average.
-- Luka Doncic scored 24.2 points above Dallas's team average, revealing heavy roster 
-- reliance on one player and a significant vulnerability if Doncic is unavailable.


WITH player_vs_team AS (
    SELECT player_name,
           team_abbreviato,
           pts,
           AVG(pts) OVER(PARTITION BY team_abbreviato) AS team_avg_pts
    FROM all_seasons
    WHERE season = (SELECT MAX(season) FROM all_seasons)
)
SELECT player_name,
       team_abbreviato,
       ROUND(pts, 1) AS points,
       ROUND(team_avg_pts, 1) AS team_avg,
       ROUND(pts - team_avg_pts, 1) AS above_avg_by
FROM player_vs_team
WHERE pts > team_avg_pts
ORDER BY above_avg_by DESC;


-- Query 5: Youngest Player Per Team
-- This query surfaces the youngest player on each roster and their 2022-23 stats.
-- Paolo Banchero (age 20) averaged 20.0 points as Orlando's leading scorer, making him
-- a foundational piece for the Magic. Building a complementary roster around him 
-- should be the franchise's top priority heading into next season.


WITH youngest_players AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY team_abbreviato
               ORDER BY age
           ) AS rn
    FROM all_seasons
    WHERE season = '2022-23'
)
SELECT player_name,
       team_abbreviato,
       age,
       gp AS games_played,
       pts AS points_per_game,
       reb AS rebounds_per_game,
       ast AS assists_per_game
FROM youngest_players
WHERE rn = 1
ORDER BY team_abbreviato;