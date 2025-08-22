-- Detect exfiltration using multiple anomaly signals:
--   1) Large forward bytes (outbound volume)
--   2) High Flow Bytes/s (rate)
--   3) Very few backward packets (asymmetry)

WITH pct AS (
  SELECT
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY "Fwd Packets Length Total") AS p99_fwdlen,
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY "Flow Bytes/s")              AS p99_flowbytes,
    PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY "Total Backward Packets")    AS p10_bwdpkts
  FROM RAW_TRAFFIC
  WHERE "Fwd Packets Length Total" > 0
),
scored AS (
  SELECT
    r.*,
    (CASE WHEN r."Fwd Packets Length Total" >= pct.p99_fwdlen   THEN 1 ELSE 0 END) +
    (CASE WHEN r."Flow Bytes/s"              >= pct.p99_flowbytes THEN 1 ELSE 0 END) +
    (CASE WHEN r."Total Backward Packets"    <= pct.p10_bwdpkts  THEN 1 ELSE 0 END) AS signals
  FROM RAW_TRAFFIC r, pct
)
SELECT "Label",
       "Fwd Packets Length Total",
       "Flow Bytes/s",
       "Total Backward Packets",
       signals
FROM scored
WHERE signals >= 2
ORDER BY "Fwd Packets Length Total" DESC
LIMIT 50;

-- Count infiltration rows (note misspelling as "Infilteration")
SELECT "Label", COUNT(*) AS n
FROM RAW_TRAFFIC
WHERE UPPER("Label") LIKE '%INFIL%'
GROUP BY "Label";
