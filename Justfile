alias b := build
alias r := render

default: build render

build:
      structurizr-cli export -format dot -w src/ -o dot

render:
    #!/usr/bin/env sh
    for file in `ls ./dot`; do
        dot dot/$file -Tsvg > svg/$file.svg
    done
