#!/bin/bash

cd /opt/elasticsearch
bin/elasticsearch -d
cd /opt/kibana
bin/kibana > /dev/null 2>&1 &
cd /opt/logstash
bin/logstash -f conf/logstash.conf