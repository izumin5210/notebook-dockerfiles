FROM trenpixster/elixir

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

COPY scripts/install_jupyter_notebook.sh /tmp
RUN /tmp/install_jupyter_notebook.sh && \
        rm /tmp/install_jupyter_notebook.sh

RUN jupyterHome=$HOME/.ipython/kernels/ && \
    cd $HOME && \
    git clone https://github.com/pprzetacznik/IElixir.git && \
    cd IElixir && \
    mix deps.get && \
    mix test && \
    MIX_ENV=prod mix compile && \
    ./install_script.sh

COPY ielixir/start_script.sh $HOME/IElixir

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "notebook"]
