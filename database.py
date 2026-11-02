"""Database utilities for local Flask development and MySQL deployments.

The SQLAlchemy models are defined in ``app/models.py``.  This small module
provides a convenient VS Code entry point for checking the active database.
"""

from sqlalchemy import text

from app import create_app
from app.extensions import db


def check_connection() -> str:
    """Return the database engine name after proving a connection works."""
    app = create_app()
    with app.app_context():
        return db.session.execute(text("SELECT VERSION()")).scalar_one()


if __name__ == "__main__":
    print(f"Database connected successfully: {check_connection()}")
