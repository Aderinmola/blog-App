FROM python:3.9.0-alpine

RUN apk update && apk add \
  bash \
  curl \
  postgresql-dev \
  gcc \
  python3-dev \
  musl-dev \
  wait4ports

ENV PYTHONUNBUFFERED=1

ENV PYTHONDONTWRITEBYTECODE=1

# Install Gunicorn.
RUN pip install "gunicorn>=19.8,<19.9"

WORKDIR /app


# Install Python requirements.
COPY requirements.txt .
RUN python -m pip install -r requirements.txt


# Copy application code.
COPY . .


# Run application
CMD gunicorn --bind 0.0.0.0:$PORT config.wsgi