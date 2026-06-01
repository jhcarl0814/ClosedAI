#!/bin/bash

export PATH="$PATH:$(realpath '../../tools/awk_expand_commands'):$(realpath '../../tools/tree'):$(realpath '../../tools/ansi2html')";

function ansi2html_pre () {
	printf '<pre class="f9 b9">';
	ansi2html --bg=dark --palette=xterm --body-only;
	printf '</pre>';
}
export -f ansi2html_pre;

function ls() { command ls --color=always "$@"; }
export -f ls;

mkdir --parents '../../docs/example'

# awk_expand_commands './example.template.html' | tee '../../docs/example/example.html' | awk '{ printf("| %s%s", $0, RT); }; END { if (RT == "" && $0 == "") printf("| \n"); else { if (RT == "") printf("\n"); else printf("| \n"); } }';
awk_expand_commands './example.template.html' >'../../docs/example/example.html'
