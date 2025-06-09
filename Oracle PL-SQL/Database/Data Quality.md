---

## 📊 Data Quality Checks to Analyze in Oracle PL/SQL Development

| #  | 🟢 | Check Type                        | Description / What to Analyze                                                                                 |
|----|-----|-----------------------------------|---------------------------------------------------------------------------------------------------------------|
| 1  | 🔍  | Data Completeness                 | Ensure mandatory fields are not empty, NOT NULL columns are filled, key relationships exist, all expected records present |
| 2  | 🔗  | Referential Integrity             | Validate all foreign key values exist in referenced tables, detect orphan records, ensure parent-child integrity |
| 3  | 🔁  | Uniqueness                       | Ensure no duplicate records or key violations, check primary/unique constraints                                |
| 4  | ⛔  | Domain Constraints                | Values fall within acceptable ranges/lists, status columns have only allowed values, dates within business rules |
| 5  | 📆  | Date/Time Validity                | Dates make logical/business sense (e.g., no future DOBs, start ≤ end date)                                    |
| 6  | 🔢  | Data Type Consistency             | Values match expected formats, e.g., email, phone, numeric fields not stored as text                          |
| 7  | 🔄  | Cross-field Validation            | Logical consistency between fields (e.g., payment_status = 'Paid' ⇒ payment_date NOT NULL)                    |
| 8  | 📈  | Data Duplication                  | Detect full/partial record duplicates, fuzzy duplicates using multiple columns                                 |
| 9  | 💾  | Metadata Consistency              | Match metadata definitions with actual usage, column types/descriptions appropriate                            |
| 10 | 📊  | Statistical Profiling             | Profile for outliers/unexpected distributions, min/max/avg, spikes in time-series                             |
| 11 | ⚠️  | Business Rule Validation          | Validate against business requirements (e.g., price ≥ cost, discount ≤ max allowed)                           |
| 12 | 🛡️  | Security & Sensitivity Checks     | Sensitive data is masked/encrypted, audit for unauthorized access                                             |
| 13 | 🧪  | ETL/Data Migration Validation      | Source vs. target record count match, field-level data match, transformation rules verified                   |
| 14 | 🔄  | Update/Deletion Integrity         | Track impact of updates/deletions, cascades work as expected, audit tables capture changes                    |
| 15 | 🔁  | Consistency Across Tables         | Data is consistent between related tables/systems (e.g., product codes match master table)                    |
| 16 | 📤  | Data Volatility Checks            | Data changes at expected rate, historical data doesn’t change unless allowed                                  |
| 17 | 🕵️  | Audit Trail Completeness          | Every transaction/change is logged, triggers/audit tables are complete                                        |
| 18 | 🧩  | Surrogate Key Gaps/Collisions     | Check for gaps/collisions in sequences or surrogate keys                                                      |
| 19 | 📁  | Archive vs. Live Data Validations | Archived data mirrors original, no duplicates between archive and live                                        |
| 20 | 🗂️  | Hierarchical Integrity            | Parent-child hierarchies are intact, no circular references, single parent per node                           |
| 21 | 📏  | Truncation or Overflow Checks     | Detect values exceeding column sizes or truncated (esp. strings, numbers, CLOBs)                              |
| 22 | 🪪  | Identity Consistency Checks        | Identity fields (Aadhar/PAN) are unique and well-formed across tables                                         |
| 23 | ⏱️  | Timeliness/Latency Checks         | Data arrives within expected time windows, detect stale/delayed data                                          |
| 24 | 🔍  | Data Provenance / Lineage         | Validate origin and transformations of data, lineage metadata matches actual flow                             |
| 25 | 📚  | Lookup Table Validation           | Values exist in master/reference data (e.g., status codes in lookup table)                                   |
| 26 | 🔐  | PII Detection                     | PII is properly stored, encrypted or masked                                                                  |
| 27 | 🧠  | Semantics/Label Accuracy          | Field names match what data represents (e.g., salary ≠ net pay)                                              |
| 28 | 🧮  | Aggregate Accuracy                | Cross-check summary vs. detail records (e.g., invoice total = sum of line items)                             |
| 29 | 🧾  | Format Standardization            | Strings follow consistent formats (e.g., title case, YYYY-MM-DD, uppercase codes)                            |
| 30 | ⏳  | Historical Data Integrity          | Older data not unintentionally altered, lock old partitions, compare hash/timestamp snapshots                 |
| 31 | 🧪  | Rule-Based Thresholds             | Set thresholds for anomalies/alerts (e.g., % of NULLs, record count drops)                                   |
| 32 | 💼  | Role-Based Access Validation      | Users have access only to authorized data, view/row-level security                                           |
| 33 | 📤  | File/Data Load Consistency        | File header/footer exists, record count matches, no duplicate batch imports                                  |
| 34 | 🔀  | Data Drift Detection              | Compare current data distribution to historical, detect silent pattern shifts                                |
| 35 | 🛠️  | Transformation Rule Fidelity      | ETL rules applied accurately (e.g., NULL replaced with 'NA', decimals rounded)                               |

