# AWS-Cloud-Operations-and-Monitoring

## Architecture
<img width="912" height="522" alt="image" src="https://github.com/user-attachments/assets/1819b555-a271-4469-8b70-08f2d8acc5b8" />

## Overview
- A client is running an application on AWS an they expect it to be available 24/7.
- In order to provide high availability we will be monitoring the infrastructure, detecting problems, investigating alerts and restoring services.
- The user sends a request to the application via HTTP. (In businesses they restrict traffic to HTTPS but for demo purposes we will use HTTP)
- They are able to access the Linux server hosting the application.
- Amazon CloudWatch monitors the server's health through CPU utilisation application logs.
- If the CloudWatch alarm detects an anomaly, it will trigger a process (alarm) to subsequently communicate this to Amazon SNS. (Simple Notification Service)
- Thereafter, an email will be sent to an engineer to respond and resolve the incident.

## Technologies Used
- AWS EC2
- Linux(ubuntu)
- Amazon CloudWatch
- CloudWatch Agent (collects system metrics and logs)
- CloudWatch Synthetics (website availability and monitoring)
- SNS
- Python (for scripting and automation)
- Bash (Operational Commands)
- GitHub (documentation and Version Control)

## Steps

### Step 1
The first step includes creating any networking infrastructure if you want to deploy your instance in a particular VPC, Subnet etc.
In addition, an ubuntu-based EC2 instance is launched- ensuring the public IP, HTTP and SSH is enabled. For ease, I utilised the
EC2 user data script to install Apache2 through boot-strapping. (Can be found in user_data.sh)
