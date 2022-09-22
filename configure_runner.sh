#!/bin/sh

GITHUB_OWNER="homechoice"
GITHUB_PAT=""
RUNNER_WORKDIR="_work"
RUNNER_NAME="prod-vm"
RUNNER_LABELS="prod-vm"
RUNNER_GROUP="EKS-Runners"
RUNNER_ALLOW_RUNASROOT="1"

#./config.sh remove

# using a static token
registration_url="https://api.github.com/enterprises/${GITHUB_OWNER}/actions/runners/registration-token"
echo "Requesting registration URL at '${registration_url}'"

payload=$(curl -sX POST -H "Authorization: token ${GITHUB_PAT}" ${registration_url})
export RUNNER_TOKEN=$(echo $payload | jq .token --raw-output)

/actions-runner/config.sh \
    --name ${RUNNER_NAME}-$(hostname) \
    --token ${RUNNER_TOKEN} \
    --url https://github.com/enterprises/${GITHUB_OWNER} \
    --work ${RUNNER_WORKDIR} \
    --labels ${RUNNER_LABELS} \
    --runnergroup ${RUNNER_GROUP} \
    --unattended \
    --replace