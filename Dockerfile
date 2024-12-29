FROM python:3.10-alpine3.21
WORKDIR /app

RUN python3.10 -m venv venv
RUN source venv/bin/activate

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080
ENTRYPOINT ["gunicorn", "--workers", "4", "--bind", "0.0.0.0:8080", "--access-logfile", "-", "--error-logfile", "-", "app:app"]