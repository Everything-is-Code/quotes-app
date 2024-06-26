# templates/get-wildcard.sh.tpl
#!/bin/bash

# Replace 'ingress_name' with the actual name of your ingress resource
wildcard_hostname=$(kubectl get ingress/ingress_name -o jsonpath='{.spec.rules[?(@.host=="*.yourdomain.com")].host}')

# Set the retrieved value as the chart variable
echo "wildcard_hostname=${wildcard_hostname}"