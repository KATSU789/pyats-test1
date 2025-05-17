# pyats-test1

This repository contains sample tests and a small Flask application which returns
ASCII art.

The application requires `flask` and `pytest` which should be installed with
`pip`:

```bash
pip install flask pyfiglet pytest
```

Due to network restrictions in the execution environment these packages may fail
to install. If installation succeeds, run the application with:

```bash
python ascii_app.py
```

Run tests with:

```bash
pytest
```