---

## ✅ Fundamental Data Quality Checks (Core-Level)

| #  | 🟢 | Check Type                | Description / What to Analyze                                                                                 |
|----|-----|--------------------------|---------------------------------------------------------------------------------------------------------------|
| 1  | 🟢  | Null Checks              | Critical fields are not null (required fields, FKs, PKs)                                                      |
| 2  | 🟢  | Primary Key Validation   | No nulls or duplicates in primary key columns                                                                 |
| 3  | 🟢  | Foreign Key Validation   | Foreign keys exist in parent table                                                                            |
| 4  | 🟢  | Unique Constraint Validation | Unique columns or groups are truly unique                                                                 |
| 5  | 🟢  | Data Type Accuracy       | Stored values conform to intended data type (e.g., integer, date)                                             |
| 6  | 🟢  | Default Value Validation | Default values not causing incorrect assumptions (e.g., salary = 0)                                           |
| 7  | 🟢  | Allowed Value List (Domain Check) | Values fall within expected list (e.g., status, gender)                                                 |
| 8  | 🟢  | Length and Format Checks | Values within expected length or match patterns (e.g., email, zip code)                                       |
| 9  | 🟢  | Range Checks             | Numeric/date values within acceptable range (e.g., age, order date)                                           |
| 10 | 🟢  | Cross-Column Consistency | Logical consistency between fields (e.g., end_date after start_date)                                          |
| 11 | 🟢  | Record Count Check       | Row count matches expectations (sanity check)                                                                 |
| 12 | 🟢  | Duplicate Row Detection  | Detect rows that are entirely duplicated                                                                      |
| 13 | 🟢  | Blank (Whitespace) Values| Detect empty strings that are not NULL but still invalid                                                      |
| 14 | 🟢  | Boolean/Flag Field Validation | Flags contain only valid values (e.g., 0 or 1)                                                          |
| 15 | 🟢  | Consistency Between Related Tables | Child rows aligned with parent status                                                                 |
| 16 | 🟢  | Hardcoded or Placeholder Data | Detect test values/defaults in production (e.g., 'test@test.com')                                      |
| 17 | 🟢  | Case Sensitivity Consistency | Check for case inconsistencies (e.g., 'john', 'JOHN')                                                  |
| 18 | 🟢  | Truncation or Data Overflow Detection | Find text cut off due to column length limits                                                      |
| 19 | 🟢  | Special Character or Encoding Check | Ensure no unexpected characters in data (esp. names, IDs)                                           |
| 20 | 🟢  | Negative Value Check      | No negative values in fields that should be positive (e.g., salary, quantity)                              |

---

## 🧠 Advanced Checks Deeply Linked to Data Fundamentals

