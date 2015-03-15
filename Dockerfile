FROM java:8-jre

ADD upload /upload

RUN cd /upload && \
	wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz && \
	wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz && \
	wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
	wget https://download.elasticsearch.org/logstash/logstash/logstash-contrib-1.4.2.tar.gz && \
	tar -xzvf elasticsearch-1.4.4.tar.gz && \
	tar -xzvf kibana-4.0.1-linux-x64.tar.gz && \
	tar -xzvf logstash-1.4.2.tar.gz && \
	tar -xzvf logstash-contrib-1.4.2.tar.gz && \
	mv /upload/start.sh /opt && \
	mv elasticsearch-1.4.4 /opt/elasticsearch && \
	mv kibana-4.0.1-linux-x64 /opt/kibana && \
	mv logstash-1.4.2 /opt/logstash && \
	cp -r logstash-contrib-1.4.2/* /opt/logstash && \
	mkdir /opt/logstash/conf && \
	mkdir /opt/logstash/example && \
	mv elasticsearch.yml /opt/elasticsearch/config && \
	mv logstash.conf /opt/logstash/conf && \
	mv access.log /opt/logstash/example && \
	rm -rf /upload
	
EXPOSE 5601	
	
CMD ["/opt/start.sh"]	