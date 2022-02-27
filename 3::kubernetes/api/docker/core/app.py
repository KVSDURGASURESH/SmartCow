import psutil
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/stats')
def stats():
    cpu = psutil.cpu_percent()
    ram = psutil.virtual_memory().percent

    return jsonify({"ram": ram, "cpu": cpu})

# Removed intentionally - app will be invoke by wsgi as it would be the entry point 

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5000)
