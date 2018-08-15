FROM golang:latest

ENV HOME=/root
ENV WORKSPACE=$HOME/workspace
ENV GOPATH=$WORKSPACE
ENV PATH=$PATH:/$GOPATH/bin
WORKDIR $HOME
# no RUN could reduce size 0.02GB
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    tmux \
    htop \
    colordiff \
    tig \
    zsh \
    cgdb \
    python-pip exuberant-ctags \
    emacs \
    locales \
    cmake \
    llvm libclang-dev \
    ncurses-dev \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*
    # ssh settings
RUN mkdir /var/run/sshd \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo -n "root\nroot" | passwd root \
    && service ssh start
    # locale settings for tmux
RUN locale-gen en_US.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen
    # git settings
RUN git config --global user.name ami-GS \
    && git config --global user.email 1991.daiki@gmail.com \
    && git clone https://github.com/ami-GS/dotfiles \
    && cp $HOME/dotfiles/.zshrc $HOME \
    && cp $HOME/dotfiles/.tmux.conf $HOME \
    && cp $HOME/dotfiles/.emacs $HOME \
    && cp -r $HOME/dotfiles/.emacs.d $HOME \
    && emacs --daemon -l $HOME/.emacs && pkill emacs \
    && mkdir $HOME/.myconfig \
    && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -P $HOME/.myconfig \
    && rm -rf $HOME/dotfiles \
    && chsh -s /bin/zsh root
    # rtags settings
RUN git clone https://github.com/Andersbakken/rtags && cd $HOME/rtags \
    && git submodule init && git submodule update \
    && mkdir build && cd build \
    # make -j sometimes cause syncronization error
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMAND=1 && make -j && make install \
    && cd $HOME && rm -rf $HOME/rtags
    # irony-install-server
RUN mkdir -p $HOME/irony_build && cd $HOME/irony_build \
    && IRONY_NAME=`find $HOME/.emacs.d/elpa/ -name "irony*" -type d` \
    && cmake -DCMAKE_INSTALL_PREFIX\=$HOME/.emacs.d/irony/ $IRONY_NAME/server && cmake --build . --use-stderr --config Release --target install \
    && rm -rf $HOME/irony_build
    # gtags and jedi settings
RUN pip install setuptools Pygments \
    && pip install -U jedi epc pyflakes virtualenv \
    && wget http://tamacom.com/global/global-6.6.2.tar.gz -P $HOME/gtags \
    && tar -zxvf $HOME/gtags/global-6.6.2.tar.gz -C /$HOME/gtags && cd $HOME/gtags/global-6.6.2 \
    && ./configure && make -j && make install -j && rm -rf $HOME/gtags
    # ghq settings
RUN go get github.com/motemen/ghq \
    && git config --global ghq.root $GOPATH/src
    # bear settings
RUN ghq get https://github.com/rizsotto/Bear \
    && cd $GOPATH/src/github.com/rizsotto/Bear \
    && mkdir build && cd build && cmake .. && make -j && make install -j && cd \
    && rm -rf $GOPATH/src/github.com/rizsotto
    # golang settings
RUN go get github.com/rogpeppe/godef \
    && go get -u github.com/nsf/gocode \
    && go get github.com/golang/lint/golint \
    && go get github.com/kisielk/errcheck \
    && go get github.com/peco/peco/cmd/peco

CMD service ssh start && tmux -2
ENV INDOCKER=y
EXPOSE 22
