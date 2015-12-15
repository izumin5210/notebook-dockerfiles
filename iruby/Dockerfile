FROM ruby:2.2.3

COPY scripts/install_jupyter_notebook.sh /tmp
RUN /tmp/install_jupyter_notebook.sh && \
        rm /tmp/install_jupyter_notebook.sh

RUN apt-get update && \
    apt-get install -y libtool-bin && \
    gem install rbczmq && \
    gem install iruby

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

ENTRYPOINT ["tini", "--"]
CMD ["iruby", "notebook"]
