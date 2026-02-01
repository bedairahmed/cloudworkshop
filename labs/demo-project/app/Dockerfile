# ============================================================
# Dockerfile — Cloud Workshop App
# ============================================================

# Base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies (cached layer)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Port & defaults
EXPOSE 8080
ENV APP_VERSION=1.0.0 \
    APP_ENV=container \
    APP_PORT=8080 \
    APP_NAME="Cloud Workshop"

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')" || exit 1

# Run with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "--access-logfile", "-", "app:app"]
