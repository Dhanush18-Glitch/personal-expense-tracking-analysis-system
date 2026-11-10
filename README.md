# Home Budget Expense Tracker and Analysis System

A Flask-based Home Budget Expense Tracker and Analysis System for managing
income, expenses, monthly budgets, savings analytics, live charts, reports,
and CSV exports. It is an academic project for personal expense management.

**Live website:** [home-budget-tracker-nu.vercel.app](https://home-budget-tracker-nu.vercel.app)

## Main features

- Add, edit, search, filter, and delete income and expense records.
- Add income and expense categories.
- Create monthly category budgets and compare a budget with actual spending.
- View total income, total expenses, savings, and budget status on the dashboard.
- Select a date, month, or year to view records and charts for that period.
- Generate expense category, income-versus-expense, savings, and budget charts.
- Download transaction data as CSV and generate reports.

## Tools used

| Tool | Where it is used |
| --- | --- |
| Python | Main programming language for the application. |
| Flask | Creates routes, handles forms, and runs the web application. |
| Jinja2 | Shows database data inside HTML pages. |
| HTML and CSS | Builds the page layout, forms, buttons, and responsive design. |
| SQLAlchemy | Connects Python code with database tables safely. |
| MySQL / TiDB Cloud | Stores transactions, categories, and monthly budgets. |
| SQLite | Local database option for testing on a computer. |
| Matplotlib | Creates pie, bar, and line charts on the server. |
| Pandas and NumPy | Helps calculate totals, trends, and spending analysis. |
| Flask-Migrate / Alembic | Manages database table changes. |
| PyMySQL | Lets Flask connect to MySQL-compatible databases. |
| Visual Studio Code | Used to write, organise, and run the project code. |
| Git and GitHub | Used for version control and publishing the project source. |
| Vercel | Used to deploy the Flask project with a public link. |

## Team members

- Dhanush Kumar Yadav (`Dhanush18-Glitch`) — Project owner and Frontend Developer
- Karthik Nadhakota (`karthiknadhakota-code`) — Backend Developer and Contributor
- Lokesh Raju (`ALokeshraju-289`) — Contributor

## Project structure

- `app.py` — starts the Flask application in VS Code.
- `database.py` — checks the database connection.
- `app/__init__.py` — creates and configures the Flask app.
- `app/models.py` — defines database tables.
- `app/routes/web.py` — dashboard, forms, budgets, reports, and delete actions.
- `app/routes/api.py` — JSON API endpoints.
- `app/services/charts.py` — creates Matplotlib charts.
- `schema.sql` — MySQL tables and sample records.
- `requirements.txt` — required Python packages.

## Run locally in VS Code

Open this project folder in VS Code. Run the following commands in the PowerShell terminal:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python app.py
```

Then open [http://127.0.0.1:5000](http://127.0.0.1:5000).

## Database setup

For local testing, the project uses SQLite automatically.

For MySQL or TiDB Cloud, create a `.env` file and add your private database
connection string and secret key. Never upload `.env` to GitHub.

```text
DATABASE_URL=mysql+pymysql://USERNAME:PASSWORD@HOST:PORT/DATABASE
SECRET_KEY=replace-with-a-private-secret
```

Create tables with:

```powershell
python manage.py init-db
```

You can also use `schema.sql` in a MySQL client to create the tables and sample data.

## Deployment

The project contains `api/index.py` and `vercel.json` for Vercel deployment.
In Vercel, add `DATABASE_URL` and `SECRET_KEY` as environment variables before
deploying. A hosted MySQL-compatible database is required because a Vercel
function does not keep local SQLite data permanently.

## API endpoints

The project includes health, dashboard, transaction, category, budget, monthly
analytics, category analytics, budget analytics, and CSV export API endpoints.
See [API documentation](docs/API_DOCUMENTATION.md) for details.
