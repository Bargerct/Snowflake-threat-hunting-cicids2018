-- Look for brute-force attempts (SSH/FTP)
-- In this dataset, the Wednesday infiltration file likely has none,
-- but we include this hunt for completeness.

SELECT "Label", COUNT(*) AS attempts,
       AVG("Flow Duration") AS avg_duration
FROM RAW_TRAFFIC
WHERE UPPER("Label") LIKE '%BRUTE%'
GROUP BY "Label"
ORDER BY attempts DESC;

-- Optional heuristic if labels unavailable: many short flows to same service
-- SELECT "DstPort", "SrcIP", "DstIP", COUNT(*) AS connection_attempts
-- FROM RAW_TRAFFIC
-- WHERE "Flow Duration" < 10000  -- very short connections
-- GROUP BY "DstPort", "SrcIP", "DstIP"
-- HAVING COUNT(*) > 100
-- ORDER BY connection_attempts DESC;
