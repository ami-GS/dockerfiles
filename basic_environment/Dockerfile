FROM golang:latest

ENV HOME=/home
ENV GOPATH=$HOME/Go
ENV PATH=$PATH:/$GOPATH/bin
WORKDIR $HOME
RUN apt-get update \
    && apt-get install -y \
    tmux \
    htop \
    tig \
    zsh \
    emacs \
    locales \
    cmake \
    llvm libclang-dev \
    ncurses-dev \
    openssh-server \
    # ssh settings
    && mkdir /var/run/sshd \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo -n "root\nroot" | passwd root \
    && service ssh start \
    # locale settings for tmux
    && locale-gen en_US.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    # git settings
    && git config --global user.name ami-GS \
    && git config --global user.email 1991.daiki@gmail.com \
    && cd $HOME \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/ami-GS/dotfiles \
    && cp $HOME/dotfiles/.tmux.conf $HOME \
    && cp $HOME/dotfiles/.emacs . \
    && cp $HOME/dotfiles/.zshrc . \
    && cp -r $HOME/dotfiles/.emacs.d . \
    && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -P $HOME/dotfiles \
    && chsh -s /bin/zsh root \
    # rtags settings
    && git clone https://github.com/Andersbakken/rtags && cd rtags \
    && git submodule init && git submodule update \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMAND=1 && make && make install \
    # gtags settings
    && wget http://tamacom.com/global/global-6.5.6.tar.gz \
    && tar -zxvf global-6.5.6.tar.gz && cd global-6.5.6 && ./configure && make -j && make install -j && cd \
    # ghq settings
    && go get github.com/motemen/ghq \
    && git config --global ghq.root $GOPATH/src \
    # bear settings
    && ghq get https://github.com/rizsotto/Bear \
    && cd $GOPATH/src/github.com/rizsotto/Bear \
    && mkdir build && cd build && cmake .. && make -j && make install -j && cd \
    # golang settings
    && go get github.com/rogpeppe/godef \
    && go get -u github.com/nsf/gocode \
    && go get github.com/golang/lint/golint \
    && go get github.com/kisielk/errcheck \
    && go get github.com/peco/peco/cmd/peco

CMD service ssh start && tmux -2
ENV INDOCKER=y
EXPOSE 22
