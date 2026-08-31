FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY bot.py .

# Файл с контактами хранится в /data, чтобы его можно было
# смонтировать как volume и не терять данные при пересборке образа.
ENV EXCEL_FILE=/data/contacts.xlsx
VOLUME ["/data"]

CMD ["python", "bot.py"]
