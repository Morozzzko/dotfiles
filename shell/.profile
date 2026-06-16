export LC_ALL=en_US.UTF-8

alias vim="nvim"
export EDITOR=nvim

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export PATH="/opt/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"

# Android

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_NDK_HOME=/usr/local/share/android-ndk
export INTEL_HAXM_HOME=/usr/local/Caskroom/intel-haxm

export PATH="$ANT_HOME/bin:$PATH"
export PATH="$MAVEN_HOME/bin:$PATH"
export PATH="$GRADLE_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Sick of brew install
# export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$PATH:$HOME/.yarn/bin"

export GPG_TTY="$(tty)"

source ~/.profile_secrets

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

export HAPPY_SERVER_URL="https://happy.dev.morozov.is"
