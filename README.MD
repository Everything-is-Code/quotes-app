# 00 Pre Requisites for the DEMO

## Login to the Cluster 
➜  quotes-app git:(main) oc login --token=$TOKEN --server=https://$CLUSTER:6443

## Install ArgoCD
➜  quotes-app git:(main) oc apply -k bootstrap/argocd 
namespace/openshift-gitops created
clusterrolebinding.rbac.authorization.k8s.io/argocd-rbac-ca created
subscription.operators.coreos.com/openshift-gitops-operator created

## Install all the necesary Operators for the DEMO
➜  quotes-app git:(main) ✗ oc apply -f bootstrap/00_operators.yaml 
appproject.argoproj.io/openshift-operators created
application.argoproj.io/openshift-operators created

## Installing the Project for the DEMOS
➜  quotes-app git:(main) ✗ oc apply -f bootstrap/01_quotes-proj.yaml 
appproject.argoproj.io/quotes created

# 01 Installing the first DEMO

## 01.01 Quotes Basic Demo 2 apps using manifest and Kustomize

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/02_quotes-app.yaml
application.argoproj.io/quotes-app created

# 02 Installing the Helm Chart Example

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/03_quotes-chart.yaml           
application.argoproj.io/quotes-chart created

# 03 Installing the Serverless DEMO

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/03_quotes-serverless.yaml 
application.argoproj.io/quotes-serverless created

# 04 Installing the Network Policie DEMO

➜  quotes-app git:(main) oc apply -f bootstrap/05_quotes-network-policy.yaml 
application.argoproj.io/quotes-network-policy created

# 05 Installing the Open Telemetry DEMO
## First we create the following:

➜  quotes-app git:(main) ✗ oc apply -f resources/tempo/00_observability-namespace.yaml 
project.project.openshift.io/observability created
➜  quotes-app git:(main) ✗ oc apply -f resources/tempo/01_tempo-obc.yaml              
objectbucketclaim.objectbucket.io/tempostack-dev-odf created

## Then we retrieve the values for:
  bucket: #retrieve from the ObjectBucketClaim called tempostack-dev-odf
  access_key_id: #retrieve from the noobaa/odf/aws secret
  access_key_secret: #retrieve from the noobaa/odf/aws secret

## And fill the following file "02_tempo-odf-secret.yaml"
## Then we create the rest of the files:

➜  quotes-app git:(main) ✗ oc create -f resources/tempo/02_tempo-odf-secret.yaml 
secret/tempostack-dev-odf created
➜  quotes-app git:(main) ✗ oc create -f resources/tempo/03_tempo-instance.yaml  
tempostack.tempo.grafana.com/simplest created
➜  quotes-app git:(main) ✗ oc create -f resources/tempo/04_tempo-rbac.yaml    
clusterrole.rbac.authorization.k8s.io/tempostack-traces-reader created
clusterrolebinding.rbac.authorization.k8s.io/tempostack-traces-reader created

## Finally we create the app: 

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/06_quotes-telemetry.yaml 
appproject.argoproj.io/quotes-telemetry created
application.argoproj.io/quotes-telemetry created

Now to check it is working we go to the following url

    
https://tempo-simplest-gateway-observability.apps.$CLUSTER.com/api/traces/v1/dev/search

(Note: For the apps to show up we need to make some traffic)