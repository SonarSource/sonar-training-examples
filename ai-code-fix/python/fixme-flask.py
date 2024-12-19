import sqlite3
from flask import Flask, redirect

app = Flask("example")

@app.route("/redirecting")
def redirecting():
    url = request.args["url"]
    return redirect(url)

@app.route('/user')
def get_users():
    user = request.args["user"]
    sql = """SELECT user FROM users WHERE user = \'%s\'"""

    conn = sqlite3.connect('example')
    conn.cursor().execute(sql % (user)) # Noncompliant