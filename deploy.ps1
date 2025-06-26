# 1) Set the active GCP project for all gcloud commands
gcloud config set project secopsys-adiel-924

# 2) Enable Docker BuildKit for faster, cache-friendly builds
$Env:DOCKER_BUILDKIT = "1"

# 3) Build the Docker image locally and tag it for the private Artifact Registry repo
docker build -t us-east4-docker.pkg.dev/secopsys-adiel-924/cloud-run-source-deploy/ohif:latest .

# 4) Push the newly built image to Artifact Registry
docker push us-east4-docker.pkg.dev/secopsys-adiel-924/cloud-run-source-deploy/ohif:latest

# 5) Deploy (or update) the Cloud Run service “ohif” using the pushed image
gcloud run deploy ohif --image us-east4-docker.pkg.dev/secopsys-adiel-924/cloud-run-source-deploy/ohif:latest --region us-east4 --platform managed --allow-unauthenticated

# 6) Remove the local image tag to reclaim disk space
docker rmi us-east4-docker.pkg.dev/secopsys-adiel-924/cloud-run-source-deploy/ohif:latest

# 7) Clean up dangling image layers left over from the build
docker image prune -f

# 8) Clear the BuildKit build cache for a fresh start next time
docker builder prune -a -f
