# AI CodeFix examples

## Use case

Small Python files that each raise an issue SonarQube can propose an AI-generated fix for. The
point of the example is to show the **AI CodeFix** suggestion on the issue page, accept it, and
compare it against the already-correct version of the same code.

AI CodeFix must be enabled for the organization or instance, and for this project, before the
suggestions appear.

## Files

| File | What it demonstrates |
| --- | --- |
| `python/fixme-django.py` | Open redirect: a user-controlled `url` is passed straight to `HttpResponseRedirect` |
| `python/fixme-flask.py` | Open redirect plus a SQL injection built with `%` string formatting |
| `python/python-sql-injection.py` | The same query written safely, with a parameterized statement, for comparison |
| `python/flask-hello.py` | A trivial clean Flask app, so the project is not made only of issues |

`fixme-django.py` references `request` without importing it, which is fine: SonarQube analyzes
Python without executing it, and the open redirect is still detected. The Flask file does import
`request`, because without that import the taint engine cannot follow `request.args` and neither
the open redirect nor the SQL injection is reported.

## Usage

```
sonar-scanner
```

This creates a project named **AI CodeFix examples** (key `ai-code-fix`). Open any issue in the
project and use the **Get AI fix suggestion** button.

The dependencies in `python/requirements.txt` are only needed if you want to actually run the
examples; the analysis does not require them.
