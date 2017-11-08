FROM golang:latest

ENV GOPATH=/home/Go
WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    tmux \
    zsh \
    emacs \
    locales \
    && locale-gen en_US.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && cd /root \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/ami-GS/dotfiles \
    && cp /root/dotfiles/.tmux.conf /root \
    && cp /root/dotfiles/.emacs . \
    && cp /root/dotfiles/.zshrc . \
    && chsh -s /bin/zsh root \
    && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -P /root/dotfiles \
    && cp -r /root/dotfiles/.emacs.d .

CMD tmux -2
