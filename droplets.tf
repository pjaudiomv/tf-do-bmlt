resource "digitalocean_droplet" "web" {
  count  = 1
  image  = "ubuntu-18-04-x64"
  name   = "bmlt-${count.index}"
  region = "nyc3"
  size   = "s-1vcpu-1gb"

  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  provisioner "remote-exec" {
    inline = ["sudo apt-get update", "sudo apt-get install jq -y"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' apache-install.yml"
  }
}

output "droplet_ip_addresses" {
  value = {
  for droplet in digitalocean_droplet.web:
  droplet.name => droplet.ipv4_address
  }
}

resource "digitalocean_ssh_key" "default" {
  name       = "PJ Work"
  public_key = file(var.pub_key)
}

variable "pvt_key" {
  type = string
  default = "~/.ssh/id_rsa"
}

variable "pub_key" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}
