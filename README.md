dq-tf-lambda-test

This repository contains two dedicated subnets for Lambda functions that require access to private resources (such as RDS instances)

The Lambda service will manage ENIs within the subnets.

They are dedicated as per Lambda best practises: each ENI requires an IP and the subnet size ensures that other resources cannot use up the required IPs.
