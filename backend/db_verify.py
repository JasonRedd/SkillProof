from sqlalchemy.orm import Session
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
import uuid
from app.models.database import User, Challenge, Base

load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@localhost:5432/skillproof")
engine = create_engine(DATABASE_URL)

def test_db():
    print("Starting Direct DB Integration Test...")
    with Session(engine) as session:
        try:
            # 1. Test User Insertion
            test_user = User(
                username="innovator_jaisun", 
                email="jaisun@skillproof.dev", 
                password_hash="mock_hash"
            )
            session.add(test_user)
            session.commit()
            print(f"? User created: {test_user.username}")

            # 2. Test Challenge Insertion
            test_challenge = Challenge(
                title="The Great Sandbox Challenge",
                description="Build a secure execution environment",
                category="System Design",
                difficulty="Hard",
                starter_code="print('Hello Sandbox')",
                time_limit=5,
                memory_limit=256
            )
            session.add(test_challenge)
            session.commit()
            print(f"? Challenge created: {test_challenge.title}")

            # 3. Verification Query
            user_count = session.query(User).count()
            print(f"Total Users in DB: {user_count}")
            
            print("\n?? DATABASE LAYER VERIFIED: Schema is working perfectly.")
        except Exception as e:
            print(f"? DB Test Failed: {e}")
            session.rollback()

if __name__ == "__main__":
    test_db()
