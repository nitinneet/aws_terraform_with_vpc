output "endpoint" {
  value = aws_eks_cluster.ekscluster.endpoint
}
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.ekscluster.certificate_authority[0].data
}

output "db_name" {
  value = aws_db_instance.rdsinstance.name
}
output "db_endpoint" {
  value = aws_db_instance.rdsinstance.endpoint
}

output "efs_example_fsid" {
  value = aws_efs_file_system.example.id
}
