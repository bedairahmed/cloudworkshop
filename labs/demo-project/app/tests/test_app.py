"""
Tests for the Cloud Workshop App.
Run: python -m pytest tests/ -v
"""

import pytest
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
from app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_home_page(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"Cloud Workshop" in response.data


def test_health_endpoint(client):
    response = client.get("/health")
    data = response.get_json()
    assert response.status_code == 200
    assert data["status"] == "healthy"


def test_api_info(client):
    response = client.get("/api/info")
    data = response.get_json()
    assert response.status_code == 200
    assert "version" in data
    assert "environment" in data


def test_api_env(client):
    response = client.get("/api/env")
    data = response.get_json()
    assert response.status_code == 200
    assert "APP_VERSION" in data


def test_404_page(client):
    response = client.get("/nonexistent")
    assert response.status_code == 404
