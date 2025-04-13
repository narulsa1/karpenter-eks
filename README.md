# karpenter-eks
In this project, you will get end to end EKS cluster deployment with Karpenter using terraform


======================================
After karpenter deployment, check for the karpenter pods in kube-system namespcae,

# kubectl get pods -n kube-system

check for the karpenter service-account in kube-system namespcae

# kubectl get sa -n kube-system | grep karpenter



