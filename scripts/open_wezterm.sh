#!/usr/bin/env bash

# # Detect MacOS
[[ "${OSTYPE:-$(uname -s)}" =~ (D|d)arwin ]] && {
	# Detects if WezTerm is running
	if ! pgrep -f "WezTerm" >/dev/null 2>&1; then
		open -a "/Applications/WezTerm.app"
	else
		# Create a new window
		script='tell application "WezTerm" to create window with default profile'
		! osascript -e "${script}" >/dev/null 2>&1 && {
			# Get pids for any app with "iTerm" and kill
			while IFS="" read -r pid; do
				kill -15 "${pid}"
			done < <(pgrep -f "WezTerm")
			open -a "/Applications/WezTerm.app"
		}
	fi
}
