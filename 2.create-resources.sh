echo "Setting project to $PROJECT_ID"
gcloud config set project $PROJECT_ID

echo "Enabling services..."
gcloud services enable aiplatform.googleapis.com

echo "Creating service account..."
gcloud iam service-accounts create llmservice \
  --description="LLM service account" \
  --display-name="LLM Service"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:llmservice@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/aiplatform.user"