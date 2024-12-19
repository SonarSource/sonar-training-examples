from django.http import HttpResponseRedirect

def redirect():
    url = request.GET.get("url", "/")
    return HttpResponseRedirect(url)
