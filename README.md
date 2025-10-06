# World Cup Database Design and SQL Implementation

A database project designed in **PowerDesigner** and implemented in **Microsoft SQL Server**, modeling and enforcing the rules of a **World Cup-style football tournament**.  

The project includes **conceptual and physical data models** as well as **SQL scripts** for schema creation, constraints, and advanced triggers to enforce business rules.

---

## 🧰 Tech Stack

- **PowerDesigner** – database modeling (Conceptual and Physical Data Models)  
- **SQL Server 2008+** – schema definition, constraints, and triggers  
- **T-SQL** – advanced logic for enforcing tournament rules  

---

## 📁 Repository Structure

~~~text
.
├─ models/
│  ├─ Final Project - Conceptual Data Model.cdm
│  ├─ Final Project - Physical Data Model.pdm
│  └─ exports/                # optional: export diagrams to PDF/PNG
├─ sql/
│  ├─ Final Project - SQL.sql  # main DDL schema
│  ├─ create_mundial.sql       # schema + constraints + triggers
│  ├─ SQL Script.sql           # triggers and business rules
├─ docs/
│  └─ Report.pdf               # optional project report
├─ README.md
└─ LICENSE
~~~

---

## 📄 Data Model Overview

### Entities
- **Teams / Countries** – groups, codes, names  
- **Players** – personal data, positions, country association  
- **Coaches / Referees** – linked to countries  
- **Stadiums & Cities** – hosting matches  
- **Matches** – teams, stage, referee, stadium, date/time  
- **Events** – goals, cards, replacements  
- **Summoned Players** – players available per match (starting 11 or bench)

### Relationships
- Players belong to teams/countries  
- Matches belong to tournament phases and stadiums  
- Events link to matches and summoned players  
- Constraints ensure tournament rules (e.g., group assignments, unique codes)  

---

## ⚙️ Business Rules Implemented (via Triggers)

- **Summoning Players:**  
  Cannot summon a player who does not belong to one of the teams in the match:contentReference[oaicite:3]{index=3}.  

- **Referee Restrictions:**  
  Referees cannot officiate matches involving their own country (both on insert and update):contentReference[oaicite:4]{index=4}:contentReference[oaicite:5]{index=5}.  

- **Yellow/Red Card Rule:**  
  If a player receives a second yellow card in the same match, an automatic red card event is inserted:contentReference[oaicite:6]{index=6}.  

- **Goal Validation:**  
  A goal is only valid if the scorer was on the field (starting or substituted, not sent off):contentReference[oaicite:7]{index=7}:contentReference[oaicite:8]{index=8}.  

- **Substitution Validation:**  
  Ensures the player out was on the field, the player in was on the bench, and both belong to the same team in the same match:contentReference[oaicite:9]{index=9}:contentReference[oaicite:10]{index=10}.  

---

## 🚀 How to Use

1. Open the **PowerDesigner models** (`.cdm` and `.pdm`) to view conceptual and physical diagrams.  
   - Optionally check exported diagrams under `models/exports/`.  

2. Run the SQL scripts in **SQL Server Management Studio (SSMS)**:  
   - `Final Project - SQL.sql` → creates the main schema and constraints.  
   - `create_mundial.sql` → builds tables and adds advanced triggers.  
   - `SQL Script.sql` → implements additional triggers for business rules.  

3. Insert test data (optional) and validate triggers by simulating matches, goals, cards, and substitutions.  

---

## ✅ Requirements

- PowerDesigner (to view/edit `.cdm` and `.pdm`)  
- Microsoft SQL Server 2008 or later  
- SQL Server Management Studio (SSMS)  

---

## 📄 License

This project is licensed under the MIT License – see the LICENSE file for details.






