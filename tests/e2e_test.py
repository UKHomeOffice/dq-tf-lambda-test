# pylint: disable=missing-docstring, line-too-long, protected-access, E1101, C0202, E0602, W0109
import unittest
import hashlib
from runner import Runner


class TestE2E(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.snippet = """
            provider "aws" {
              region = "eu-west-2"
              profile = "foo"
              skip_credentials_validation = true
              skip_get_ec2_platforms = true
            }
            module "root_modules" {
              source = "./mymodule"
              providers = aws = aws
              appsvpc_id                        = "1234"
              dq_lambda_subnet_cidr             = "10.1.42.0/24"
              apps_vpc_id                       = "vpc-12345"
              naming_suffix                     = "apps-preprod-dq"
            }
        """
        self.runner = Runner(self.snippet)
        self.result = self.runner.result


    def test_subnet_vpc(self):
        self.assertEqual(self.runner.get_value("module.root_modules.aws_subnet.lambda_subnet", "vpc_id"), "1234")

    def test_subnet_cidr(self):
        self.assertEqual(self.runner.get_value("module.root_modules.aws_subnet.lambda_subnet", "cidr_block"), "10.1.42.0/24")

    def test_subnet_tags(self):
        self.assertEqual(self.runner.get_value("module.root_modules.aws_subnet.lambda_subnet", "tags"), {'Name': "subnet-lambda-apps-preprod-dq"})

    def test_security_group_tags(self):
        self.assertEqual(self.runner.get_value("module.root_modules.aws_security_group.sgrp", "tags"), {'Name': "sg-lambda-apps-preprod-dq"})

if __name__ == '__main__':
    unittest.main()
