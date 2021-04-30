## Introduction

# Justification

What I offer here is a basic example of deploying an AWS infrastructure using Terraform.  You can use this simple structure to deploy a simple EC2 instance with a VPC and attached Security Group.  With the configuration in this project, you should be able to quickly and easily securely access your Instance from the terminal from a local Linux or Mac device.

Do not expect this to be complete with all industry best practices, however, if you are new to working with Terraform then this could be a good sample project to start with! I hope that you will find some use in 'poking' this implementation to see how it works and changing it to see how it breaks. Below I will explain what some important sections of the code are doing so that you can start to build your deployments.

## Project Modules

### VPC

Starting with the VPC, this module creates the resources required for setting up a basic VPC.  We will start by looking at the **data.tf** file, we see a data block, this is a special block that returns a list of all the AZ's available with your selected region (in our case eu-west-2).  You don't need to select an AZ like this, however doing so means that we will always select a valid AZ for our Subnet, without having to do any research.  In later sessions we will also see how we could a similar approach to create resources across multiple AZ's, ensuring HA (High Availability).

Next, in the **variables.tf**  we can see 3 variables that we will be using to help us create the resources in the **main.tf** file of the module, these variables are given a value in the **main.tf** file in the root of the project, though we will look at that later.

Looking in the main.tf file, we have an **aws_vpc** resource block, we are defining the CIDR range that our VPC will use by using the cidr_block attribute and referring to the *vpc-cidr-block* variable that we also declare.  We are also setting up dns support and assigning a name to our vpc using a tag.

Moving onto the **aws_subnet** resource block, you can see that we have made use of the Data block we defined earlier in the data.tf file, as well as attaching this subnet to our VPC, and adding a relevant CIDR block.

The next resource block, **aws_internet_gateway** creates the IGW that our VPC will use, remember that you can only have one IGW per VPC.  We have given this IGW a name using Tags so that we can easily refer to it later.

The next 2 resource blocks, **aws_route_table** and **aws_main_route_table_association** will create the route table used by our VPC and attach it.  We have only defined one route in our route table and this is all that we need for this deployment.

In the *outputs.tf* file we have defined 2 output blocks that we will need to use in other areas of our deployment.

### SG

First, we will look at the **data.tf** file, in here we have defined a *locals* and a *data* block.

The data block, sends a GET Request to https://ifconfig.me, I wanted a way to programmatically include my IP address into the creation of the SG such that only my IP would be allowed to SSH into the machine, ensuring a little more security in my system.  It is the locals block that takes this output to be used later in the **main.tf** file.

In the **main.tf** file, in the resource block for this module, we are creating the SG that our VPC needs.  We are creating an Ingress to port 22 for our SSH connection, ensuring that we use our IP address as described in the previous section.  We are also creating an Egress rule that allows outgoing communication to the Internet. 

### EC2

This module will have the most tangible purpose, however, it also relies on the other 2 sections created earlier hence why it has been left to the end.

In the **data.tf** file we are using a special data block to get the AMI id for the ***AMAZON 2*** image available in our region.  Again we could do this without the data block, however as the AMI id's for the *** AMAZON 2*** are different for each region our code would not be particularly portable.  It's also easier than finding the AMI id for the image you want to use, assuming you are using an AWS supplied AMI.

In the **main.tf** filer, the first resource block registers the key pair that we will use to connect to our instance. You do need to ensure that you already have a key pair created on your system, here I have just used the default values when *ssh-keygen* is used.  This step means we can quickly connect to the EC2 instance once it has been created.

The final resource is the **aws_instance** we are creating.  We use a lot of information that we have discussed and defined elsewhere, sometimes in different modules, but if you look at the attributes that we are declaring you should be able to see the structure of the EC2 instance we are creating.