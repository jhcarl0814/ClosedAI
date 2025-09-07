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

time_of_last_access_last=;

while true
do
	time_of_last_access="$(find '.' '(' -path '*.html' -or -path '*.js' -or -path '*.css' ')' -and -printf '%p//%T@\n')";

	if [[ "$time_of_last_access" != "$time_of_last_access_last" ]]
	then
		printf '%s (%s)\n' "$(date +'%Y-%m-%d %H:%M:%S%:z')" "$(date --utc +'%Y-%m-%d %H:%M:%S%:z')";

		# awk_expand_commands './example.template.html' | tee '../../docs/example/example.html' | awk '{ printf("| %s%s", $0, RT); }; END { if (RT == "" && $0 == "") printf("| \n"); else { if (RT == "") printf("\n"); else printf("| \n"); } }';
		awk_expand_commands './example.template.html' >'../../docs/example/example.html'
		printf '\n';

		time_of_last_access_last="$time_of_last_access";
	fi

	sleep 1;
done
