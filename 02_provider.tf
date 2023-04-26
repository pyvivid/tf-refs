# Best practice to save the keys is in a dedicated secrets file.
# file 3 will show use of env variable for access keys.
provider "aws"{
    version = "4.64.0"
    region = "us-west-2"
    #access_key = "Enter_UR_Access_Key_Here"
    #secret_ket = "Enter_your_secret_key_here"
}
