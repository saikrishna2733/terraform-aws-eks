output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
output "cluster-arn" {
  value = "${aws_eks_cluster.eks.arn}"
}
output "cluster-name" {
  value = aws_eks_cluster.eks.name
}
