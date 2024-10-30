cd src/main/apigee/apiproxies/LlmProxy-v1
apigeecli apis create bundle -f apiproxy --name $API_NAME -o $PROJECT_ID -t $(gcloud auth print-access-token)
apigeecli apis deploy -n $API_NAME -o $PROJECT_ID -e $APIGEE_ENV -t $(gcloud auth print-access-token) -s "llmservice@$PROJECT_ID.iam.gserviceaccount.com" --ovr
cd ../../../../..