echo "Creating LLM Product..."
PRODUCT_NAME="LLM Product"
apigeecli products create -n "$PRODUCT_NAME" \
  -m "$PRODUCT_NAME" \
  -o "$PROJECT_ID" -e $APIGEE_ENV \
  -f auto -p "LlmProxy-v1" -t $(gcloud auth print-access-token)

echo "Creating developer..."
DEVELOPER_EMAIL="example-developer@cymbalgroup.com"
apigeecli developers create -n "$DEVELOPER_EMAIL" \
  -f "Example" -s "Developer" \
  -u "$DEVELOPER_EMAIL" -o "$PROJECT_ID" -t $(gcloud auth print-access-token)

echo "Creating app and credentials..."
APP_NAME=llm-app-1
apigeecli apps create --name "$APP_NAME" \
  --email "$DEVELOPER_EMAIL" \
  --prods "$PRODUCT_NAME" \
  --org "$PROJECT_ID" --token $(gcloud auth print-access-token)
