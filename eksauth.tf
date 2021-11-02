#### After the eks cluster is created kubernetes provider needs to authenticate into the cluster. The data source “aws_eks_cluster_auth” provides the token attribute which can be used in doing so #######


data "aws_eks_cluster_auth" "eksauth" {
  name = aws_eks_cluster.ekscluster.name
}
