for type in deployment service ingress
do
    kubectl delete $type $1
done