# compute instance
resource "oci_core_instance" "compute" {
    availability_domain = local.ad
    compartment_id = var.compartment_ocid
    shape = local.compute_shape
    display_name = local.compute_display_name
    create_vnic_details {
        assign_public_ip = true
        display_name = local.compute_display_name
        hostname_label = local.compute_hostname
        subnet_id = oci_core_subnet.pub_sub.id
    }
    fault_domain = "FAULT-DOMAIN-${local.fd_number}"
    freeform_tags = {"Department"= "Finance"}
    metadata = {
        ssh_authorized_keys = "${var.ssh_public_key}\n${tls_private_key.ssh.public_key_openssh}"
    }
    source_details {
        source_id = var.image[var.region]
        source_type = "image"
    }
    preserve_boot_volume = false
}

# ssh private key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

# vncserver setup file
resource "null_resource" "send_vncserver_file" {
  provisioner "file" {
    source     = "./setup-vncserver.sh"
    destination = "/home/opc/setup-vncserver.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}
# paraview setup file
resource "null_resource" "send_paraview_file" {
  provisioner "file" {
    source     = "./setup-paraview.sh"
    destination = "/home/opc/setup-paraview.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}
resource "null_resource" "execute_commands" {
  depends_on = [null_resource.send_vncserver_file, null_resource.send_paraview_file]
  provisioner "remote-exec" {
    inline = [
      "chmod a+x /home/opc/setup-vncserver.sh",
      "/home/opc/setup-vncserver.sh",
      "chmod a+x /home/opc/setup-paraview.sh",
      "/home/opc/setup-paraview.sh",
      # get motorbike content from Object Storage
      "wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/Z9yaEj5EBmciVjmIYpTvFFLMfxHmQW23U68nVfTkJbT7nYx3wlH8u8Ca_HPrK55p/n/hpc_limited_availability/b/large_files/o/work.tar.gz",
      "tar -xf work.tar.gz",
    ]
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
}
}