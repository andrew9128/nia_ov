# Используем Python 3.10
FROM python:3.10

# Устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код
COPY . .

# Запуск Streamlit
CMD ["streamlit", "run", "nia_with_new_db.py"]
