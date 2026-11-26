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
- SNS
- Python (for scripting and automation)
- Bash (Operational Commands)
- GitHub (documentation and Version Control)

