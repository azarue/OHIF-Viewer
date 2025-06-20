# Secopsys

## Helpful Information

* [Integrating the viewer with Google Cloud Healthcare](https://docs.ohif.org/deployment/google-cloud-healthcare)

## Modifications

We use the Google Health API so the project needs to load the Google configuration, in the development environment, we set it using an envrionment variable.

```bash
yarn run dev:secopsys
```

<p>To bypass the oAuth, we removed the [oidc] and we will provide the token directly in the URL as a query paramter:</p>

http://localhost:3000/viewer?StudyInstanceUIDs={uid}&token={token}

## Deployment
### Local
```
docker build -t ohif-local .
docker image inspect ohif-local --format '{{json .Config.ExposedPorts}}'
docker run --name ohif-test -e PUBLIC_URL=/ -e PORT=8080 -p 3000:8080 ohif-local
```
### Cloud
```
.\deploy.ps1
```
