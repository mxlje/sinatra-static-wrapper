echo "Deploying to Viaduct"

curl -H "X-Auth-Token: $VDT_AUTH_TOKEN" -H "X-Auth-Secret: $VDT_AUTH_SECRET" -X POST -d 'params={"application":"dd2569c0bcdd"}' https://api.viaduct.io/api/v1/deployments/start