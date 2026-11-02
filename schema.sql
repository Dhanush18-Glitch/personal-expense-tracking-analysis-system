-- MySQL 8 schema for Home Budget (Expense Tracker) and Analysis System.
-- Set database credentials in DATABASE_URL; do not commit credentials.
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  kind VARCHAR(10) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_category_name_kind UNIQUE (name, kind),
  CONSTRAINT ck_category_kind CHECK (kind IN ('income','expense'))
);
CREATE TABLE IF NOT EXISTS transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  transaction_date DATE NOT NULL,
  kind VARCHAR(10) NOT NULL,
  category_id INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  description VARCHAR(255) NOT NULL,
  payment_method VARCHAR(50) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_transaction_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
  CONSTRAINT ck_transaction_kind CHECK (kind IN ('income','expense')),
  CONSTRAINT ck_transaction_amount CHECK (amount > 0),
  INDEX ix_transactions_date_kind (transaction_date, kind), INDEX ix_transactions_category (category_id)
);
CREATE TABLE IF NOT EXISTS monthly_budgets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  month TINYINT NOT NULL,
  year SMALLINT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_budget_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
  CONSTRAINT uq_budget_category_month_year UNIQUE (category_id, month, year),
  CONSTRAINT ck_budget_month CHECK (month BETWEEN 1 AND 12), CONSTRAINT ck_budget_amount CHECK (amount > 0),
  INDEX ix_budgets_category (category_id)
);

-- Sample data for the initial dashboard and chart demonstration.
-- The INSERT IGNORE statements can safely be re-run.
INSERT IGNORE INTO categories (name, kind) VALUES
  ('Salary', 'income'),
  ('Freelance', 'income'),
  ('Food & Dining', 'expense'),
  ('Transport', 'expense'),
  ('Bills & Utilities', 'expense'),
  ('Shopping', 'expense'),
  ('Health', 'expense'),
  ('Entertainment', 'expense');

INSERT INTO transactions (transaction_date, kind, category_id, amount, description, payment_method)
SELECT '2026-11-01', 'income', id, 45000.00, 'Monthly Salary', 'Bank Transfer'
FROM categories WHERE name = 'Salary' AND kind = 'income'
  AND NOT EXISTS (SELECT 1 FROM transactions WHERE description = 'Monthly Salary' AND transaction_date = '2026-11-01');

INSERT INTO transactions (transaction_date, kind, category_id, amount, description, payment_method)
SELECT '2026-11-02', 'expense', id, 1850.00, 'Weekly Groceries', 'UPI'
FROM categories WHERE name = 'Food & Dining' AND kind = 'expense'
  AND NOT EXISTS (SELECT 1 FROM transactions WHERE description = 'Weekly Groceries' AND transaction_date = '2026-11-02');

INSERT INTO transactions (transaction_date, kind, category_id, amount, description, payment_method)
SELECT '2026-11-03', 'expense', id, 600.00, 'Monthly Bus Pass', 'UPI'
FROM categories WHERE name = 'Transport' AND kind = 'expense'
  AND NOT EXISTS (SELECT 1 FROM transactions WHERE description = 'Monthly Bus Pass' AND transaction_date = '2026-11-03');

INSERT INTO transactions (transaction_date, kind, category_id, amount, description, payment_method)
SELECT '2026-11-04', 'expense', id, 1250.00, 'Electricity Bill', 'UPI'
FROM categories WHERE name = 'Bills & Utilities' AND kind = 'expense'
  AND NOT EXISTS (SELECT 1 FROM transactions WHERE description = 'Electricity Bill' AND transaction_date = '2026-11-04');
