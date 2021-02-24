FROM alpine
RUN apk add --no-cache vim
RUN echo "vimgolf:x:10000:10000:vimgolf:/home/vimgolf:/bin/sh" >> /etc/passwd && \
    echo "vimgolf:x:10000:vimgolf" >> /etc/group && \
    mkdir /home/vimgolf
COPY eval.sh /scorer/

CMD ["/scorer/eval.sh"]
