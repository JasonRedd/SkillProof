import os
import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv

# Add backend/app to path for imports
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(current_dir, "app"))

try:
    from models.database import Base
    print("Successfully imported Base from models.database")
except ImportError as e:
    print(f"Import Error: {e}")
    sys.exit(1)

load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@localhost:5432/skillproof")

print(f"Connecting to: {DATABASE_URL}")
try:
    engine = create_engine(DATABASE_URL)
    # This creates all tables defined in the SQLAlchemy Base
    Base.metadata.create_all(bind=engine)
    print("Tables created successfully!")
except Exception as e:
    print(f"Error creating tables: {e}")
    print("\nTip: Ensure PostgreSQL is running and the database exists.")
