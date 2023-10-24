#!/bin/bash

# gather env secrets for flyctl
flyctl_env_vars=("$@")
while IFS= read -r input_line || [[ -n "$input_line" ]]; do
	# prevent overlapping writes to array (don't know why this happens)
	input_line=$(echo $input_line)
	# ignore comments
	if [[ "$input_line" == '#'* ]]; then
		continue
	fi
	# remove quotes (until https://github.com/superfly/flyctl/issues/589 is resolved)
	flyctl_env_vars+=$(echo "$input_line " | tr -d '"')
done < .env

# set flyctl env secrets
flyctl secrets set --stage ${flyctl_env_vars[@]}
