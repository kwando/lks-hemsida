dev:
  find . | entr -s "mix site.build"

serve:
  cd output && python -m http.server 8000
