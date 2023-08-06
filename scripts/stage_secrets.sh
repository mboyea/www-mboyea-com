#!/bin/bash

# gather env secrets for flyctl
flyctl_env_vars=("$@")
while IFS= read -r input_line || [[ -n "$input_line" ]]; do
	input_line=$(echo $input_line)
	# remove quotes from flyctl env (until https://github.com/superfly/flyctl/issues/589 is resolved)
	flyctl_env_vars+=$(echo "$input_line " | tr -d '"')
done < .env

# set flyctl env secrets
flyctl secrets set --stage ${flyctl_env_vars[@]}
