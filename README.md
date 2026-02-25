# Sakila Python – SQL & Data Analysis Practice

Projekt edukacyjny pokazujący pracę z bazą danych przy użyciu **SQLite** oraz **SQLAlchemy (ORM)** w Pythonie.  
Celem projektu było przećwiczenie modelowania danych, zapytań SQL, pracy z ORM oraz prostych operacji ETL (Excel → SQL → Excel).

---

## 🎯 Cel projektu

- Praktyka zapytań SQL
- Nauka SQLAlchemy ORM
- Tworzenie tabel i relacji
- Praca z bazą SQLite
- Import oraz eksport danych (Excel ↔ SQL)
- Budowanie zapytań analitycznych

---

## 🛠 Stack technologiczny

- Python 3.x
- SQLite
- SQLAlchemy (ORM)
- Pandas
- Excel (.xlsx)
- pyproject.toml

---

## 📂 Struktura projektu

```
sakila_python/
│
├── sqlalchemy_example_*.py     # przykłady pracy z ORM
├── sql_to_excel.py             # eksport danych do Excel
├── from_excel_to_sql.py        # import danych do bazy
├── sakila_films.xlsx           # przykładowe dane
├── yolo*.db                    # przykładowe bazy SQLite
├── README.md
└── pyproject.toml
```

---

## 📊 Przykładowe zagadnienia

- Tworzenie tabel przy użyciu `DeclarativeBase`
- Mapowanie kolumn z użyciem `Mapped[]`
- Tworzenie i commitowanie sesji
- Zapytania typu:
  - SELECT
  - filtrowanie danych
  - agregacje
- Eksport wyników zapytań do pliku Excel

---

## ▶️ Jak uruchomić projekt

```bash
git clone https://github.com/MateuszPietkiewicz/sakila_python.git
cd sakila_python

python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

pip install -r requirements.txt
python sqlalchemy_example_3_orm.py
```

---

## 📌 Czego się nauczyłem

- Praktyczne wykorzystanie SQLAlchemy ORM
- Zarządzanie sesją i transakcjami
- Tworzenie relacyjnych modeli danych
- Łączenie SQL z analizą danych w Pythonie
- Organizacja projektu analitycznego

---

## 🚀 Kierunek rozwoju

W przyszłości projekt można rozszerzyć o:
- migracje (Alembic)
- testy jednostkowe
- bardziej złożone zapytania analityczne
- integrację z PostgreSQL

---

## 📄 Status

Projekt edukacyjny – zrealizowany w ramach nauki SQL oraz Data Analysis.