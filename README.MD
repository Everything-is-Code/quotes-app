➜  quotes-app git:(main) oc login --token=$TOKEN --server=https://$CLUSTER:6443

➜  quotes-app git:(main) oc apply -k bootstrap/argocd 

namespace/openshift-gitops created
clusterrolebinding.rbac.authorization.k8s.io/argocd-rbac-ca created
subscription.operators.coreos.com/openshift-gitops-operator created

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/00_operators.yaml 

appproject.argoproj.io/openshift-operators created
application.argoproj.io/openshift-operators created

➜  quotes-app git:(main) ✗ oc apply -f bootstrap/01_quotes-proj.yaml 

appproject.argoproj.io/quotes created

