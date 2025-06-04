# tools-automation-code
Install terraform
=================
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform


Monitoring tools:
================
what is monitoring?
Monitoring refers to tracking the performance and status of instances, such as CPU usage, memory consumption, and network activity, to ensure smooth operation and detect issues.

Scrape interval:
================
- scrape interval is set to 10s in prometheus.yml, Prometheus will collect metrics every 10 seconds from the target instance.

target instance:
================
A target instance refers to a specific system, server, or virtual machine that is designated to receive and process requests or data.

to carry nodes on prometheus , need to install node_exporter

install node_Exporter:
======================
curl -L -O https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz

* to execute on one single ip address then we should go for static_configs
* Autodiscovery in Prometheus allows multiple nodes to automatically send metrics to the Prometheus dashboard using Node Exporter.
prometheus dashboard:
======================
* node_cpu_seconds_total 
* node_memory_MemFree_bytes

use cases:
==========
* A single node needs to display metrics on the Prometheus dashboard using Node Exporter. 
Use "static_configs"

"All running instances should display metrics on the Prometheus dashboard using Node Exporter.
Use 'auto discovery'."

* to monitor only project instances(means multiple prometheus servers are running, in that which prometheus server needs to monitor ) not all running instances

* how to get instance detailed data like name of the instance ,....


Errors:
=======
could not describe instance : NoCredentialProviders that there are no valid AWS credentials available to authenticate the request.( so Iam role is required)
NoCredentialProviders" error means that there are no valid AWS credentials available to authenticate the request.

to remove previous list of instances in roles:
==============================================
aws iam list-instance-profiles ,// to remove list of instance profiles
# Step 1: Create an IAM Role
aws iam create-role --role-name MyEC2Role --assume-role-policy-document file://trust-policy.json

# Step 2: Create an Instance Profile
aws iam create-instance-profile --instance-profile-name MyInstanceProfile

# Step 3: Add IAM Role to Instance Profile
aws iam add-role-to-instance-profile --instance-profile-name MyInstanceProfile --role-name MyEC2Role

# Step 4: Attach Instance Profile to EC2 Instance
aws ec2 associate-iam-instance-profile --instance-id i-XXXXXXXX --iam-instance-profile Name=MyInstanceProfile

Example EC2 IAM Actions
- ec2:StartInstances – Start an EC2 instance.
- ec2:StopInstances – Stop an instance.
- ec2:DescribeInstances – Retrieve information about instances.
- ec2:TerminateInstances – Delete an instance.
- ec2:AttachVolume – Attach an EBS volume to an instance.

- aws_iam_policy → Creates a standalone managed policy that can be attached to multiple roles, users, or groups.
- aws_iam_role_policy → Defines an inline policy, which is embedded directly within a specific IAM role and cannot be reused.
  📌 Inline policies are embedded inside a role and cannot be reused.
  📌 aws_iam_role_policy allows defining an inline policy outside the role but is still specific to one role.
  📌 Managed policies (aws_iam_policy) are separate and attached using aws_iam_role_policy_attachment.

prometheus
-----------
* Download prometheus
  /opt/sonarqube-25.5.0.107428/bin/linux-x86-64 

  1  03/06/25 01:23:45 ls -l
  2  03/06/25 01:23:47 cd /opt
  3  03/06/25 01:23:49 ls-l
  4  03/06/25 01:23:51 ls -l
  5  03/06/25 01:23:56 cd aws
  6  03/06/25 01:23:57 ls -l
  7  03/06/25 01:24:00 cd bin
  8  03/06/25 01:24:02 ls -l
  9  03/06/25 01:24:13 cd ../..
  10  03/06/25 01:24:35 https://github.com/prometheus/prometheus/releases/download/v2.53.4/prometheus-2.53.4.linux-amd64.tar.gz
  11  03/06/25 01:24:43 curl -L -o https://github.com/prometheus/prometheus/releases/download/v2.53.4/prometheus-2.53.4.linux-amd64.tar.gz
  12  03/06/25 01:24:54 curl -L -O https://github.com/prometheus/prometheus/releases/download/v2.53.4/prometheus-2.53.4.linux-amd64.tar.gz
  13  03/06/25 01:24:56 ls -l
  14  03/06/25 01:25:05 tar -xvf prometheus-2.53.4.linux-amd64.tar.gz
  15  03/06/25 01:25:10 ls -l
  16  03/06/25 01:25:18 cd prometheus-2.53.4.linux-amd64
  17  03/06/25 01:25:20 ls -l
  18  03/06/25 01:25:31 ./prometheus
  19  03/06/25 01:26:03 ./prometheus ; tail -f /var/log/messages
  20  03/06/25 01:27:14 cd /etc/systemd/system
  21  03/06/25 01:27:15 ls -l
  22  03/06/25 01:27:46 cd /opt
  23  03/06/25 01:27:47 ls -l
  24  03/06/25 01:27:51 cd prometheus-2.53.4.linux-amd64
  25  03/06/25 01:27:52 ls -l
  26  03/06/25 01:27:58 cat prometheus.yml
  27  03/06/25 01:28:13 netstat -lntp
  28  03/06/25 01:28:26 systemctl status prometheus
  29  03/06/25 01:28:44 cd /etc/systemd/system
  30  03/06/25 01:28:46 ls -l
  31  03/06/25 01:29:04 vim prometheus.service
  32  03/06/25 01:31:36 systemctl restart prometheus
  33  03/06/25 01:31:44 systemctl status prometheus
  34  03/06/25 01:31:55 systemctl enable prometheus
  35  03/06/25 01:31:58 systemctl status prometheus
  36  03/06/25 01:32:10 systemctl restart prometheus ; tail -f /var/log/messages
  37  03/06/25 01:33:02 netstat -lntp
  38  03/06/25 01:34:14 cd
  39  03/06/25 01:34:19 useradd expense
  40  03/06/25 01:34:23 cd /opt
  41  03/06/25 01:34:24 ls -l
  42  03/06/25 01:34:44 chown -R expense:expense /opt/prometheus-2.53.4.linux-amd64
  43  03/06/25 01:34:46 ls -l
  44  03/06/25 01:34:49 cd prometheus-2.53.4.linux-amd64
  45  03/06/25 01:34:50 ls -l
  46  03/06/25 01:35:12 systemctl restart prometheus ; tail -f /var/log/messages
* 47  03/06/25 01:36:34 ls -l prometheus.yml
   48  03/06/25 01:38:35 vim /etc/systemd/system/prometheus.service
   49  03/06/25 01:40:24 systemctl status prometheus
   50  03/06/25 01:40:36 systemctl restart prometheus
   51  03/06/25 01:40:44 systemctl daemon-reload
   52  03/06/25 01:40:47 systemctl restart prometheus
   53  03/06/25 01:40:54 systemctl restart prometheus ; tail -f /var/log/messages
   54  03/06/25 01:41:57 netstat -lntp


node_exporter:
==============
54  04/06/25 09:30:05 cd /opt
55  04/06/25 09:30:18 curl -L -O https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
56  04/06/25 09:30:20 ls -l
57  04/06/25 09:30:29 tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz
58  04/06/25 09:30:32 ls -l
59  04/06/25 09:30:37 cd node_exporter-1.9.1.linux-amd64
60  04/06/25 09:30:38 ls -l
61  04/06/25 09:30:52 ./node_exporter
62  04/06/25 09:31:02 cd ..

