# Threat Hunting in Snowflake with CIC-IDS2018 (Wednesday Infiltration)

Cloud-based threat hunting using Snowflake as a security data lake.

**Findings**
- Infilteration (misspelled) ≈ 56k rows; exfil outliers confirmed
- Botnet repetitive/clustered flows present
- Brute force: none observed in this subset

## Repo Contents
- `queries/` – setup & hunts
- `docs/hunt_reports.md` – hypothesis → query → evidence → conclusion
- `images/` – screenshots (add via GitHub UI)
- `data/README.md` – how to get the dataset (no large files in repo)

## Quick Start (Snowflake)
1. Run `queries/00_setup_env.sql`
2. Upload Parquet/CSV to stage; run `queries/01_load_parquet_or_csv.sql`
3. Run hunts:
   - Exfiltration: `queries/10_hunt_infiltration_exfil.sql`
   - Botnet C2: `queries/20_hunt_botnet_c2.sql`
   - Brute Force: `queries/30_hunt_bruteforce.sql`

## MITRE ATT&CK Mapping
- Exfiltration → TA0010 (e.g., T1041)
- Command & Control → TA0011 (e.g., T1071)
- Credential Access (not seen here) → TA0006 (T1110)

## Notes
- CIC-IDS2018 often spells the label as `Infilteration`. Queries handle this.
- No large data stored in repo.
