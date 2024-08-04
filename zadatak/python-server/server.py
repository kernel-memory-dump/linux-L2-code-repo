from flask import Flask, jsonify
import os
import signal

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify(status="healthy"), 200

@app.route('/crash', methods=['GET'])
def crash():
    os._exit(1)  # Immediately terminates the process

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

