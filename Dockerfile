FROM alpine:3.3
MAINTAINER Chamunks <Chamunks@gmail.com>
## Prepare ##
RUN apk add --update rtorrent && \
    mkdir -p /rtorrent/{downloads, .session, log} && \
    adduser -u 1500 -D rtorrent && \
    chown -R rtorrent:rtorrent /rtorrent && \
        
    
USER rtorrent
WORKDIR "/home/rtorrent"
COPY rtorrent.rc "./.rtorrent.rc"

# Port 49164 is opening incoming connections from other peers.
EXPOSE 49164
# These volumes are mostly optional it depends on how you want to run your container.
VOLUME ["/rtorrent/downloads", "/rtorrent/log", "/rtorrent/.session"]
#ENTRYPOINT  ["rtorrent"]
CMD  ["/usr/bin/screen", "-d", "-m", "-fa", "-S", "rtorrent", "/usr/bin/rtorrent"]
