data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}
data "oci_identity_regions" "available_regions" {
  filter {
    name = "name"
    values = [var.region]
    regex = false
  }
}