# Apigee LLM Sample Proxy
A sample LLM API proxy for Gemini through Apigee with analytics and monetization for token consumption.

```sh
# copy and source env variables
cp 1.env.sh 1.env.local.sh
# edit env vars
nano 1.env.local.sh
source 1.env.local.sh

# enable services and create service account
./2.create-resources.sh

# create apigee API, products & app
./3.deploy-proxies.sh

# get credential from created app
API_KEY=$(apigeecli apps get -o $PROJECT_ID -n llm-app-1 -t $(gcloud auth print-access-token) | jq --raw-output '.[0].credentials[0].consumerKey')

# get apigee hostname for env
HOST_NAME=$(apigeecli envgroups list -o $PROJECT_ID -t $(gcloud auth print-access-token) | jq --raw-output '.environmentGroups[] | select(.name == '\""$APIGEE_ENV\""') | .hostnames[0]')

# call LLM API
curl -X POST "https://$HOST_NAME/v1/llm" \
-H "x-api-key: $API_KEY" \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF

{
	"question": "why is the sky blue?"
}
EOF
```