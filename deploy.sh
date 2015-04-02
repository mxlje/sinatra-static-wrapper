echo "Deploying to viaduct"
curl  -H "X-Auth-Token:  $VDT_AUTH_TOKEN"         \
      -H "X-Auth-Secret: $VDT_AUTH_SECRET"        \
      -X POST                                     \
      -d 'params={"application":"dd2569c0bcdd"}'  \
      http://eu.httpbin.org/post
