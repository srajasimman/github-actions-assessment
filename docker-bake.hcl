variable "REGISTRY_REPO" {
  default = "srajasimman"
}

group "default" {
  targets = ["github-actions-assessment"]
}

target "github-actions-assessment" {
  context = "./"
  dockerfile = "./Dockerfile"
  tags = ["${REGISTRY_REPO}/github-actions-assessment:${VERSION}"]
}
