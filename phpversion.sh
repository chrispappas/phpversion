#!/usr/bin/env bash

# ------------------------------------------------------------------
# checks for a .phpversion file with a numeric version (eg. 8.3) 
# and runs that version for this command
# if the .phpversion file is not present, use default system php
# 
# github.com/chrispappas/phpversion
# ------------------------------------------------------------------

set -euo pipefail

if ! [ -f .phpversion ]; then
	exec /usr/bin/php "$@"
	exit $?
fi

# get the contents of .phpversion and trim whitespace
fileversion=$(cat < .phpversion | xargs)

# simple regex match for "7.4" or "8.x", if invalid log a warning and use default system php
if ! [[ "$fileversion" =~ ^(7\.4|8\.[0-9]+)\s*$ ]]; then
	echo "[phpversion] Invalid .phpversion file, using default system php"
	echo
	exec /usr/bin/php "$@"
	exit $?
fi

# make sure the version corresponds to a valid binary on the system (eg. /usr/bin/php8.2)
# if that version does not exist
phpbinary="/usr/bin/php$fileversion"
if ! [[ -x "$phpbinary" ]]; then
	echo "[phpversion] php executable for the .phpversion not found ($phpbinary)"
	echo "[phpversion] install the desired php version, change the .phpversion, or remove this file to continue"
	exit 1
else
	exec "$phpbinary" "$@"
fi
