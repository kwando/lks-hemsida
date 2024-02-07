dev:
  find . | entr -s "mix site.build"

serve:
  cd output && python -m http.server 8000

build:
  mix site.build

clean:
  rm -rf output

deploy: build
  fly deploy
