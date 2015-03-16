# Logstash + Elasticsearch + Kibana

### NOT FOR PRODUCTION !

This is a super-easy to use Logstash docker image that includes everything you need to collect, parse, store logs, search logs, visualise logs and extract different sort of information from logs.

This all-in-one logstash stack image includes:

* JDK 8
* Logstash 1.4.2
* Elasticsearch 1.4.4
* Kibana 4.0.1

To start container, simply run

```
docker run -d \
   --name logstash \
   -p 5601:5601 \
   beh01der/logstash-es-kibana
```

Kibana web interface will become available on port ```5601```.
This image comes with build-in example **logstash.conf** file

```
input { 
  file {
    path => "/opt/logstash/example/access.log"  
    start_position => "beginning"	    
  }
} 

filter {
  grok {
    match => ["message", "%{COMMONAPACHELOG}"]
  }
  
  date { 
    match => [ "timestamp", "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
}

output { 
  elasticsearch { 
    host => localhost 
  } 
  
  stdout {
    codec => rubydebug
  }
}
```

and **example log file** (in Apache access log format) automatically loaded on startup to populate empty elasticsearch database with some initial data. This can be disabled by overriding default **logstash.conf** file.

```
64.242.88.10 - - [14/Mar/2015:16:05:49 -0800] "GET /twiki/bin/edit/Main/Double_bounce_sender?topicparent=Main.ConfigurationVariables HTTP/1.1" 401 12846
64.242.88.10 - - [14/Mar/2015:16:06:51 -0800] "GET /twiki/bin/rdiff/TWiki/NewUserTemplate?rev1=1.3&rev2=1.2 HTTP/1.1" 200 4523
64.242.88.10 - - [14/Mar/2015:16:10:02 -0800] "GET /mailman/listinfo/hsdivision HTTP/1.1" 200 6291
...
```

To customise logstash configuration, simply map (override) **logstash.conf** file

```
docker run -d \
   --name logstash \
   -p 5601:5601 \
   -v path-to-your-logstash-conf:/opt/logstash/conf/logstash.conf \
   beh01der/logstash-es-kibana
```

For debugging you can run this image in interactive mode

```
docker run -i -t \
   --name logstash \
   -p 5601:5601 \
   -v path-to-your-logstash-conf:/opt/logstash/conf/logstash.conf \
   beh01der/logstash-es-kibana \
   /bin/bash

then inside the container run:
/opt/start.sh
```
