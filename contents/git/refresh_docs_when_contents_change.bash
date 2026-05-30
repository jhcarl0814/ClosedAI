#!/bin/bash

export PATH="$PATH:$(realpath '../../tools/awk_expand_commands'):$(realpath '../../tools/tree'):$(realpath '../../tools/awk_remove_heredoc_leading_spaces'):$(realpath '../../tools/mintty_html_dump')";

function ls() { command ls --color=always "$@"; }
export -f ls;

export GIT_PAGER='cat';

mkdir --parents -- '../../docs/git';

rm --force --recursive -- '/test_git_mintty_html_dump_temp_dir'; mkdir --parents -- "$_"; mintty_html_dump_temp_dir="$_";
export mintty_html_dump_temp_dir;

time_of_last_access_last=;

while true
do
	time_of_last_access="$(find '.' '(' -path '*.html' -or -path '*.js' -or -path '*.css' ')' -and -printf '%p//%T@\n')";

	if [[ "$time_of_last_access" != "$time_of_last_access_last" ]]
	then
		printf 'refresh_begin: %s (%s)\n' "$(date +'%Y-%m-%d %H:%M:%S%:z')" "$(date --utc +'%Y-%m-%d %H:%M:%S%:z')";

		# awk_expand_commands './git.template.html' | tee '../../docs/git/git.html' | awk '{ printf("| %s%s", $0, RT); }; END { if (RT == "" && $0 == "") printf("| \n"); else { if (RT == "") printf("\n"); else printf("| \n"); } }';
		awk_expand_commands './git.template.html' >'../../docs/git/git.html'
		printf '\n';

		printf 'refresh_end: %s (%s)\n' "$(date +'%Y-%m-%d %H:%M:%S%:z')" "$(date --utc +'%Y-%m-%d %H:%M:%S%:z')";
		printf '\n';

		time_of_last_access_last="$time_of_last_access";
	fi

	sleep 1;
done
