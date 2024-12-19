import sqlite3
import flask

app = flask.Flask("example")

@app.route('/user')
def get_users():
    user = flask.request.args["user"]
    sql = "SELECT user FROM users WHERE user = ?"

    conn = sqlite3.connect('example')
    conn.cursor().execute(sql, (user,))