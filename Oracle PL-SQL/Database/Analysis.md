## 🧑‍💻 What are worst mistakes a fresher can make and makes as an Oracle PL/SQL developer during the analysis of the requirements given before development begins?

| #  | 🟢 | Mistake                                                      | Impact                                                        | Fix-Best Practice                                                                                  |
|----|-----|--------------------------------------------------------------|---------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| 1  | 🤔  | Not Clarifying Business Logic                                | Incorrect procedures/functions that don't match use cases      | Ask detailed "what-if" and boundary condition questions to clarify all scenarios                   |
| 2  | 🐢  | Ignoring Data Volume and Performance Requirements            | Slow-performing queries or memory issues                       | Ask about data scale (rows per table, frequency of execution)                                      |
| 3  | 🔗  | Skipping Data Relationships (Foreign Keys, Joins)            | Incorrect joins, duplicate or missed data                      | Review ER diagrams or table DDLs, clarify parent-child relations                                   |
| 4  | 📝  | Not Identifying Input/Output Clearly                         | Wrong/incomplete parameter definitions                         | Document all inputs, outputs, types, and validations during analysis                               |
| 5  | ⚠️  | Neglecting Exception and Edge Case Handling                  | Procedures fail or behave unpredictably                        | Ask “what if?” for every scenario. Define exception rules with the business or analyst             |
| 6  | ♻️  | Not Reviewing Existing Code or Standards                     | Redundant code, poor integration                               | Always ask if similar logic exists or if there are reusable components                             |
| 7  | 🧩  | Underestimating Dependencies (Triggers, Jobs, Views)         | Code breaks or causes side-effects in production               | Identify all dependent objects early and understand their behavior                                 |
| 8  | 🔄  | Ignoring Transactional Requirements                          | Data inconsistencies or uncommitted records                    | Ask when to persist changes, and how to handle partial failures                                    |
| 9  | 🏷️  | Failure to Confirm Environment/Version Details               | Using unsupported features                                     | Ask about Oracle DB version and feature availability                                               |
| 10 | 🗺️  | Not Creating a Pseudocode or Flow Before Coding              | Poorly designed code, hard to debug or extend                  | Always draft pseudocode or flowcharts to validate understanding                                    |
| 11 | 📚  | Lack of Documentation During Analysis                        | Memory-based coding, missing clarity during peer reviews       | Write a basic design document or requirement mapping before coding begins                          |



## 🧩 How to figure out the edge cases for any requirement?

| Step | 🟢 | Technique/Category                | Description / Example                                                                                         |
|------|-----|-----------------------------------|---------------------------------------------------------------------------------------------------------------|
| 1    | 🛤️  | Start With the Core Functional Flow | Understand the happy path, then disrupt it step-by-step                                                       |
| 2    | ❓  | Use the "What If" Technique         | Ask: What if input is null, empty, negative, too long, special chars? What if referenced records don't exist? |
| 3    | 🚧  | Look at Data Boundaries             | Test NULL, 0, -1, max/min dates, VARCHAR2 max length, CLOB/BLOB, empty cursors                                |
| 4    | 🕵️  | Reverse Engineer the Requirement    | Try to "break" the requirement, input valid-looking but wrong data, malicious attempts                        |
| 5    | 🐞  | Review Past Bugs or Production Issues | Check logs/test histories for recurring edge cases (date mismatches, null FKs, precision issues)              |
| 6    | 💥  | Model With Extreme Data             | Try with zero, 1, 10, or a million rows; invalid FKs, wrong status codes, wrong date formats                  |
| 7    | 🗂️  | Common Edge Case Categories         | See table below                                                                                               |
| 8    | 👩‍🔬 | Talk to QA/Test Engineers           | Ask how they test similar modules and what scenarios they include                                             |
| 9    | 🧠  | Use Mind Maps or Tables             | Example scenarios: missing field, invalid format, duplicate insert, nulls, overlapping dates, large volumes   |
| 10   | 🔁  | Leverage Pseudocode for Loops       | What if loop runs zero times? What if cursor fetch throws NO_DATA_FOUND?                                      |

**Common Edge Case Categories**

