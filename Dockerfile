FROM  alpine:3.12.0
COPY ./run.sh /
COPY runOnHost.sh /
RUN chmod u+x run.sh
CMD ["./run.sh"]