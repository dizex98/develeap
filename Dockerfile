FROM python:3.10.16
WORKDIR /app

RUN python3.10 -m venv venv
RUN . venv/bin/activate

RUN apt-get update && apt-get install -y pkg-config

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080
ENTRYPOINT ["gunicorn", "--workers", "4", "--bind", "0.0.0.0:8080", "--access-logfile", "-", "--error-logfile", "-", "app:app"]