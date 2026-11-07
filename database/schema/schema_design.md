# Database Schema - SkillProof

## ER Diagram Logic

### 1. Users Table
- user_id (UUID, PK)
- username (VARCHAR, Unique)
- email (VARCHAR, Unique)
- password_hash (TEXT)
- created_at (TIMESTAMP)
- bio (TEXT)

### 2. Challenges Table
- challenge_id (UUID, PK)
- title (VARCHAR)
- description (TEXT)
- category (VARCHAR)
- difficulty (ENUM: Easy, Medium, Hard)
- starter_code (TEXT)
- time_limit (INT)
- memory_limit (INT)

### 3. TestCases Table
- test_case_id (UUID, PK)
- challenge_id (UUID, FK)
- input (TEXT)
- expected_output (TEXT)
- is_hidden (BOOLEAN)
- weight (INT)

### 4. Submissions Table
- submission_id (UUID, PK)
- user_id (UUID, FK)
- challenge_id (UUID, FK)
- language (VARCHAR)
- code (TEXT)
- status (ENUM: Pending, Processing, Completed, Failed)
- submitted_at (TIMESTAMP)

### 5. EvaluationResults Table
- result_id (UUID, PK)
- submission_id (UUID, FK, Unique)
- passed_tests (INT)
- total_tests (INT)
- execution_time (FLOAT)
- memory_used (INT)
- ai_feedback (TEXT)
- raw_logs (TEXT)
- final_score (FLOAT)

### 6. UserSkills Table
- user_id (UUID, FK)
- skill_name (VARCHAR)
- score (FLOAT)
- last_updated (TIMESTAMP)
- Primary Key: (user_id, skill_name)

## Relationships
- Users 1 -> N Submissions
- Challenges 1 -> N TestCases
- Challenges 1 -> N Submissions
- Submissions 1 -> 1 EvaluationResults
- Users 1 -> N UserSkills
