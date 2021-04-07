# set   TF_VAR_ variables: $ source env.sh
# unset TF_VAR_ variables: $ unset ${!TF_VAR_@}
# inspect TF_VAR_ variables: $ env | grep TF_VAR_
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaacg2kx2vh5y62jvq7bqpgmt7komml6rshkw4hlidt5y2su5gacyja
export TF_VAR_user_ocid=ocid1.user.oc1..aaaaaaaalac7en7gb2ng5styx5353jidqfs2qp5w57uerdk4mop3mbdp3rrq
export TF_VAR_fingerprint=78:24:c2:2e:b7:e5:94:d9:0a:50:f8:e8:ce:95:df:ae
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem # example
export TF_VAR_region=us-phoenix-1 # example
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaakhkm2aq7ycoipubh4rhkdhv7ktgoulwuwwltcivv2vtu5qvum72q
export TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub) # example