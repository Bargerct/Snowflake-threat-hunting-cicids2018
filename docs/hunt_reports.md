# Threat Hunt Reports

## Hunt 1 — Infiltration / Exfiltration
Hypothesis: A compromised host will send unusually large outbound flows.  
Query: see `queries/10_hunt_infiltration_exfil.sql`  
Evidence: ~56,449 rows labeled **Infilteration**, dominated by outlier forward packet lengths.  
Conclusion: Confirmed exfiltration behavior.

## Hunt 2 — Botnet C2 Beaconing
Hypothesis: Multiple hosts beacon to the same external C2 server.  
Query: see `queries/20_hunt_botnet_c2.sql`  
Evidence: Large clusters of repeated flow patterns with label **Bot**.  
Conclusion: Confirmed botnet C2 beaconing.

## Hunt 3 — Brute Force
Hypothesis: Multiple repeated short flows indicate credential brute-force.  
Query: see `queries/30_hunt_bruteforce.sql`  
Evidence: None in this subset.  
Conclusion: No brute-force observed in the Wednesday data.
