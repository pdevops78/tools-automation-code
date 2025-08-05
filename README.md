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

grafana:
=======
* click on "Add visualization"
* Down there is a build and code options
* In metrics browser give "up" query
* click on "run queries"
* observer right side "visualization" there are multiple graphs 
stat format:
=============

* project prometheus data in "stat format"
* 1 means up and 0 means down
* click on "Add value mappings" , enter 1 in value and Display text as "up"
* click on "Text Mode" will get value
* under "Legend" add {{name}} based on label it displays name and click on "Run Queries"
* 

PromQL:
=======
* up{job=~".*"}
* up{job=~.+} both are same .+ and .*
* to get all node related names by using this expression: {__name__=~"node.*"}
* up offset 5m , 5minutes back data
* up +10 arithmetic expressions
* up + up
* up /up
* floating values: node_cpu_seconds_total
* ceil(node_cpu_seconds_total) : high value will display
* floor(node_cpu_seconds_total) : low value will display
* - Counter: A metric that only increases over time. It never decreases. This is used for things like total request count, bytes sent, or error occurrences—basically anything that accumulates. Example: http_requests_total
- Gauge: A metric that can go up and down over time. It represents a current value, like CPU usage, memory consumption, or temperature. Example: cpu_temperature

important concepts
==================
opertators=Num operator
value type (guage/counter)
functions
usecase:1
==========
memory usage
network usage project on grafana

calculate cpu on prometheus dashboard:(in linux top command is used to know how much cpu use)
======================================
node_cpu_seconds_total
required only frontend : node_cpu_seconds_total{name="frontend"}
rate(node_cpu_seconds_total){name="frontend"}[1m]
rate(node_cpu_seconds_total){name="frontend"}[1m]*100
how much we use the cpu of each server to calculate
100-(rate(node_cpu_seconds_total){name="frontend"}[1m]*100)
100-(rate(node_cpu_seconds_total){name="frontend",mode="idle"}[1m]*100)
avg by (name) (100-(rate(node_cpu_seconds_total){name="frontend",mode="idle"}[1m]*100))

memory usage:(in linux free command is used to know how much memory use and cat /proc/meminfo)
=============
available vs free
=================
free : never touch memory
available: how much memory left
free -h : available memory
node_memory_Memfree_bytes/ node_memory_MemTotal_bytes , to get free memory

network usage:
==============
node_network_receive_bytes_total{name="frontend"}
node_network_transmit_bytes_total{name="frontend"}
node_network_transmit_bytes_total{name="frontend"} * -1


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



1. instance are up on prometheus dashboard
2. visualize the above data on grafana


Logs:
=====
Transactional logs:
-------------------
Logs that have information about business transactions.
Ex: Amount transfer in a bank

Non-Transactional Logs:
-----------------------
Apps generally produce logs about its functionality like whether it can connect to DBm whether it can connect to any pheripherals.

ELK
---
ElasticSearch(DB)
LogStash(Transform)
kibana(UI)

to know size :
==============
cd /usr/share/elasticsearch
du -h elasticsearch, total disk space used
du -sh elasticsearch
df -h . (if it is in root level), /dev/mapper/RootVG--rootvol
cd /home/
df -h .(to know home level),/dev/mapper/RootVG--homevol


elasticsearch:(r7i.large)
==============
elasticsearch.repo
-------------------
[elasticsearch]
name=Elasticsearch repository for 9.x packages
baseurl=https://artifacts.elastic.co/packages/9.x/yum
gpgcheck=0
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1


install elasticsearch:
----------------------
sudo dnf install elasticsearch

start and stop elasticsearch
-----------------------------
sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
systemctl enable elasticsearch.service

Install kibana:
================
kibana.repo 

[kibana-9.X]
name=Kibana repository for 9.x packages
baseurl=https://artifacts.elastic.co/packages/9.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md

sudo dnf install kibana

