#!/bin/sh
set -x

############
# SETTINGS #
############

OUTPUT_FILE='age.json'

#####################
# DECLARE VARIABLES #
#####################

# get the current branch of the 'awesome-lemmy-instances' repo
current_branch=$(git branch --show-current)

#############
# FUNCTIONS #
#############

FATAL() {
	printf 'FATAL: %s. Aborting.\n' "$*"
	exit 1
}

#############
# API QUERY #
#############

# some pre-run output for debugging
ls -lah

curl 'https://api.fediverse.observer/' -X POST -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' -H 'Content-Type: application/json' --data-raw '{"query":"query{\n  nodes (softwarename: \"lemmy\") {\ndomain monthsmonitored\n  }\n}\n"}' > "${OUTPUT_FILE}"

# some post-run output for debugging
ls -lah
du -sh *
wc -l "${OUTPUT_FILE}"
head --bytes 1024 "${OUTPUT_FILE}"
tail --bytes 1024 "${OUTPUT_FILE}"

exit 0
