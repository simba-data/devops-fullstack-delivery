from flask import Flask, jsonify
import socket
import time

app = Flask(__name__)

@app.route("/")
def health():
    return "OK", 200

@app.route("/hello")
def hello():
    pod_name = socket.gethostname()
    return jsonify({
        "message": "Hello World!",
        "processed_by": pod_name
        })

@app.route("/stress")
def stress():
    end_time = time.time() + 5
    while time.time() < end_time:
        _ = 1000 * 1000
    return jsonify({"message": "Fin du stress test"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
