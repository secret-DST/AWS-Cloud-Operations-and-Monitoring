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
- JSON (for scripting)
- Bash (Operational Commands)
- GitHub (documentation and Version Control)

## Steps

### Step 1 - Launch EC2 
The first step includes creating any networking infrastructure if you want to deploy your instance in a particular VPC, Subnet etc.
In addition, an ubuntu-based EC2 instance is launched- ensuring the public IP, HTTP and SSH is enabled. For ease, I utilised the
EC2 user data script to install Apache2 through boot-strapping. (Can be found in user_data.sh)

Once completed successfully, the ec2 metrics can be viewed in the monitoring tab or by navigating to CloudWatch. For testing purposes
I updated the instance --> sudo apt update && sudo apt upgrade. In addition, I installed NGINX through --> sudo apt install nginx.
This incurred CPU utilisation which can be seen in the screenshot below.
<img width="1446" height="555" alt="Screenshot 2026-11-26 075016" src="https://github.com/user-attachments/assets/a9423ac5-c63d-44b2-80ce-754365989983" />

### Step 2 - Configure CloudWatch Monitoring
The next step was to configure CloudWatch to monitor the EC2 instance's availability. I did this by creating a CloudWatch alarm that would automatically 
send an email via SNS if the EC2 failed the system check. The "StatusCheckFailed_System" was the type of metric I configured to monitor. 

Moreover, I leveraged CloudWatchSynthetic Canary to ensure the apache2 website was available. The script was auto-generated after
I specified the websites URL (http://EC2PUBLICIP) and other fields, like frequency of checks etc. The script included configurations that ensured that the return code was 200 to ensure that the website was reachable. Otherwise it would let us know of any underlying issues. 
Below You can see that the Synthetic Canary is accurately setup and retrieving availability metrics from my website.
<img width="503" height="468" alt="Screenshot 2026-11-26 085025" src="https://github.com/user-attachments/assets/7c71df64-43d3-4814-ba1e-c02bd4549879" />

The blue signifies that the status checks have been passed, and the run time status also clearly shows "passed".
<img width="812" height="165" alt="Screenshot 2026-11-26 085001" src="https://github.com/user-attachments/assets/f6438704-b167-4987-b321-de74a76558af" />

The selected canary runs also show the same result. Furthermore, you can see that the synthetic requests are being sent to two 
different browsers to ensure that results aren't restricted to one browser- to prevent surprise anomalies. 

### Step 3 - CloudWatch Agent (Refer to "cloud_watch_agent.sh")
The default information provided to us via the EC2 console can be quite brief. For example, there are many metrics important metrics we want to view,
like access logs, error logs, memory utilisation, disk etc. For this reason, I created an agent to do this. First, I created an IAM role for a EC2 CloudWatch agent. 
Then I modified the IAM role in the "security" settings of the EC2 instance. 

After that, I downloaded the agent on my ec2 and created a configuration file for the cloud watch agent to enable us to retrieve information about: ubuntu system events, ssh authentication events, website requests and errors. Then I started the agent.

Once completed, the logs were visible in --> CloudWatch --> Logs --> Log Groups
Below you can see that there are filters to view various logs.
<img width="635" height="336" alt="Screenshot 2026-11-26 094045" src="https://github.com/user-attachments/assets/a9c49d85-f528-4b04-98c1-b44591fc0292" />

I decided to filter for access logs.
Below are the logs that were captured with the agent.
<img width="925" height="185" alt="Screenshot 2026-11-26 094127" src="https://github.com/user-attachments/assets/56b5b175-9455-4796-8ffa-c4b4277eb051" />

As you can see, there were many access attempts made and they were all successful due to the response code "200". The first few logs were GET requests, there after they were "curl" requests. All these logs were generated by me, to show that the agent had been successfully set up.

### step 4 - CloudWatch Dashboard
Security Considerations

Restricted SSH access to a trusted IP address.
Allowed public HTTP access through port 80.
Used an EC2 IAM role to provide CloudWatch permissions.
Avoided storing AWS access keys directly on the instance.
Monitored authentication and application logs.
Configured CloudWatch alarms for operational issues.

Expected Outcomes

After completing this project:

- A Linux EC2 instance hosts a functioning Apache2 website.
- The website is accessible through its public IP address.
- CloudWatch monitors CPU utilisation and EC2 health.
- CloudWatch Synthetics monitors website availability.
- CloudWatch Agent collects system and Apache2 logs.
- Memory and disk metrics are available.
- CloudWatch dashboards and alarms provide centralised monitoring.

Future Improvements

- Configure HTTPS using an SSL/TLS certificate.
- Register a domain name.
- Configure an Application Load Balancer.
- Implement Auto Scaling.
- Add automated backups.
- Configure more advanced CloudWatch alarms.
- Deploy the infrastructure using Terraform.

Conclusion

This project demonstrates practical experience with AWS cloud infrastructure, Linux server administration, Apache2 web hosting, security group configuration, monitoring, logging, and alerting using Amazon CloudWatch.


