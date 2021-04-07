output "public_ip_address" {
  value = oci_core_instance.compute.public_ip
}
output "ping_info" {
  value = "ping ${oci_core_instance.compute.public_ip}"
}
output "ssh_to_node" {
  value = "ssh -i SSH_KEY_PATH opc@${oci_core_instance.compute.public_ip}"
}
output "ssh_port_mapping_for_vnc" {
  value = "ssh -i SSH_KEY_PATH -L 5901:localhost:5901 opc@${oci_core_instance.compute.public_ip}"
}