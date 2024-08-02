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

# 02 Installing the Serverless DEMO


