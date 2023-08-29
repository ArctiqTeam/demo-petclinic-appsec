set +x

TOKEN="Your token here"

curl https://api.snyk.io/v1/org/arctiq-nfr-shared/project/a3eee9bd-3cfd-470d-9d80-2055f898a70f/ignores \
   -H "Accept: application/json" \
   -H "Authorization: token ${TOKEN}" > ignores.json 

set -x


IGNORES=$(jq 'to_entries[] | .key' ignores.json)

for ISSUE in $IGNORES
do
    # snyk ignore --id="SNYK-ALPINE39-MUSL-458529" --reason="for fun" --expiry=2023-09-28T14:46:49.015Z -d
    snyk ignore --id=${ISSUE} --expiry=2023-09-28T14:46:49.015Z --reason="Skip CI"
done

