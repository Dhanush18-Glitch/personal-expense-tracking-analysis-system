"""Local Flask entry point for the Personal Expense Tracking and Analysis System.

Run from VS Code after activating ``.venv``:
    python app.py
"""

from app import create_app


app = create_app()


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
