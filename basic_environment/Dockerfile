FROM golang:latest

ENV GOPATH=/home/Go
WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    tmux \
    zsh \
    emacs \
    locales \
    cmake \
    llvm libclang-dev \
    && locale-gen en_US.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && cd /root \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/ami-GS/dotfiles \
    && cp /root/dotfiles/.tmux.conf /root \
    && cp /root/dotfiles/.emacs . \
    && cp /root/dotfiles/.zshrc . \
    && cp -r /root/dotfiles/.emacs.d . \
    && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -P /root/dotfiles \
    && chsh -s /bin/zsh root \
    && git clone https://github.com/Andersbakken/rtags && cd rtags \
    && git submodule init && git submodule update \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMAND=1 && make && make install
CMD tmux -2
