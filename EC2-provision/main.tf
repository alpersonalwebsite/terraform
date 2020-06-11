provider "aws" {
  access_key = "your-access_key"
  secret_key = "your-secret_key"
  region     = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
/* Note
Using Udacity-T2 instead of Udacity T2 to avoid error:
A name must start with a letter or underscore and may contain only letters,
digits, underscores, and dashes.
*/
resource "aws_instance" "Udacity-T2" {
  count         = "4"
  ami           = "ami-09d95fab7fff3776c"
  instance_type = "t2.micro"
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity-M4" {
  count         = "2"
  ami           = "ami-09d95fab7fff3776c"
  instance_type = "m4.large"
  tags = {
    Name = "Udacity M4"
  }
}
