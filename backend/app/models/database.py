from sqlalchemy import Column, String, Integer, Float, Boolean, ForeignKey, DateTime, Enum, Table
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship, declarative_base
from sqlalchemy.sql import func
import uuid

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    user_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    password_hash = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    bio = Column(String)

class Challenge(Base):
    __tablename__ = "challenges"
    challenge_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    title = Column(String, nullable=False)
    description = Column(String)
    category = Column(String)
    difficulty = Column(String)
    starter_code = Column(String)
    time_limit = Column(Integer)
    memory_limit = Column(Integer)

class TestCase(Base):
    __tablename__ = "test_cases"
    test_case_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    challenge_id = Column(UUID(as_uuid=True), ForeignKey("challenges.challenge_id"))
    input = Column(String)
    expected_output = Column(String)
    is_hidden = Column(Boolean, default=True)
    weight = Column(Integer, default=1)

class Submission(Base):
    __tablename__ = "submissions"
    submission_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.user_id"))
    challenge_id = Column(UUID(as_uuid=True), ForeignKey("challenges.challenge_id"))
    language = Column(String)
    code = Column(String)
    status = Column(String, default="Pending")
    submitted_at = Column(DateTime(timezone=True), server_default=func.now())

class EvaluationResult(Base):
    __tablename__ = "evaluation_results"
    result_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    submission_id = Column(UUID(as_uuid=True), ForeignKey("submissions.submission_id"), unique=True)
    passed_tests = Column(Integer)
    total_tests = Column(Integer)
    execution_time = Column(Float)
    memory_used = Column(Integer)
    ai_feedback = Column(String)
    final_score = Column(Float)

class UserSkill(Base):
    __tablename__ = "user_skills"
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.user_id"), primary_key=True)
    skill_name = Column(String, primary_key=True)
    score = Column(Float, default=0.0)
    last_updated = Column(DateTime(timezone=True), onupdate=func.now())
