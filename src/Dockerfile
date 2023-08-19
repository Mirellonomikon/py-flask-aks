FROM python:3.9-slim-bullseye

WORKDIR /app

RUN apt-get update && \
    apt-get install -y build-essential cmake libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install -U pip wheel && \
    pip install --upgrade pip setuptools wheel

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

ENV FLASK_APP=app.py

CMD [ "flask", "run", "--host=0.0.0.0" ]