Open kibana.yml in a text editor.
---------------------------------
kibana server reads properties from kibana.yml file
by default kibana will run on localhost:5601 it will work only itself , so to connect to outside need to change in kibana.yml file
#server.host: localhost
server.host: 0.0.0.0
#server.port: 5601 

Run Kibana with systemd
-----------------------
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service
sudo systemctl stop kibana.service
sudo systemctl status kibana

packages install path:
======================
-  /usr/local/lib/ or /usr/lib/

kibana home directory:
----------------------
/usr/share/kibana

/usr/share/kibana/bin , binaries
config files:(kibana.yml)
-------------
/usr/share/kibana/bin

log files:
-----------
/var/log/kibana	

plugins:
---------
/usr/share/kibana/plugins

logstash:
---------
logstash.repo
--------------
[logstash-9.x]
name=Elastic repository for 9.x packages
baseurl=https://artifacts.elastic.co/packages/9.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md

Install logstash:
-----------------
sudo dnf install logstash
sudo systemctl start logstash.service

how to collect logs from component?
===================================
go to /etc/logstash/conf.d
create a conf file: 
frontend.conf
-------------

input{
file{
path => "/var/log/nginx/access.log"
}
}

how to send logs to elasticsearch?
==================================
output {
elasticsearch {
hosts => "http://localhost:9200"
data_stream => "auto"
user => ""
password => ""
index => "frontend-log-%{+yyyy.MM.dd}"
}
}


Security configuration installation:
-------------------------------------
Running scriptlet: elasticsearch-9.0.2-1.x86_64                                                                                                        1/1
--------------------------- Security autoconfiguration information ------------------------------

Authentication and authorization are enabled.
TLS for the transport and HTTP layers is enabled and configured.

The generated password for the elastic built-in superuser is : sT1tVagtnU5uO0DfRjxO

If this node should join an existing cluster, you can reconfigure this with
'/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token-here>'
after creating an enrollment token on your existing cluster.

You can complete the following actions at any time:

Reset the password of the elastic built-in superuser with
'/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic'.

Generate an enrollment token for Kibana instances with
'/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana'.

Generate an enrollment token for Elasticsearch nodes with
'/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node'.

-------------------------------------------------------------------------------------------------
### NOT starting on installation, please execute the following statements to configure elasticsearch service to start automatically using systemd
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
### You can start elasticsearch service by executing
sudo systemctl start elasticsearch.service

/usr/lib/tmpfiles.d/elasticsearch.conf:1: Line references path below legacy directory /var/run/, updating /var/run/elasticsearch → /run/elasticsearch; please update the tmpfiles.d/ drop-in file accordingly.

Verifying        : elasticsearch-9.0.2-1.x86_641/1


