FROM kalilinux/kali-linux-docker

RUN apt-get -y update && apt-get -y dist-upgrade && apt-get install -y kali-linux-top10 kali-linux-web && apt-get clean

CMD ["/bin/bash"]
