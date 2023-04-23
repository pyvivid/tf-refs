<ul>
  <li> As one of the first steps, we need to prepare our AWS account to allow tf interactions from the tf server.</br>
  <li> Make sure to have created your AWS account before proceeding with the below steps.</br>
  <li> Create an IAM Admin user with programmatic access, with all privileges, in creation of resources and execution of commands on the AWS platform. Make sure to create access and secret key and store them safely for future use
  <li> To Whitelist the tf server’s IP address on the AWS Platform, go to the SG of the default VPC in the region and add the tf server’s IP address to inbound rules.</br>
</ul>
