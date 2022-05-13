
# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

export NVM_DIR="/Users/adriangabrielli/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.64.3:2376"
export DOCKER_CERT_PATH="/Users/adriangabrielli/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"

. "$HOME/.cargo/env"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
