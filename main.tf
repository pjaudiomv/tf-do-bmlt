//data "digitalocean_ssh_keys" "keys" {
//  sort {
//    key       = "name"
//    direction = "asc"
//  }
//}

//output "keys" {
//  value = data.digitalocean_ssh_keys.keys
//}

//output "files" {
//  value = {for user in data.digitalocean_ssh_keys.keys: user.name => user}
//}

//output "filess" {
//  value =  data.digitalocean_ssh_keys.keys.ssh_keys.*.id
//}

//output "files" {
//  value = [for s in data.digitalocean_ssh_keys.keys : s]
//}