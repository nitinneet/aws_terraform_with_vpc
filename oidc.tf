# I have commented it as thumbprint_list is required.
# refer below link
# https://marcincuber.medium.com/amazon-eks-with-oidc-provider-iam-roles-for-kubernetes-services-accounts-59015d15cb0c
/*
### OIDC config
resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = aws_eks_cluster.ekscluster.identity.0.oidc.0.issuer
}
*/


####### Need DNS thumbprint ######### Check in below blog how to get thumbprint #####
# https://marcincuber.medium.com/amazon-eks-with-oidc-provider-iam-roles-for-kubernetes-services-accounts-59015d15cb0c
