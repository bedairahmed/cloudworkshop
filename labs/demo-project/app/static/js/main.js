/**
 * Cloud Workshop App — Frontend JavaScript
 */

// ---- API Endpoint Tester ----
async function fetchEndpoint(path) {
    const responseEl = document.getElementById('api-response');
    responseEl.innerHTML = '<span style="color: #94A3B8;">Loading...</span>';

    try {
        const response = await fetch(path);
        const data = await response.json();
        responseEl.textContent = JSON.stringify(data, null, 2);
    } catch (error) {
        responseEl.innerHTML = `<span style="color: #EF4444;">Error: ${error.message}</span>`;
    }
}

// ---- Live Clock ----
function updateClock() {
    const timeEl = document.getElementById('server-time');
    if (timeEl) {
        const now = new Date();
        timeEl.textContent = now.toISOString().replace('T', ' ').substring(0, 19) + ' UTC';
    }
}

setInterval(updateClock, 1000);

// ---- Health Check ----
async function checkHealth() {
    try {
        const response = await fetch('/health');
        const data = await response.json();
        console.log(`✅ Health: ${data.status} | v${data.version} | ${data.environment}`);
    } catch (error) {
        console.warn('⚠️ Health check failed:', error.message);
    }
}

setInterval(checkHealth, 30000);

// ---- Init ----
document.addEventListener('DOMContentLoaded', () => {
    console.log('☁️ Cloud Workshop App loaded');
    checkHealth();
});