| #  | 🟢 | Check Type                        | Description / What to Analyze                                                                                 |
|----|-----|-----------------------------------|---------------------------------------------------------------------------------------------------------------|
| 1  | 🔍  | Contextual Nullability Check      | Nullable fields required based on context (e.g., end_date NULL only if status = 'Active')                     |
| 2  | 🧩  | Soft Uniqueness Violation         | Columns not officially UNIQUE but should behave uniquely under certain filters                                |
| 3  | 🧠  | Smart Default Detection           | Identify where default values (like 0 or 'NA') are misused as real data                                       |
| 4  | ⏳  | Temporal Gap/Overlap in Sequences | Missing or overlapping sequences in time-ordered data (logs, sessions)                                        |
| 5  | 🔐  | Hardcoded Placeholder Identification | Detect values left from test/stub data (e.g., 'test@test.com', '1234567890')                             |
| 6  | 🔀  | Value Flip Inconsistency          | Mutually exclusive fields active simultaneously (e.g., is_debit = 1 AND is_credit = 1)                        |
| 7  | 🧮  | Cumulative Inconsistency Check    | Cumulative/summary fields match base data (e.g., order total = sum of line items)                             |
| 8  | 🎯  | Condition-Based Domain Validation | Some values valid only when another column has a specific value (e.g., payment_type = 'CARD' ⇒ card_number NOT NULL) |
| 9  | 📜  | Data Type Format Check Beyond SQL Types | Data appears correct at type level but fails format rules (e.g., PAN, date string)                      |
| 10 | 📐  | Range Tightness Check             | Valid range is tight enough to flag anomalies (e.g., age 18-70, not just 0-150)                               |
| 11 | 🔄  | Reverse Mapping Validity          | Reverse relationship holds true (e.g., manager_id exists as employee_id)                                      |
| 12 | 🕓  | Null-with-Timestamp Anomaly       | NULL field alongside a populated timestamp is suspicious                                                      |
| 13 | 🔁  | Duplicated Values After Normalization | Duplicate entries differing only in case, accents, or whitespace                                         |
| 14 | 📉  | Cardinality Pressure Check        | Columns should have limited distinct values (e.g., gender, status)                                            |
| 15 | 🧠  | Logic-Driven Mandatory Fields     | Fields mandatory only if others have a certain value (e.g., is_insured = 'Y' ⇒ insurance_policy_no required)  |

---

## 📌 Summary Table: Advanced Checks on Fundamentals

| 🟢 | Check Type                      | Fundamental Link         | Use Case                                 |
|-----|--------------------------------|-------------------------|------------------------------------------|
| 🔍  | Contextual Nullability         | Null Constraints        | Conditional requirement of data          |
| 🧩  | Soft Uniqueness                | Uniqueness              | Business-logic based uniqueness          |
| 🧠  | Misused Default Values         | Defaults                | Detecting fake real data                 |
| ⏳  | Overlaps and Gaps in Time      | Temporal Logic          | Bookings, contracts, logs                |
| 🔐  | Test/Placeholder Detection     | Validity                | Test or junk data left behind            |
| 🔀  | Mutually Exclusive Flags       | Logic Consistency       | Contradictory flags                      |
| 🧮  | Derived Field Verification     | Accuracy                | Ensures stored computed fields are correct|
| 📜  | Format-Based Domain Check      | Type Integrity          | Pattern enforcement                      |
| 🔁  | Case/Whitespace Duplicate Check| Uniqueness              | Inconsistent casing                      |
| 📐  | Range Tightness                | Validity                | Detecting realistic ranges               |
| 🔄  | Reverse FK Check               | Referential Integrity   | Managers, parents, etc.                  |
| 🕓  | Timestamp without Value        | Completeness            | Misuse of NULL fields                    |
| 📉  | Value Explosion Check          | Domain Integrity        | Detect typos and new junk values         |
| 🧠  | Logic-Driven Mandatory Fields  | Completeness            | Conditional field presence               |