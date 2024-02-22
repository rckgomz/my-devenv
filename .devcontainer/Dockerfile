# syntax=docker/dockerfile:1.4-labs
#
# [Choice] Java version (use -bullseye variants on local arm64/Apple Silicon): 11, 17, 11-bullseye, 17-bullseye, 11-buster, 17-buster
ARG VARIANT=21-bookworm
FROM mcr.microsoft.com/vscode/devcontainers/java:${VARIANT}

# [Option] Install Maven
ARG INSTALL_MAVEN="false"
ARG MAVEN_VERSION=""
# [Option] Install Gradle
ARG INSTALL_GRADLE="false"
ARG GRADLE_VERSION=""
RUN if [ "${INSTALL_MAVEN}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/sdkman/bin/sdkman-init.sh && sdk install maven \"${MAVEN_VERSION}\""; fi \
  && if [ "${INSTALL_GRADLE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/sdkman/bin/sdkman-init.sh && sdk install gradle \"${GRADLE_VERSION}\""; fi

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends \
  fzf \
  vim \
  fd-find \
  ripgrep \
  python3 \
  python3-pip \
  python3-venv \
  python3-proselint \
  python3-numpy \
  python3-dev \
  python-dev-is-python3 \
  xsel \
  xclip \
  unzip \
  urlview \
  shellcheck \
  tzdata \
  lsb-release \
  clang-format-14 \
  xdg-utils \
  libpq-dev \
  build-essential \
  make \
  libncurses5-dev  \
  libevent-dev \
  default-mysql-client \
  libglu1-mesa \
  xz-utils \
  clang \
  cmake \
  ninja-build \
  pkg-config \
  libgtk-3-dev \
  ruby-full \
  libpath-tiny-perl \
  dnsutils \
  iputils-ping \
  libreadline-dev \
  netcat-traditional \
  dos2unix \
  zstd \
  file \
  bison \
  byacc \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*
ENV TZ="America/Chicago"

# aws cli
RUN AWS_DOWNLOAD_DIR=$(mktemp -d) \
  && FILE="awscli-exe-linux-x86_64.zip" \
  && URL="https://awscli.amazonaws.com/${FILE}" \
  && wget ${URL} -P ${AWS_DOWNLOAD_DIR} \
  && unzip ${AWS_DOWNLOAD_DIR}/${FILE} -d ${AWS_DOWNLOAD_DIR} \
  && ${AWS_DOWNLOAD_DIR}/aws/install

# aws sam
RUN AWS_SAM_DOWNLOAD_DIR=$(mktemp -d) \
  && FILE="aws-sam-cli-linux-x86_64.zip" \
  && URL="https://github.com/aws/aws-sam-cli/releases/latest/download/${FILE}" \
  && wget ${URL} -P ${AWS_SAM_DOWNLOAD_DIR} \
  && unzip ${AWS_SAM_DOWNLOAD_DIR}/${FILE} -d ${AWS_SAM_DOWNLOAD_DIR}/sam-installation \
  && ${AWS_SAM_DOWNLOAD_DIR}/sam-installation/install

# httpie
RUN curl -sL https://packages.httpie.io/deb/KEY.gpg | \
  gpg --dearmor | \
  sudo tee /etc/apt/trusted.gpg.d/httpie.gpg > /dev/null \
  && echo "deb https://packages.httpie.io/deb ./" | \
  tee /etc/apt/sources.list.d/httpie.list \
  && apt-get -y update \
  && apt-get -y install httpie \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

#############################################################################################
#
# Tools for coding in the terminal using neovim, and tmux
#
#############################################################################################

# locale
RUN locale-gen "en_US.UTF-8" \
  && LC_ALL=en_US.UTF-8 \
  && LANG=en_US.UTF-8 \
  && git clone https://github.com/powerline/fonts.git --depth=1 \
  && sh fonts/install.sh \
  && rm -rf fonts

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# python
RUN python3 -m venv /opt/venv
RUN . /opt/venv/bin/activate && pip3 install pynvim  mycli pgcli localstack awscli-local
RUN . /opt/venv/bin/activate && pip3 install aws-sam-cli-local

# tmux
RUN TMUX_DOWNLOAD_DIR=$(mktemp -d) \
  && TMUX_VERSION=$(curl -s "https://api.github.com/repos/tmux/tmux/releases/latest" | jq -r ".tag_name") \
  && FILE=tmux-${TMUX_VERSION}.tar.gz \
  && URL="https://github.com/tmux/tmux/releases/latest/download/${FILE}" \
  && wget ${URL} -P ${TMUX_DOWNLOAD_DIR} \
  && cd ${TMUX_DOWNLOAD_DIR} && tar -xf "${TMUX_DOWNLOAD_DIR}/${FILE}" && cd .. \
  && cd ${TMUX_DOWNLOAD_DIR}/tmux-${TMUX_VERSION}/ \
  && PKG_CONFIG_PATH=/home/vscode/.local/lib/pkgconfig ./configure --prefix=/home/vscode/.local \
  && make && make install

# rust
RUN su vscode -c "umask 0002 && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# golang
ENV PATH=${PATH}:/usr/local/go/bin
RUN GO111MODULE=auto \
  && DOWNLOAD_DIR=$(mktemp -d) \
  && GOVERSION=$(curl https://go.dev/dl/\?mode\=json | jq ".[0].version" | sed s/\"//g) \
  && echo ${GOVERSIN} \
  && wget https://storage.googleapis.com/golang/${GOVERSION}.linux-amd64.tar.gz -P ${DOWNLOAD_DIR} \
  && tar -C /usr/local -xzf ${DOWNLOAD_DIR}/${GOVERSION}.linux-amd64.tar.gz

# android sdk
ENV ANDROID_HOME="/home/vscode/android_sdk"
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"
ENV ANDROID_USER_HOME="/home/vscode/.android"
RUN ANDROID_DOWNLOAD_DIR=$(mktemp -d) \
  && ANDROID_VERSION="9477386" \
  && FILE="commandlinetools-linux-${ANDROID_VERSION}_latest.zip" \
  && URL="https://dl.google.com/android/repository/${FILE}" \
  && wget ${URL} -P ${ANDROID_DOWNLOAD_DIR} \
  && mkdir -p /home/vscode/android_sdk \
  && unzip ${ANDROID_DOWNLOAD_DIR}/${FILE} -d /home/vscode/android_sdk/tmp \
  && mkdir -p /home/vscode/android_sdk/cmdline-tools/latest \
  && mv /home/vscode/android_sdk/tmp/cmdline-tools/* /home/vscode/android_sdk/cmdline-tools/latest/ \
  && rm -rf /vscode/home/android_sdk/tmp \
  && su vscode -c "umask 0002 && mkdir /home/vscode/.android && touch /home/vscode/.android/repositories.cfg" \
  && su vscode -c "umask 0002 && yes Y | /home/vscode/android_sdk/cmdline-tools/latest/bin/sdkmanager --licenses" \
  && chmod -R a+w /home/vscode/android_sdk \
  && yes Y | /home/vscode/android_sdk/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" \
  && /home/vscode/android_sdk/cmdline-tools/latest/bin/sdkmanager "build-tools;30.0.3" "platform-tools" "platforms;android-33" "sources;android-33"

RUN grep -qxF "$(which zsh)" "/etc/shells" || bash -c "echo $(which zsh) >> /etc/shells" \
  && grep -qxF "$(which zsh)" "/etc/shells" && chsh -s "$(which zsh)" "vscode"

#[Optional] Uncomment if you want to install more global vscode modules
RUN su vscode -c "umask 0002 && npm install -g pnpm && mkdir -p /home/vscode/.pnpm/store"
ENV PNPM_HOME="/home/vscode/.pnpm/store"
ENV PATH="${PNPM_HOME}:${PATH}"
RUN su vscode -c "umask 0002 && pnpm install -g @commitlint/cli @commitlint/config-conventional neovim \
  tree-sitter-cli nx  nativescript  aws-cdk aws-cdk-local log4js"

# btm
RUN BTM_DOWNLOAD_DIR=$(mktemp -d) \
  && BOTTOM_VERSION=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | jq -r ".tag_name") \
  && wget "https://github.com/ClementTsang/bottom/releases/download/${BOTTOM_VERSION}/bottom_${BOTTOM_VERSION}_amd64.deb" \
  -P ${BTM_DOWNLOAD_DIR} \
  && dpkg -i ${BTM_DOWNLOAD_DIR}/bottom_${BOTTOM_VERSION}_amd64.deb

# bat
RUN BAT_DOWNLOAD_DIR=$(mktemp -d) \
  && BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | jq -r ".tag_name | .[1:]") \
  && wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" \
  -P ${BAT_DOWNLOAD_DIR} \
  && dpkg -i ${BAT_DOWNLOAD_DIR}/bat_${BAT_VERSION}_amd64.deb

# lsd
RUN LSD_DOWNLOAD_DIR=$(mktemp -d) \
  && LSD_DOWNLOAD_VERSION=$(curl -s "https://api.github.com/repos/lsd-rs/lsd/releases/latest" | jq -r ".tag_name") \
  && LSD_VERSION=$(curl -s "https://api.github.com/repos/lsd-rs/lsd/releases/latest" | jq -r ".tag_name | .[1:]") \
  && wget "https://github.com/lsd-rs/lsd/releases/download/${LSD_DOWNLOAD_VERSION}/lsd_${LSD_VERSION}_amd64.deb" \
  -P ${LSD_DOWNLOAD_DIR} \
  # && dpkg -i ${LSD_DOWNLOAD_DIR}/lsd_${LSD_VERSION}_amd64.deb
  # hack due to an error in the binary
  # Extract files from the archive
  && ar x ${LSD_DOWNLOAD_DIR}/lsd_${LSD_VERSION}_amd64.deb --output ${LSD_DOWNLOAD_DIR} \
  && ls -lash ${LSD_DOWNLOAD_DIR} \
  # Uncompress zstd files an re-compress them using xz
  && zstd -d < ${LSD_DOWNLOAD_DIR}/control.tar.zst | xz > ${LSD_DOWNLOAD_DIR}/control.tar.xz \
  && zstd -d < ${LSD_DOWNLOAD_DIR}/data.tar.zst | xz > ${LSD_DOWNLOAD_DIR}/data.tar.xz \
  # Re-create the Debian package in /tmp/
  && ar -m -c -a sdsd ${LSD_DOWNLOAD_DIR}/lsd_${LSD_VERSION}_repackaged_amd64.deb \
  ${LSD_DOWNLOAD_DIR}/debian-binary \
  ${LSD_DOWNLOAD_DIR}/control.tar.xz \
  ${LSD_DOWNLOAD_DIR}/data.tar.xz \
  && apt-get install ${LSD_DOWNLOAD_DIR}/lsd_${LSD_VERSION}_repackaged_amd64.deb

# dive
RUN DIVE_DOWNLOAD_DIR=$(mktemp -d) \
  && DIVE_VERSION=$(curl -s "https://api.github.com/repos/wagoodman/dive/releases/latest" | jq -r ".tag_name | .[1:]") \
  && FILE=dive_${DIVE_VERSION}_linux_amd64.deb \
  && URL="https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/${FILE}" \
  && wget ${URL} -P ${DIVE_DOWNLOAD_DIR} \
  && apt install ${DIVE_DOWNLOAD_DIR}/${FILE}

# lazy git
RUN LAZYGIT_DOWNLOAD_DIR=$(mktemp -d) \
  && LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r ".tag_name | .[1:]") \
  && FILE=lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz \
  && URL="https://github.com/jesseduffield/lazygit/releases/latest/download/${FILE}" \
  && wget ${URL} -P ${LAZYGIT_DOWNLOAD_DIR} \
  && tar xf ${LAZYGIT_DOWNLOAD_DIR}/${FILE} -C /usr/local/bin lazygit

# as_tree
RUN AS_TREE_DOWNLOAD_DIR=$(mktemp -d) \
  && AS_TREE_VERSION=$(curl -s "https://api.github.com/repos/jez/as-tree/releases/latest" | jq -r ".tag_name") \
  && FILE=as-tree-${AS_TREE_VERSION}-linux.zip \
  && URL="https://github.com/jez/as-tree/releases/download/${AS_TREE_VERSION}/${FILE}" \
  && wget ${URL} -P ${AS_TREE_DOWNLOAD_DIR} \
  && unzip ${AS_TREE_DOWNLOAD_DIR}/${FILE} -d /usr/local/bin

# lazy docker
RUN LAZYDOCKER_DOWNLOAD_DIR=$(mktemp -d) \
  && LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | jq -r ".tag_name | .[1:]") \
  && FILE=lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz \
  && URL="https://github.com/jesseduffield/lazydocker/releases/latest/download/${FILE}" \
  && wget ${URL} -P ${LAZYDOCKER_DOWNLOAD_DIR} \
  && tar xf ${LAZYDOCKER_DOWNLOAD_DIR}/${FILE} -C /usr/local/bin lazydocker

# xplr
RUN XPLR_DOWNLOAD_DIR=$(mktemp -d) \
  && XPLR_VERSION=$(curl -s "https://api.github.com/repos/sayanarijit/xplr/releases/latest" | jq -r ".tag_name") \
  && FILE=xplr-linux.tar.gz \
  && URL="https://github.com/sayanarijit/xplr/releases/download/${XPLR_VERSION}/${FILE}" \
  && wget ${URL} -P ${XPLR_DOWNLOAD_DIR} \
  && tar xf ${XPLR_DOWNLOAD_DIR}/${FILE} -C /usr/local/bin xplr

# nnn
RUN NNN_DOWNLOAD_DIR=$(mktemp -d) \
  && NNN_VERSION=$(curl -s "https://api.github.com/repos/jarun/nnn/releases/latest" | jq -r ".tag_name | .[1:]") \
  && FILE=nnn-nerd-static-${NNN_VERSION}.x86_64.tar.gz \
  && URL="https://github.com/jarun/nnn/releases/latest/download/${FILE}" \
  && wget ${URL} -P ${NNN_DOWNLOAD_DIR} \
  && tar xf ${NNN_DOWNLOAD_DIR}/${FILE} -C /usr/local/bin nnn-nerd-static \
  && mv /usr/local/bin/nnn-nerd-static /usr/local/bin/nnn

# fonts
RUN JETBRAINS_FONT_DOWNLOAD_DIR=$(mktemp -d) \
  && JETBRAINS_FONT_VERSION=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | jq -r ".tag_name") \
  && FILE=JetBrainsMono.zip \
  && URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${JETBRAINS_FONT_VERSION}/${FILE}" \
  && wget ${URL} -P ${JETBRAINS_FONT_DOWNLOAD_DIR} \
  && unzip ${JETBRAINS_FONT_DOWNLOAD_DIR}/${FILE} -d /usr/local/fonts \
  && fc-cache -fv

# lua
RUN LUA_DOWNLOAD_DIR=$(mktemp -d) \
  && LUA_VERSION="5.3.5" \
  && FILE=lua-${LUA_VERSION}.tar.gz \
  && URL="https://lua.org/ftp/${FILE}" \
  && wget ${URL} -P ${LUA_DOWNLOAD_DIR} \
  && tar xf ${LUA_DOWNLOAD_DIR}/${FILE} -C ${LUA_DOWNLOAD_DIR} \
  && cd ${LUA_DOWNLOAD_DIR}/lua-${LUA_VERSION} && make linux test && make install

# luarocks
RUN LUA_ROCKS_DOWNLOAD_DIR=$(mktemp -d) \
  && LUA_ROCKS_VERSION="3.9.2" \
  && FILE=luarocks-${LUA_ROCKS_VERSION}.tar.gz \
  && URL="https://luarocks.org/releases/${FILE}" \
  && wget ${URL} -P ${LUA_ROCKS_DOWNLOAD_DIR} \
  && tar xf ${LUA_ROCKS_DOWNLOAD_DIR}/${FILE} -C ${LUA_ROCKS_DOWNLOAD_DIR} \
  && cd ${LUA_ROCKS_DOWNLOAD_DIR}/luarocks-${LUA_ROCKS_VERSION} && ./configure && make && make install \
  && sudo luarocks install luasocket

#cloning zsh plugins + tmux best practices
RUN su vscode -c "umask 0002 && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" \
  && su vscode -c "umask 0002 && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" \
  && su vscode -c "umask 0002 && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/themes/powerlevel10k" \
  && su vscode -c "umask 0002 && mkdir /home/vscode/.zsh/ && git clone https://github.com/catppuccin/zsh-syntax-highlighting.git /tmp/zsh-syntax-highlighting && cp -v /tmp/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh /home/vscode/.zsh/" \
  && su vscode -c "umask 0002 && git clone https://github.com/gpakosz/.tmux.git home/vscode/.config/tmux"

#copying config
# COPY ./dotfiles /tmp/tmp-dotfiles
RUN su vscode -c "umask 0002 && rm -rf /home/vscode/.zshrc && ln -s /workspace/.devcontainer/dotfiles/shell/.zshrc /home/vscode/.zshrc"\
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/shell/.p10k.zsh /home/vscode/.p10k.zsh" \
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/shell/aliases.zsh ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/aliases.zsh" \
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/shell/exports.zsh ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/exports.zsh" \
  && su vscode -c "umask 0002 && rm -rf /home/vscode/.config/tmux/.tmux.conf.local && ln -s /workspace/.devcontainer/dotfiles/tmux/.tmux.conf.local /home/vscode/.config/tmux/.tmux.conf.local" \
  && su vscode -c "umask 0002 && ln -s -f /home/vscode/.config/tmux/.tmux.conf /home/vscode/.tmux.conf" \
  && su vscode -c "umask 0002 && ln -s /home/vscode/.config/tmux/.tmux.conf.local /home/vscode/.tmux.conf.local" \
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/mycli /home/vscode/.config/mycli"\
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/lazydocker /home/vscode/.config/lazydocker" \
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/lazygit /home/vscode/.config/lazygit"\
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/bat /home/vscode/.config/bat"\
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/bottom /home/vscode/.config/bottom"

# tree-sitter
RUN TREE_SITTER_DOWNLOAD_DIR=$(mktemp -d) \
  && TREE_SITTER_VERSION=$(curl -s "https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest" | jq -r ".tag_name") \
  && FILE=tree-sitter-linux-x64.gz \
  && URL="https://github.com/tree-sitter/tree-sitter/releases/download/${TREE_SITTER_VERSION}/${FILE}" \
  && wget ${URL} -P ${TREE_SITTER_DOWNLOAD_DIR} \
  && gzip -d ${TREE_SITTER_DOWNLOAD_DIR}/${FILE} \
  && mv ${TREE_SITTER_DOWNLOAD_DIR}/tree-sitter-linux-x64 /usr/local/bin/tree-sitter

# install neovim
COPY ./dotfiles/nvim/ /tmp/tmp-nvim-config
RUN NVIM_DOWNLOAD_DIR=$(mktemp -d) \
  && NVIM_VERSION=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | jq -r ".tag_name") \
  && FILE=nvim-linux64.tar.gz \
  && URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${FILE}" \
  && wget ${URL} -P ${NVIM_DOWNLOAD_DIR} \
  && tar xf ${NVIM_DOWNLOAD_DIR}/${FILE} -C / \
  && ln -fs /nvim-linux64/bin/nvim /usr/local/bin/nvim \
  && mkdir -p /home/vscode/.local/share/nvim\
  && chown -R vscode:vscode /home/vscode/.local\
  && su vscode -c "umask 0002 && mkdir -p /home/vscode/.config/nvim && cp -a /tmp/tmp-nvim-config/* /home/vscode/.config/nvim"\
  && su vscode -c "umask 0002 && /nvim-linux64/bin/nvim --headless -c 'Lazy! sync' -c 'qa'"
RUN su vscode -c "umask 0002 && /nvim-linux64/bin/nvim --headless -c 'autocmd User MasonComplete quitall' -c 'MasonInstall bash-language-server bash-debug-adapter css-lsp docker-compose-language-service dockerfile-language-server jq-lsp markdownlint node-debug2-adapter prisma-language-server typescript-language-server vim-language-server yaml-language-server lua-language-server html-lsp json-lsp tailwindcss-language-server nxls ' -c 'qa'"
RUN su vscode -c "umask 0002 && /nvim-linux64/bin/nvim --headless -c 'autocmd User MasonComplete quitall' -c 'MasonInstall prettierd yamlfmt sqlls eslint_d jsonlint yamllint sqlfluff codespell luacheck jdtls delve go-debug-adapter golangci-lint golangci-lint-langserver golines graphql-language-service-cli goimports gopls rust-analyzer stylua shfmt rustfmt ' -c 'qa'"\
  && su vscode -c "umask 0002 && rm -rf /home/vscode/.config/nvim" \
  && su vscode -c "umask 0002 && ln -s /workspace/.devcontainer/dotfiles/nvim/ /home/vscode/.config/nvim"

RUN rm -rf /tmp/tmp* \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

COPY ./docker-entrypoint.sh /usr/local/bin/
RUN dos2unix /usr/local/bin/docker-entrypoint.sh

USER vscode
ENTRYPOINT ["/usr/loca/bin/docker-entrypoint.sh"]
