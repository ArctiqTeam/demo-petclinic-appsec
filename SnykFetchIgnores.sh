set +x

PROJECT_ID="491d9894-c158-4a71-8a53-7b1101c1f535"

curl https://api.snyk.io/v1/org/arctiq-nfr-shared/project/${PROJECT_ID}/ignores \
    -H "Accept: application/json" \
    -H "Authorization: token ${SNYK_TOKEN}" >ignores.json
set -x

IGNORES=$(jq 'to_entries[] | .key' ignores.json)

rm -rf .snyk

for ISSUE in $IGNORES; do
    ID=$(echo "$ISSUE" | tr -d '"')
    snyk ignore --id=$ID --expiry=2023-09-28T14:46:49.015Z --reason="We will fix this some day..."
done
