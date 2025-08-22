-- Detect repetitive flow patterns that suggest C2 beaconing

SELECT "Label",
       "Flow Duration",
       "Total Fwd Packets",
       "Total Backward Packets",
       COUNT(*) AS flow_pattern_count
FROM RAW_TRAFFIC
GROUP BY "Label", "Flow Duration", "Total Fwd Packets", "Total Backward Packets"
HAVING COUNT(*) > 100
ORDER BY flow_pattern_count DESC;

-- Optional: If you have IP columns, you could group by DstIP
-- SELECT "DstIP", COUNT(DISTINCT "SrcIP") AS unique_hosts, COUNT(*) AS flows
-- FROM RAW_TRAFFIC
-- GROUP BY "DstIP"
-- HAVING unique_hosts > 3;
