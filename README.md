
SmartLibrary Database Management System


Project Overview

SmartLibrary is a relational database management system designed to handle core library operations efficiently. It streamlines tracking for library assets, registered members, author information, and borrow-and-return lifecycles. The system uses a clean relational structure to manage availability, monitor deadlines, and compute late fees dynamically.

Key Features


📖 Inventory Management

• Asset Tracking: Keeps an up-to-date log of books, pricing structures, and unique ISBN identifiers.
• Author Cataloging: Relates library titles back to a centralized author profile database.
• Dynamic Auditing: Categorizes library resources into strategic groups like Classics, New Arrivals, or Regular items based on print timelines.

👥 Member Management

• Profile Database: Stores names, contact information, and membership registration milestones.
• Activity Profiling: Evaluates user records over rolling 6-month windows to segment profiles into Active or Inactive tiers.

🔄 Transaction Lifecycles

• Distribution Logs: Captures exact borrow and return timestamps per user and per book asset.
• Fine Calculation Engine: Calculates late periods automatically beyond standard 14-day return boundaries and balances overdue penalties.
• Safe Operations: Wraps catalog updates and lending actions inside secure ACID-compliant transactions to eliminate stock anomalies.

Schema Architecture

The database architecture is built upon a matrix of structured data points across four core entities:
                  ┌───────────────┐
                  │    AUTHORS    │
                  └───────┬───────┘
                          │ (1:N)
                  ┌───────▼───────┐
                  │     BOOKS     │
                  └───────┬───────┘
                          │ (1:N)
 ┌───────────────┐        │
 │    MEMBERS    ├────────┼────────┐
 └───────┬───────┘        │        │
         │ (1:N)          │        │
         └────────┬───────▼────────▼┘
                  │  TRANSACTIONS   │
                  └─────────────────┘

1. Authors Table

Keeps record of content creators and primary item contributors.
• Unique identifier for each author
• Complete legal name or alias
• Direct digital contact information

2. Books Table

Maintains the full collection profile of literature assets.
• Unique asset code
• Complete publishing title
• Relational link to the primary author profile
• Broad literary genre or subject classification
• International Standard Book Number
• Production or distribution date
• Unit acquisition cost and current stock tracking balances

3. Members Table

Tracks all authorized library clients and platform participants.
• System-generated member identifier
• Full account holder name
• Electronic mail address
• Mobile or landline contact sequence
• Initial enrollment validation date

4. Transactions Table

The operational bridge logging the historical lifecycle of library lending actions.
• Unique transaction tracking code
• Reference to the acquiring member
• Reference to the borrowed book asset
• Dispatch date
• Return validation date
• Accumulated late-return fee tracking balance

Analytical & Operational Insights

The system uses advanced analytical logic to supply administrative staff with high-value operational metrics:

📈 Inventory Analytics

• Genre Clustering: Counts and summarizes total library assets grouped by theme to find indexing gaps.
• Investment Metrics: Determines generalized stock asset worth via pricing averages.
• Popularity Hierarchies: Ranks individual library books through analytical windows based on historical borrow volume.

⏱️ Operational Tracking

• Chronological String Formats: Standardizes raw timestamp values into cleanly readable local layout strings.
• Moving Trend Averages: Aggregates monthly activity metrics through rolling multi-month analytical windows to safely predict high-demand seasons.
• String Optimization: Sanitizes user text fields automatically by stripping trailing whitespaces and converting index attributes to uniform casing.

System Requirements & Prerequisites

• Platform: MySQL Server or any compatible relational database engine.
• Client Tooling: Command Line Interface, MySQL Workbench, or equivalent database administration software.

