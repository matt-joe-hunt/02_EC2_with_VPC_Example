data "http" "my_public_ip" {
  url = "https://ifconfig.me"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  my_ip = data.http.my_public_ip.body
}