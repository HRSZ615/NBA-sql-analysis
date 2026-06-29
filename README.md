# NBA Player Performance Analysis — 2022-23 Season

## Overview
This project analyzes 2022-23 NBA player and team performance data using SQL. The goal was to uncover scoring trends, team efficiency patterns, and young player development insights using a real-world public dataset.

## Dataset
- **Source:** [NBA Players Data — Kaggle](https://www.kaggle.com/datasets/justinas/nba-players-data)
- **Coverage:** NBA seasons up to 2022-23
- **Tool:** SQLiteOnline

## Skills Demonstrated
- SELECT, WHERE, GROUP BY, HAVING
- INNER JOIN and LEFT JOIN
- Window Functions (RANK, ROW_NUMBER, AVG OVER PARTITION BY)
- Common Table Expressions (CTEs)
- Subqueries and aggregations

## Queries & Findings

### Query 1 — Top 10 Scorers
Identified the highest-scoring players in the 2022-23 season. Joel Embiid led the league at 33.1 points per game, making him the most valuable offensive asset that season. Results provide a foundation for defensive game planning against elite scorers.

### Query 2 — Average Stats by Team
Examined each team's average points, rebounds, and assists per player. The Phoenix Suns led with 10.8 average points per player despite having one of the smaller rosters (16 players), while Portland ranked 13th with 21 players — indicating roster size alone does not drive team efficiency.

### Query 3 — Top Scorer Per Team
Used a CTE and RANK window function to surface the leading scorer on every team. Joel Embiid topped the list at 33.1 points, while Nikola Jokic led Denver at 24.5 points despite playing center — suggesting Denver could benefit from adding a high-scoring guard.

### Query 4 — Players Scoring Above Team Average
Used AVG as a window function partitioned by team to compare each player against their team's average. Luka Doncic scored 24.2 points above the Dallas Mavericks' team average, revealing a significant roster imbalance and heavy reliance on a single player.

### Query 5 — Youngest Player Per Team
Used ROW_NUMBER partitioned by team and ordered by age to identify the youngest player on each roster. Paolo Banchero (20, Orlando Magic) stood out as already his team's leading scorer, representing a strong developmental foundation for the franchise.

## Author
Business Analytics Student — Farmingdale State College  
Self-directed SQL learning project, Summer 2026