history:
========
1  15/06/25 05:24:29 vim  /etc/yum.repos.d/elasticsearch.repo
2  15/06/25 05:24:52 dnf install elasticsearch -y
3  15/06/25 05:25:54 cd /etc/yum.repos.d
4  15/06/25 05:25:56 ls -l
5  15/06/25 05:26:08 vim elasticsearch.repo
6  15/06/25 05:26:38 dnf install elasticsearch -y
7  15/06/25 05:30:04 systemctl status elasticsearch
8  15/06/25 05:30:12 systemctl enable elasticsearch
9  15/06/25 05:30:16 systemctl status elasticsearch
10  15/06/25 05:30:52 systemctl start elasticsearch
11  15/06/25 05:31:05 systemctl start elasticsearch.service
12  15/06/25 05:31:13 systemctl status elasticsearch
13  15/06/25 05:31:22 netstat -lntp
14  15/06/25 05:31:56 vim kibana.repo
15  15/06/25 05:32:33 dnf install kibana -y
16  15/06/25 05:33:07 systemctl status kibana
17  15/06/25 05:33:14 systemctl enable  kibana
18  15/06/25 05:33:28 systemctl start kibana.service
19  15/06/25 05:33:35 systemctl status kibana.service
20  15/06/25 05:33:40 netstat -lntp
21  15/06/25 05:33:56 cd /var/log
22  15/06/25 05:33:58 ls -l
23  15/06/25 05:34:07 cd
24  15/06/25 05:34:13 cd /var/log/kibana
25  15/06/25 05:34:15 ls -l
26  15/06/25 05:34:46 cd /usr/share
27  15/06/25 05:34:48 ls -l
28  15/06/25 05:34:57 cd kibana
29  15/06/25 05:34:58 ls -l
30  15/06/25 05:35:04 cd bin
31  15/06/25 05:35:05 ls -l
32  15/06/25 05:35:20 vim kibana
33  15/06/25 05:36:26 dnf list | grep kibana.yml
34  15/06/25 05:37:23 cd ..
35  15/06/25 05:37:24 ls -l
36  15/06/25 05:37:45 cd /etc/kibana
37  15/06/25 05:37:47 ls -l
38  15/06/25 05:37:55 vim kibana.yml
39  15/06/25 05:38:24 systemctl restart kibana.service
40  15/06/25 05:38:33 systemctl status  kibana.service
41  15/06/25 05:38:39 netsat -lntp
42  15/06/25 05:38:44 netstat -lntp
43  15/06/25 05:41:48 '/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana'
44  15/06/25 05:41:53 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
45  15/06/25 05:42:50 cd /usr/share
46  15/06/25 05:42:52 ls -l
47  15/06/25 05:42:54 cd kibana
48  15/06/25 05:42:56 ls -l
49  15/06/25 05:42:59 cd bin
50  15/06/25 05:43:20 ls -l
51  15/06/25 05:43:31 cat kibana-verification-code
52  15/06/25 05:43:39 cat kibana-verification-code.bat
53  15/06/25 05:44:18 cat /usr/share/kibana/bin/kibana-verification-code.bat
54  15/06/25 05:44:46  /usr/share/kibana/bin/kibana-verification-code.bat
55  15/06/25 05:44:54 /usr/share/kibana/bin/kibana-verification-code.bat
56  15/06/25 05:47:26 cd ../../..
57  15/06/25 05:47:28 cd ..
58  15/06/25 05:47:29 cd
59  15/06/25 05:47:41 /usr/share/kibana/bin/kibana-verification-code.bat
60  15/06/25 05:47:50 /usr/share/kibana/bin/kibana-verification-code
61  15/06/25 05:48:16 cat /usr/share/kibana/bin/kibana-verification-code
62  15/06/25 05:48:34 cd  /usr/share/kibana/bin
63  15/06/25 05:48:36 ls -l
64  15/06/25 05:48:39 kibana-verification-code
65  15/06/25 05:48:51 /usr/share/kibana/bin/kibana-verification-code
66  15/06/25 05:52:18 cd
67  15/06/25 05:52:23 cd /etc/yum.repos.d
68  15/06/25 05:52:31 vim logstash.repo
69  15/06/25 06:03:32 dnf install logstash -y
70  15/06/25 06:04:39 systemctl status logstash.service
71  15/06/25 06:05:48 systemctl enable logstash.service
72  15/06/25 06:06:07 systemctl start  logstash.service
73  15/06/25 06:06:10 systemctl status logstash.service
74  15/06/25 06:06:19 netstat -lntp
75  15/06/25 06:06:47 cd
76  15/06/25 06:10:09 git clone https://github.com/pdevops78/expense-ansible
77  15/06/25 06:10:15 cd
78  15/06/25 06:10:18 ls -l
79  15/06/25 06:10:21 cd expense-ansible
80  15/06/25 06:10:25 git pull
81  15/06/25 06:10:48 ls -l
82  15/06/25 06:11:08 cd roles
83  15/06/25 06:11:09 ls -l
84  15/06/25 06:11:19 mkdir logstash
85  15/06/25 06:11:26 cd logstash
86  15/06/25 06:11:52 cd


