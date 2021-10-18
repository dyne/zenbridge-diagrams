alias b := build
alias d := deploy
alias r := render

default: build render

build format="dot":
      mkdir -p {{format}}
      structurizr-cli export -format {{format}} -w src/ -o {{format}}

dot: (build "dot")

deploy:
      structurizr-cli push -id $STID -key $STKEY -secret $STSECRET -w src/

mermaid: (build "mermaid")

theme: (build "theme")

plantuml: (build "plantuml")

render:
    #!/usr/bin/env sh
    for file in `ls ./dot`; do
        dot dot/$file -Tsvg > svg/$file.svg
    done

set dotenv-load := true

