"""
Cloud Workshop Demo App
A simple web application to demonstrate cloud-native concepts.
"""

import os
import socket
import datetime
from flask import Flask, render_template, jsonify

app = Flask(__name__)

# ---- Configuration from Environment Variables ----
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
APP_ENV = os.getenv("APP_ENV", "local")
APP_PORT = int(os.getenv("APP_PORT", "8080"))
APP_NAME = os.getenv("APP_NAME", "Cloud Workshop")

# Environment color mapping
ENV_COLORS = {
    "local": "#6B7280",
    "dev": "#3B82F6",
    "staging": "#F59E0B",
    "prod": "#10B981",
}


# ---- Pages ----

@app.route("/")
def home():
    """Main landing page."""
    return render_template(
        "index.html",
        app_name=APP_NAME,
        version=APP_VERSION,
        environment=APP_ENV,
        env_color=ENV_COLORS.get(APP_ENV, "#6B7280"),
        hostname=socket.gethostname(),
        timestamp=datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC"),
    )


# ---- API Endpoints ----

@app.route("/health")
def health():
    """Health check — used by Azure/K8s to verify the app is alive."""
    return jsonify({
        "status": "healthy",
        "version": APP_VERSION,
        "environment": APP_ENV,
    })


@app.route("/api/info")
def info():
    """App metadata endpoint."""
    return jsonify({
        "app": APP_NAME,
        "version": APP_VERSION,
        "environment": APP_ENV,
        "hostname": socket.gethostname(),
        "port": APP_PORT,
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    })


@app.route("/api/env")
def env_info():
    """Show environment variables (filtered — no secrets)."""
    safe_keys = ["APP_VERSION", "APP_ENV", "APP_PORT", "APP_NAME", "HOSTNAME", "WEBSITES_PORT"]
    return jsonify({key: os.getenv(key, "not set") for key in safe_keys})


# ---- Error Handlers ----

@app.errorhandler(404)
def not_found(e):
    """Custom 404 page."""
    return render_template("404.html"), 404


# ---- Main ----

if __name__ == "__main__":
    print(f"🚀 Starting {APP_NAME} v{APP_VERSION} ({APP_ENV})")
    print(f"   http://localhost:{APP_PORT}")
    app.run(host="0.0.0.0", port=APP_PORT, debug=(APP_ENV == "local"))
