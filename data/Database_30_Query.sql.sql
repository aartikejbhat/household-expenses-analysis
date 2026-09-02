CREATE TABLE expense_categories
(
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200)
);

CREATE TABLE expense_subcategories
(
    subcategory_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id INTEGER NOT NULL,
    subcategory_name VARCHAR(60) NOT NULL,
    description VARCHAR(200),

    CONSTRAINT fk_subcategory_category
    FOREIGN KEY (category_id)
    REFERENCES expense_categories(category_id),

    CONSTRAINT uq_category_subcategory
    UNIQUE (category_id, subcategory_name)
);

CREATE TABLE family_members
(
    member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_name VARCHAR(60) NOT NULL,
    relationship VARCHAR(30),
    date_of_birth DATE
);

CREATE TABLE payment_methods
(
    payment_method_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_method_name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE vendors
(
    vendor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vendor_name VARCHAR(100) NOT NULL,
    vendor_type VARCHAR(50),
    city VARCHAR(50),
    contact_number VARCHAR(15)
);

CREATE TABLE expenses
(
    expense_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    expense_date DATE NOT NULL,
    subcategory_id INTEGER NOT NULL,
    member_id INTEGER,
    vendor_id INTEGER,
    payment_method_id INTEGER,
    amount NUMERIC(12,2) NOT NULL,
    quantity NUMERIC(10,2),
    bill_number VARCHAR(50),
    description VARCHAR(255),
    is_recurring BOOLEAN DEFAULT FALSE,
    due_date DATE,
    paid_status VARCHAR(10) DEFAULT 'PAID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_expense_amount
    CHECK (amount > 0),

    CONSTRAINT chk_paid_status
    CHECK (paid_status IN ('PAID', 'PENDING', 'PARTIAL')),

    CONSTRAINT fk_expense_subcategory
    FOREIGN KEY (subcategory_id)
    REFERENCES expense_subcategories(subcategory_id),

    CONSTRAINT fk_expense_member
    FOREIGN KEY (member_id)
    REFERENCES family_members(member_id),

    CONSTRAINT fk_expense_vendor
    FOREIGN KEY (vendor_id)
    REFERENCES vendors(vendor_id),

    CONSTRAINT fk_expense_payment
    FOREIGN KEY (payment_method_id)
    REFERENCES payment_methods(payment_method_id)
);

INSERT INTO expense_categories
(category_name, description)
VALUES
('Grocery', 'Daily household grocery and food items'),
('Utilities', 'Electricity, water, gas, mobile and internet'),
('Housing', 'Building maintenance, repair and home expenses'),
('Taxes', 'Property tax and other government taxes'),
('Medical', 'Hospital, doctor, medicine and healthcare'),
('Food Outside', 'Restaurant, hotel and online food'),
('Transportation', 'Petrol, diesel, bus, auto, taxi and vehicle expenses'),
('Tourism', 'Travel, vacation and sightseeing expenses'),
('Education', 'School, college, books and educational expenses'),
('Clothing', 'Clothes, footwear and accessories'),
('Domestic Services', 'Maid, cleaning and household services'),
('Insurance', 'Life, health and vehicle insurance'),
('Loan and EMI', 'Loan installments and EMI payments'),
('Entertainment', 'Movies, games and entertainment'),
('Personal Care', 'Salon, cosmetics and personal care'),
('Social', 'Functions, gifts and social activities'),
('Miscellaneous', 'Other household expenses');


INSERT INTO expense_subcategories
(category_id, subcategory_name, description)
VALUES
-- GROCERY
(1, 'Kirana', 'Rice, wheat, pulses, oil, spices etc.'),
(1, 'Vegetables', 'Daily vegetables'),
(1, 'Fruits', 'Fresh fruits'),
(1, 'Milk', 'Milk and dairy products'),
(1, 'Bakery', 'Bread, biscuits and bakery items'),
(1, 'Meat / Fish', 'Non-vegetarian food items'),

-- UTILITIES
(2, 'Electricity Bill', NULL),
(2, 'Water Bill', NULL),
(2, 'Gas Cylinder', NULL),
(2, 'Mobile Recharge', NULL),
(2, 'Internet Bill', NULL),
(2, 'DTH / Cable', NULL),

-- HOUSING
(3, 'Building Maintenance', NULL),
(3, 'House Repair', NULL),
(3, 'Plumbing', NULL),
(3, 'Electrical Repair', NULL),
(3, 'Furniture', NULL),
(3, 'Painting', NULL),

-- TAXES
(4, 'Property Tax', NULL),
(4, 'Municipal Tax', NULL),
(4, 'Vehicle Tax', NULL),
(4, 'Other Government Tax', NULL),

-- MEDICAL
(5, 'Doctor Consultation', NULL),
(5, 'Hospital', NULL),
(5, 'Medicines', NULL),
(5, 'Medical Tests', NULL),
(5, 'Dental', NULL),
(5, 'Emergency Medical', NULL),

-- FOOD OUTSIDE
(6, 'Restaurant', NULL),
(6, 'Hotel', NULL),
(6, 'Online Food', NULL),
(6, 'Tea / Snacks', NULL),

-- TRANSPORTATION
(7, 'Petrol', NULL),
(7, 'Diesel', NULL),
(7, 'Bus', NULL),
(7, 'Auto', NULL),
(7, 'Taxi', NULL),
(7, 'Parking', NULL),
(7, 'Vehicle Maintenance', NULL),

-- TOURISM
(8, 'Hotel Stay', NULL),
(8, 'Train Ticket', NULL),
(8, 'Flight Ticket', NULL),
(8, 'Tour Package', NULL),
(8, 'Sightseeing', NULL),

-- EDUCATION
(9, 'School Fees', NULL),
(9, 'College Fees', NULL),
(9, 'Books', NULL),
(9, 'Stationery', NULL),
(9, 'Tuition / Coaching', NULL),
(9, 'Online Course', NULL),

-- CLOTHING
(10, 'Clothes', NULL),
(10, 'Footwear', NULL),
(10, 'Accessories', NULL),

-- DOMESTIC SERVICES
(11, 'Maid', NULL),
(11, 'Cleaning', NULL),
(11, 'Laundry', NULL),
(11, 'Gardening', NULL),

-- INSURANCE
(12, 'Life Insurance', NULL),
(12, 'Health Insurance', NULL),
(12, 'Vehicle Insurance', NULL),
(12, 'Home Insurance', NULL),

-- LOAN AND EMI
(13, 'Home Loan EMI', NULL),
(13, 'Vehicle Loan EMI', NULL),
(13, 'Personal Loan EMI', NULL),
(13, 'Education Loan EMI', NULL),

-- ENTERTAINMENT
(14, 'Movie', NULL),
(14, 'OTT Subscription', NULL),
(14, 'Games', NULL),
(14, 'Events', NULL),

-- PERSONAL CARE
(15, 'Salon', NULL),
(15, 'Cosmetics', NULL),
(15, 'Personal Care Products', NULL),

-- SOCIAL
(16, 'Gifts', NULL),
(16, 'Marriage Function', NULL),
(16, 'Festival', NULL),
(16, 'Donation', NULL),

-- MISCELLANEOUS
(17, 'Miscellaneous', NULL),
(17, 'Other', NULL);

INSERT INTO family_members
(member_name, relationship, date_of_birth)
VALUES
('Rajesh', 'Father', '1975-05-15'),
('Sunita', 'Mother', '1978-09-20'),
('Amit', 'Son', '2005-03-12'),
('Priya', 'Daughter', '2008-07-25');

SELECT * FROM family_members;

INSERT INTO payment_methods
(payment_method_name)
VALUES
('Cash'),
('UPI'),
('Debit Card'),
('Credit Card'),
('Net Banking'),
('Cheque'),
('Auto Debit');

SELECT *
FROM payment_methods;

INSERT INTO vendors
(vendor_name, vendor_type, city, contact_number)
VALUES
('Local Kirana Store', 'Grocery', 'Aurangabad', '9000000001'),
('D-Mart', 'Supermarket', 'Aurangabad', '9000000002'),
('MSEDCL', 'Electricity', 'Aurangabad', '9000000003'),
('Municipal Corporation', 'Government', 'Aurangabad', '9000000004'),
('City Hospital', 'Hospital', 'Aurangabad', '9000000005'),
('Apollo Pharmacy', 'Pharmacy', 'Aurangabad', '9000000006'),
('Indian Oil', 'Petrol Pump', 'Aurangabad', '9000000007'),
('ABC Restaurant', 'Restaurant', 'Aurangabad', '9000000008'),
('IRCTC', 'Railway', 'India', '9000000009'),
('Reliance Jio', 'Telecom', 'India', '9000000010');

SELECT * FROM vendors;


INSERT INTO expenses
(
    expense_date,
    subcategory_id,
    member_id,
    vendor_id,
    payment_method_id,
    amount,
    quantity,
    bill_number,
    description,
    is_recurring,
    due_date,
    paid_status
)
VALUES
('2026-01-02', 1, 2, 1, 2,
 2350.00, 1, 'KIR001',
 'Monthly kirana purchase',
 FALSE, NULL, 'PAID'),

('2026-01-05', 2, 2, NULL, 1,
 450.00, 1, NULL,
 'Weekly vegetables',
 FALSE, NULL, 'PAID'),

('2026-01-10', 4, 2, NULL, 1,
 900.00, 1, NULL,
 'Monthly milk expenses',
 TRUE, NULL, 'PAID'),

('2026-01-07', 7, 1, 3, 2,
 3250.00, 1, 'ELEC001',
 'Monthly electricity bill',
 TRUE, '2026-01-10', 'PAID'),

('2026-01-10', 13, 1, NULL, 2,
 2500.00, 1, 'MAINT001',
 'Monthly building maintenance',
 TRUE, '2026-01-10', 'PAID'),

('2026-01-15', 19, 1, 4, 2,
 8500.00, 1, 'TAX001',
 'Annual property tax',
 TRUE, '2026-01-31', 'PAID'),

('2026-01-18', 21, 1, 5, 2,
 500.00, 1, 'HOS001',
 'Doctor consultation',
 FALSE, NULL, 'PAID'),

('2026-01-18', 23, 1, 6, 2,
 1250.00, 1, 'MED001',
 'Medicines',
 FALSE, NULL, 'PAID'),

('2026-01-20', 24, 2, 5, 3,
 4500.00, 1, 'LAB001',
 'Medical tests',
 FALSE, NULL, 'PAID'),

('2026-01-21', 27, 1, 8, 3,
 1850.00, 4, 'RES001',
 'Family dinner',
 FALSE, NULL, 'PAID'),

('2026-01-22', 32, 1, 7, 2,
 2000.00, 40, 'PET001',
 'Petrol',
 FALSE, NULL, 'PAID'),

('2026-01-23', 35, 3, NULL, 1,
 300.00, 5, NULL,
 'Auto travelling',
 FALSE, NULL, 'PAID'),

('2026-01-25', 41, 1, 9, 2,
 3200.00, 4, 'TRN001',
 'Family train tickets',
 FALSE, NULL, 'PAID'),

('2026-01-28', 48, 3, NULL, 5,
 25000.00, 1, 'EDU001',
 'College fees',
 TRUE, NULL, 'PAID'),

('2026-01-30', 10, 1, 10, 2,
 799.00, 1, 'MOB001',
 'Monthly mobile recharge',
 TRUE, NULL, 'PAID');

SELECT COUNT(*) AS total_expenses
FROM expenses;

SELECT * FROM expenses;


-------------------------------------------------------------------------------
------------------- PART A — BASIC EXPENSE ANALYSIS ---------------------------
-------------------------------------------------------------------------------

------------------- 1. HOUSEHOLD EXPENSE OVERVIEW -----------------------------

-- Display:
-- Expense ID
-- Expense Date
-- Amount
-- Description
-- Payment Status

SELECT
    expense_id,
    expense_date,
    amount,
    description,
    paid_status
FROM expenses;


------------------- 2. HIGH-VALUE EXPENSES ------------------------------------

-- Find all expenses where amount is greater than ₹2,000.

SELECT * FROM expenses
WHERE amount > 2000;


------------------- 3. SMALL DAILY EXPENSES -----------------------------------

-- Find all expenses where amount is less than ₹500.

SELECT * FROM expenses
WHERE amount < 500;


------------------- 4. EXPENSE RANGE -------------------------------------------

-- Find expenses between ₹1,000 and ₹5,000.

SELECT * FROM expenses
WHERE amount >= 1000
AND amount <= 5000;


------------------- 5. EXCEPTIONAL EXPENSES -----------------------------------

-- Find expenses where amount is ₹10,000 or more.

SELECT * FROM expenses
WHERE amount >= 10000;


-------------------------------------------------------------------------------
------------------- PART B — UNDERSTANDING PAYMENT BEHAVIOUR ------------------
-------------------------------------------------------------------------------

------------------- 6. PAYMENT METHODS USED -----------------------------------

-- Find the different payment methods used in expense records.

SELECT DISTINCT
    pm.payment_method_name
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id;


------------------- 7. UPI SPENDING -------------------------------------------

-- Display all UPI transactions.

SELECT e.* FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE pm.payment_method_name = 'UPI';


------------------- 8. CASH SPENDING ------------------------------------------

-- Find all expenses paid using Cash.

SELECT e.*
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE pm.payment_method_name = 'Cash';


------------------- 9. LARGE UPI TRANSACTIONS -------------------------------

-- Find expenses where:
-- amount is greater than ₹2,000
-- AND payment method is UPI.

SELECT e.*
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE e.amount > 2000
AND pm.payment_method_name = 'UPI';


------------------- 10. CASH OR UPI -------------------------------------------

-- Find expenses greater than ₹2,000
-- where payment method was either Cash or UPI.

SELECT e.*
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE e.amount > 2000
AND
(
    pm.payment_method_name = 'Cash'
    OR pm.payment_method_name = 'UPI'
);


------------------- 11. NON-UPI EXPENSES --------------------------------------

-- Display expenses that were not paid through UPI.

SELECT e.*
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE pm.payment_method_name <> 'UPI';


-------------------------------------------------------------------------------
------------------- PART C — RECURRING AND PENDING EXPENSES -------------------
-------------------------------------------------------------------------------

------------------- 12. REGULAR HOUSEHOLD COMMITMENTS ------------------------

-- Find all recurring expenses.

SELECT *
FROM expenses
WHERE is_recurring = TRUE;


------------------- 13. COST OF RECURRING EXPENSES ----------------------------

-- Calculate total amount committed to recurring expenses.

SELECT
    SUM(amount) AS total_recurring_expense
FROM expenses
WHERE is_recurring = TRUE;


------------------- 14. EXPENSIVE RECURRING COMMITMENTS -----------------------

-- Find recurring expenses where amount is greater than ₹1,000.

SELECT *
FROM expenses
WHERE is_recurring = TRUE
AND amount > 1000;


------------------- 15. PENDING PAYMENTS --------------------------------------

-- Find expenses whose payment status is PENDING or PARTIAL.

SELECT *
FROM expenses
WHERE paid_status IN ('PENDING', 'PARTIAL');


------------------- 16. RECURRING PENDING EXPENSES ----------------------------

-- Identify expenses that are:
-- recurring
-- AND pending.

SELECT *
FROM expenses
WHERE is_recurring = TRUE
AND paid_status = 'PENDING';


-------------------------------------------------------------------------------
------------------- PART D — HOUSEHOLD SPENDING PATTERNS ---------------------
-------------------------------------------------------------------------------

------------------- 17. NUMBER OF TRANSACTIONS -------------------------------

-- Find the number of individual expense transactions.

SELECT
    COUNT(*) AS total_transactions
FROM expenses;


------------------- 18. TOTAL HOUSEHOLD SPENDING ------------------------------

-- Calculate total amount spent across all recorded expenses.

SELECT
    SUM(amount) AS total_household_spending
FROM expenses;


------------------- 19. AVERAGE EXPENSE --------------------------------------

-- Calculate average amount spent per transaction.

SELECT
    AVG(amount) AS average_expense
FROM expenses;


------------------- 20. HIGHEST AND LOWEST EXPENSES ---------------------------

-- Find highest and lowest expense.

SELECT
    MAX(amount) AS highest_expense,
    MIN(amount) AS lowest_expense
FROM expenses;


------------------- 21. DIFFERENT EXPENSE TYPES -------------------------------

-- Find number of different subcategories.
-- Use DISTINCT.

SELECT
    COUNT(DISTINCT subcategory_id) AS different_expense_types
FROM expenses;


------------------- 22. EXPENSES OF A PARTICULAR FAMILY MEMBER --------------

-- Member ID = 1
-- Find number of transactions,
-- total amount spent,
-- average expense amount.

SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount_spent,
    AVG(amount) AS average_expense_amount
FROM expenses
WHERE member_id = 1;


-------------------------------------------------------------------------------
------------------- PART E — SEARCHING INFORMATION USING LIKE ----------------
-------------------------------------------------------------------------------

------------------- 23. VENDOR SEARCH ----------------------------------------

-- Find vendor whose name contains "Hospital".

SELECT *
FROM vendors
WHERE vendor_name LIKE '%Hospital%';


------------------- 24. STORE SEARCH ------------------------------------------

-- Find vendors whose name contains "Store".

SELECT *
FROM vendors
WHERE vendor_name LIKE '%Store%';


------------------- 25. MONTHLY EXPENSES --------------------------------------

-- Find expenses whose description contains "Monthly".

SELECT *
FROM expenses
WHERE description LIKE '%Monthly%';


------------------- 26. BILL-RELATED SUBCATEGORIES ----------------------------

-- Find subcategories whose names contain "Bill".

SELECT *
FROM expense_subcategories
WHERE subcategory_name LIKE '%Bill%';


------------------- 27. STARTING LETTER SEARCH -------------------------------

-- Find vendors whose names start with letter "A".

SELECT *
FROM vendors
WHERE vendor_name LIKE 'A%';


-------------------------------------------------------------------------------
------------------- PART F — LOGICAL CONDITIONS AND OPERATOR PRECEDENCE -------
-------------------------------------------------------------------------------

------------------- 28. HIGH-PRIORITY EXPENSES -------------------------------

-- Condition 1:
-- amount is greater than ₹5,000
--
-- OR
--
-- Condition 2:
-- amount is greater than ₹2,000
-- AND payment method is UPI.

SELECT e.*
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE e.amount > 5000
OR
(
    e.amount > 2000
    AND pm.payment_method_name = 'UPI'
);


------------------- 29. EXPENSES REQUIRING REVIEW ----------------------------

-- Find expenses that are:
-- recurring
-- AND amount greater than ₹2,000
-- AND payment status is PAID.

SELECT *
FROM expenses
WHERE is_recurring = TRUE
AND amount > 2000
AND paid_status = 'PAID';


------------------- 30. UNUSUAL SPENDING -------------------------------------

-- Find expenses where:
-- amount is less than ₹500
-- OR amount is greater than ₹5,000
-- but exclude PENDING expenses.

SELECT *
FROM expenses
WHERE
(
    amount < 500
    OR amount > 5000
)
AND paid_status <> 'PENDING';


-------------------------------------------------------------------------------
------------------- FINAL REAL-LIFE ANALYSIS ----------------------------------
-------------------------------------------------------------------------------

-- 1. What is the total household expenditure?

SELECT
    SUM(amount) AS total_household_expenditure
FROM expenses;


-- 2. What is the average expense?

SELECT
    AVG(amount) AS average_expense
FROM expenses;


-- 3. What is the highest individual expense?

SELECT
    MAX(amount) AS highest_individual_expense
FROM expenses;


-- 4. How many expenses are recurring?

SELECT
    COUNT(*) AS recurring_expenses
FROM expenses
WHERE is_recurring = TRUE;


-- 5. How much money is committed to recurring expenses?

SELECT
    SUM(amount) AS recurring_expense_amount
FROM expenses
WHERE is_recurring = TRUE;


-- 6. Which payment methods are being used?

SELECT DISTINCT
    pm.payment_method_name
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id;


-- 7. How much spending is done through UPI?

SELECT
    SUM(e.amount) AS total_upi_spending
FROM expenses e
JOIN payment_methods pm
ON e.payment_method_id = pm.payment_method_id
WHERE pm.payment_method_name = 'UPI';


-- 8. How many expenses are pending or partially paid?

SELECT
    COUNT(*) AS pending_or_partial_expenses
FROM expenses
WHERE paid_status IN ('PENDING', 'PARTIAL');


-- 9. How many expenses are above ₹2,000?

SELECT
    COUNT(*) AS expenses_above_2000
FROM expenses
WHERE amount > 2000;


-- 10. Identify three expenses that the family should review carefully.

SELECT
    expense_id,
    expense_date,
    amount,
    description,
    paid_status
FROM expenses
ORDER BY amount DESC
LIMIT 3;


-------------------------------------------------------------------------------
------------------- END OF SQL ANALYSIS ---------------------------------------
-------------------------------------------------------------------------------