| 🟢 | Category            | Sample Edge Case                                  |
|-----|---------------------|---------------------------------------------------|
| 🚫  | Null Handling       | Input is NULL or missing                          |
| 🔁  | Duplicates         | Same record submitted multiple times               |
| 🎯  | Precision          | 0.00001 vs. 10000000                              |
| 💥  | Data Type Overflow | Numbers too large for NUMBER(5)                    |
| 📅  | Date Logic         | End date before start date                         |
| 🔄  | Concurrency        | Two sessions updating the same record              |
| 🔒  | Authorization      | User not allowed to update certain fields          |
| 🌊  | Cascading Effects  | Deletion of parent impacts child tables            |

**Example Scenario Table**

| 🟢 | Scenario Type    | Example                                 |
|-----|------------------|-----------------------------------------|
| ✅  | Normal Case      | Insert new record with valid input       |
| ❌  | Missing Field    | Omit a required field                    |
| 🆎  | Invalid Format   | Date as "abcd"                           |
| 🔁  | Already Exists   | Duplicate insert                         |
| 🚫  | Nulls            | All fields null                          |
| 📆  | Overlapping Dates| Leave conflicts in data periods          |
| 📈  | Large Volumes    | Run it on 10M rows                       |
| 🔒  | Authorization Fail | User tries without required role        |

---

## 🚨 How to figure out the worst case scenarios for any requirement?

| #  | 🟢 | Area/Check                        | Worst Case Scenario / Example                                      | Mitigation / Tip                                                      |
|----|-----|-----------------------------------|--------------------------------------------------------------------|-----------------------------------------------------------------------|
| 1  | 🏋️  | Volume Stress (Large Data Inputs) | Memory overflow, TEMP tablespace full, unindexed joins             | Ask max records, use bulk collect + FORALL                            |
| 2  | 🌀  | Extreme Input Combinations        | Application crash, unpredictable behavior                          | Try NULL, 0, max numeric, weird strings                               |
| 3  | 🌐  | Failure of External Systems       | Partial data updates, hanging sessions                             | Add exception handling and logging for all external dependencies       |
| 4  | 🔗  | Deadlocks and Concurrency         | ORA-00060 deadlock, data corruption, rollback chain reactions      | Understand transaction isolation and locking behavior                  |
| 5  | 🦠  | Invalid or Corrupt Data           | Cursor fetch failures, logic skips corrupted rows                  | Always sanitize and validate even existing data                        |
| 6  | ✂️  | Code Interruptions / Partial Commits | Inconsistent data, broken references                              | Use savepoints, ensure rollback on exception                          |
| 7  | 🔄  | Recursive or Infinite Loops       | PL/SQL block hangs forever or runs out of memory                   | Add hard loop limits and logging                                      |
| 8  | 🗄️  | Full or Read-Only Tablespace      | DML fails silently, critical inserts fail                          | Handle ORA errors in exception blocks (e.g., ORA-01653)               |
| 9  | 🧩  | Dependencies Broken               | ORA-06508 (could not find program unit)                            | Use USER_OBJECTS to check object validity in pre-checks                |
| 10 | ⏳  | Worst-Case Execution Time         | App times out, long rollback, end-user frustration                 | Add performance benchmarking/logging and optimize SQL                  |

**Bonus Thinking Models**

| 🟢 | Model/Question         | Description                                                                 |
|-----|------------------------|-----------------------------------------------------------------------------|
| 😈  | “Evil Tester” Mindset  | "If I wanted to break this system on purpose, what would I try?"            |
| 🧩  | 5D Breakdown           | What if the Data is broken? Design has gaps? Dependency fails? DB crashes? Developer misunderstood? |

**Sample Worst-Case Scenario Checklist**

| 🟢 | Area         | Scenario                    | Your Mitigation                  |
|-----|--------------|----------------------------|----------------------------------|
| 🏋️  | Data Load    | 10M records input           | Use bulk collect + FORALL        |
| 🚫  | NULLs        | All input fields null       | Default values, validations      |
| 🌐  | Network      | DB link unavailable         | Retry logic or fallback          |
| 🔄  | Concurrency  | 2 sessions update same row  | Optimistic locking or FOR UPDATE |
| 📡  | External Call| UTL_HTTP fails              | Use timeout and fallback         |
| 🗄️  | Space        | Tablespace full             | Monitor with alerts              |