how to loop multi vault paths?


rysyslog.conf:
===============
$umask 0022
template(name="OnlyMsg" type="string" string="%msg:::drop-last-lf%\n")

if( $programname == '{{component}}' ) then {
action(type="omfile" file="/var/log/{{component}}.log" template="OnlyMsg")
& stop
}

frontend.log
-------------

backend.log


How my app is working ?
how my server is working?
notify any issues:
Server Performance:
------------------
to calculate,cpu,memory through prometheus, grafana

Application Performance:
-------------------------
newrelic 


Logs on each server to check
Log Management
(we cannot login to each and every server manually to check the logs , we need a place to see them at single place: by using elk )


vault latest credentials:
===========================
Initial root token
hvs.T8WnPWmYmGZkPYlGAHXVmebk

hvs.T8WnPWmYmGZkPYlGAHXVmebk
Key 1
eHVr7eLa14r8nlx98L5TD9MT3JqTTXypYfhLSJixz+g=


github self hosted runner:
===========================
1  06/07/25 03:00:41 mkdir actions-runner && cd actions-runner
2  06/07/25 03:00:50 curl -o actions-runner-linux-x64-2.325.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.325.0/actions-runner-linux-x64-2.325.0.tar.gz
3  06/07/25 03:00:59 tar xzf ./actions-runner-linux-x64-2.325.0.tar.gz
4  06/07/25 03:01:07 ./config.sh --url https://github.com/pdevops78 --token A5LROC2K3PLZUAK7Y45KFCDINH2N2
5  06/07/25 03:01:24 sudo ./bin/installdependencies.sh
6  06/07/25 03:02:36 ./config.sh --url https://github.com/pdevops78 --token A5LROC2K3PLZUAK7Y45KFCDINH2N2
7  06/07/25 03:03:31 ls -l
8  06/07/25 03:03:37 ./run.sh
9  06/07/25 03:04:14 sudo ./svc.sh install ;
10  06/07/25 03:04:24 sudo ./svc.sh start
11  06/07/25 03:07:39 history


==================================
1  07/07/25 10:07:04 git clone https://github.com/pdevops78/tools-automation                                                                                                             -code
2  07/07/25 10:07:12 ls
3  07/07/25 10:07:16 cd tools-automation-code
4  07/07/25 10:07:18 ls
5  07/07/25 10:07:35 which ssh
6  07/07/25 10:08:02 pip version
7  07/07/25 10:08:07 pip
8  07/07/25 10:08:13 pip --version
9  07/07/25 10:08:20 ansible --version
10  07/07/25 10:08:30 sudo dnf install asnible -y
11  07/07/25 10:09:29 openssl --version
12  07/07/25 10:09:37 openssl version
13  07/07/25 10:10:09 sudo dnf remove openssh-server openssh-client
14  07/07/25 10:10:25 sudo dnf install openssh-server openssh-client -y
15  07/07/25 10:10:59 openssl version
16  07/07/25 10:11:18 which ssh
17  07/07/25 10:11:25 ssh
18  07/07/25 10:11:43 ls
19  07/07/25 10:11:47 cd tools-automation-code
20  07/07/25 10:12:17 ansible-playbook -i 172.31.29.229, tools.yaml -e tool_n                                                                                                             ame -e ansible_user=ec2-user -e ansible_password=DevOps321
21  07/07/25 10:12:32 ansible-playbook -i 172.31.29.229, tools.yaml -e tool_n                                                                                                             ame=ci-server -e ansible_user=ec2-user -e ansible_password=DevOps321
22  07/07/25 10:13:13 sudo systemctl status sshd
23  07/07/25 10:13:29 sudo 'systemctl daemon-reload
24  07/07/25 10:13:39 sudo systemctl daemon-reload
25  07/07/25 10:13:44 sudo systemctl status sshd
26  07/07/25 10:14:06 sudo systemctl start sshd
27  07/07/25 10:14:53 sudo netstat -tulnp | grep :22
28  07/07/25 10:15:17 ping 172.31.29.229
29  07/07/25 10:15:47 which ssh
30  07/07/25 10:15:59  sudo systemctl status sshd
31  07/07/25 10:16:10  sudo systemctl restart  sshd
32  07/07/25 10:16:48 sudo yum install -y openssh-server
33  07/07/25 10:17:19 sudo systemctl daemon-reload
34  07/07/25 10:17:42 sudo systemctl enable sshd
35  07/07/25 10:17:55 sudo systemctl start sshd
36  07/07/25 10:18:11 sudo systemctl status sshd
37  07/07/25 10:18:53 ls /usr/lib/systemd/system/sshd.service
38  07/07/25 10:19:10 openssl --version
39  07/07/25 10:19:16 openssl version
40  07/07/25 10:20:43 ls
41  07/07/25 10:20:48 cd tools-automation-code
42  07/07/25 10:20:51 cd
43  07/07/25 10:20:57 rm -rf github-runner
44  07/07/25 10:21:05 cd tools-automation-code
45  07/07/25 10:21:58 ansible-playbook -i 172.31.29.229, tools.yaml -e tool_n                                                                                                             ame=ci-server -e ansible_user=ec2-user -e ansible_password=DevOps321



