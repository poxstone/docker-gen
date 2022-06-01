FROM ubuntu/nginx:1.18-21.10_edge

RUN apt update -y && apt upgrade -y && apt install -y net-tools vim tcpdump tmux nmap curl

COPY ./reverse-proxy.conf /etc/nginx/sites-available/reverse-proxy.conf
COPY ./entrypoint.sh /
RUN ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf

ENV HOST_REDIRECT=https://flask-any-response-a-qycvpzb2nq-ue.a.run.app:443/
ENV PORT_EXPOSE=5000

ENTRYPOINT ["bash", "/entrypoint.sh"]

# docker build -t poxstone/nginx-proxy ./;
# docker run -it --rm  -p 9090:80 ubuntu/nginx:1.18-21.10_edge;
# docker run -it --rm -e HOST_REDIRECT="https://flask-any-response-a-qycvpzb2nq-ue.a.run.app:443/" -e PORT_EXPOSE=5000 -p 8080:8080 -p 5000:5000 -p 6000:6000 poxstone/nginx-proxy;
