# Set the base image to alpline:latest
FROM alpine

# Author
LABEL maintainer="nqiu <nicholas.chiu.qiu@qq.com>"

# Set HOME variable
ENV HOME /root

COPY .vimrc $HOME
COPY .zshrc $HOME

# Install packages
RUN apk update && \
    apk add libc-dev && \
    apk add zsh vim curl git python3 ctags && \
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh && \
    pip3 install -U pip && \
    pip3 install pep8 flake8 pyflakes isort yapf && \
    vim +PluginInstall +qall --not-a-term &> /dev/null || echo "vim install packages complete!" && \
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

WORKDIR /root

CMD ["/bin/zsh"]
