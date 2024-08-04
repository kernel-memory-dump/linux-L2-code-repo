from flask import Flask, jsonify
import os
import signal

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify(status="healthy"), 200

@app.route('/crash', methods=['GET'])
def crash():
    os.kill(os.getpid(), signal.SIGINT)
    return "Crashing the app...", 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

