try:
    from flask import Flask
except ImportError as e:
    raise ImportError(
        "Flask is required to run this application. Install it with 'pip install flask'."
    ) from e

ASCII_ART = (
    "  _____ _           _\n"
    " |  ___(_)_ __   __| | ___\n"
    " | |_  | | '_ \\ / _` |/ _ \\\n"
    " |  _| | | | | | (_| |  __/\n"
    " |_|   |_|_| |_|\__,_|\___|\n"
)

app = Flask(__name__)

@app.route('/')
def index():
    # Return ASCII art wrapped in preformatted text for browser display
    return f"<pre>{ASCII_ART}</pre>"

if __name__ == '__main__':
    app.run()
