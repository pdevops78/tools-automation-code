# tools-automation-code
Monitoring tools:
================
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
*  47  03/06/25 01:36:34 ls -l prometheus.yml
   48  03/06/25 01:38:35 vim /etc/systemd/system/prometheus.service
   49  03/06/25 01:40:24 systemctl status prometheus
   50  03/06/25 01:40:36 systemctl restart prometheus
   51  03/06/25 01:40:44 systemctl daemon-reload
   52  03/06/25 01:40:47 systemctl restart prometheus
   53  03/06/25 01:40:54 systemctl restart prometheus ; tail -f /var/log/messages
   54  03/06/25 01:41:57 netstat -lntp
