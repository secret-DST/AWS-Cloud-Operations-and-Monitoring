sudo apt update
sudo apt install wget curl nano -y

wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

sudo apt install apache2 -y

sudo systemctl enable --now apache2

sudo nano /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

## ADD THIS JSON IN YOUR NANO FILE!!!
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "metrics": {
    "namespace": "MyEC2Monitoring",
    "append_dimensions": {
      "InstanceId": "${aws:InstanceId}"
    },
    "metrics_collected": {
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "resources": [
          "/"
        ],
        "metrics_collection_interval": 60
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/syslog",
            "log_group_name": "/ec2/ubuntu/syslog",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/var/log/auth.log",
            "log_group_name": "/ec2/ubuntu/auth",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/var/log/apache2/access.log",
            "log_group_name": "/ec2/apache2/access",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/var/log/apache2/error.log",
            "log_group_name": "/ec2/apache2/error",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}

# start CW agent 
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
-s

# Expected Status
{
  "status": "running"
}

## Generate acticity before checking logs
