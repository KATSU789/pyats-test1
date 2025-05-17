import pytest

import ascii_app


def test_index_route():
    app = ascii_app.app
    app.testing = True
    client = app.test_client()
    resp = client.get('/')
    assert resp.status_code == 200
    assert ascii_app.ASCII_ART in resp.get_data(as_text=True)