to encrypt a string in go server:
================================
curl 'http://34.229.84.194:8153/go/api/admin/encrypt' \
-H 'Accept: application/vnd.go.cd.v1+json' \
-H 'Content-Type: application/json' \
-X POST -d '{
"value": "hvs.T8WnPWmYmGZkPYlGAHXVmebk"
}'

"encrypted_value" : "AES:wBVyA9p4gjT1tIo4UqR5sQ==:J1rU2Xuh0vqJreTN0XUn5D8pyInq2jF/ta1jT3neUwA="


grafana dashboard:(/etc/grafana/provisioning/datasources)
=========================================================
name: type: prometheus
access: proxy
url: https://grafana-internal.pdevops78.online:9090
httpmethod: POST
manageAlerts: true
prometheusType: prometheus
cacheLevel: High
disableRecordingRules: false
rest of the data has to remove and restart grafana


generate an api key in grafana dashboard:
=========================================
* administration>users and access > Service accounts
click on Add Service account token
* Required json file:
====================
* click on Dashboard
* create Dashboard
* click on "Add Visualization"
* click on "prometheus"
* enter "prometheus" in datasource field
* in time series(right panel) title: sample
* add "up" and click on "Run queries"
* click on "apply"
* save this dashboard with name and click on "save"
* goto "settings" on the top, will find a "JSONModel"
add json path through ansible
=============================
- name: Export dashboard
  community.grafana.grafana_dashboard:
  grafana_url: http://grafana.company.com
  grafana_user: "admin"
  grafana_password: "{{ grafana_password }}"
  path: "{{ lookup('ansible.builtin.template', './sample.json') }}"



lookup function:
Yes, it fetches data from outside the playbook, like:
files
environment variables
external commands
templates
It returns that data as a string (or list, depending on the plugin).

✅ template (in context of lookup('template', ...)):
This is a lookup plugin that:
Loads a file (usually in templates/)
Processes it using Jinja2 templating
Returns the rendered result dynamically based on variables in the playbook

* lookup will not fetch data directly, so first store the template in remote and from remote it should take 

* go to the dashboard,create one new folder 
create a folder on grafana dashboard in ansible playbook


* create grafana,prometheus
* install prometheus and grafana 
* add service 
* install node exporter 
* add node exporter in prometheus.yml file
* open both grafana and prometheus dashboard
* in grafana , create a folder
* create a grafana dashboard
* add up query in prometheus and visible in grafana dashboard


* master or main : lint code and code review
* developer: lint code , unit tests , integration tests, Code Review
* tag: npm install and release code
* 