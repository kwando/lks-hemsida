dev:
  find . | entr -s "mix site.build"

serve:
  caddy file-server --browse --root output/

build:
  mix site.build

clean:
  rm -rf output

deploy: build
  fly deploy
