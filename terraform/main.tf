terraform {
  required_providers {}
}

resource "local_file" "example" {
  content  = "hello from terraform"
  filename = "./terraform/sample.txt"
}
