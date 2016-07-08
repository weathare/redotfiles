#!/bin/sh

# apt-get update and upgrade
# ---------------------------------------
sudo apt-get update && sudo apt-get upgrade -y

# for development
# ---------------------------------------
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libreadline-dev libffi-dev

# ruby install with rbenv
# --------------------------------------
if [ ! -d $HOME/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  cat <<'_RBENV_'>> $HOME/.bash_profile
# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

_RBENV_

. $HOME/.bash_profile


  # plugin
  # --------------------------------------
  RPLUGIN_PATH=$HOME/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git $RPLUGIN_PATH/ruby-build
  git clone https://github.com/ianheggie/rbenv-binstubs.git $RPLUGIN_PATH/rbenv-binstubs
  git clone https://github.com/sstephenson/rbenv-default-gems.git $RPLUGIN_PATH/rbenv-default-gems
  # git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RPLUGIN_PATH/rbenv-gem-rehash
  git clone https://github.com/rkh/rbenv-update.git $RPLUGIN_PATH/rbenv-update
  git clone https://github.com/jf/rbenv-gemset.git $RPLUGIN_PATH/rbenv-gemset
  git clone https://github.com/ianheggie/rbenv-binstubs.git $RPLUGIN_PATH/rbenv-binstubs


  cat<<'_GROBAL_'>$HOME/.rbenv/default-gems
bundler
rubocop
hpricot
pry
pry-doc

_GROBAL_
fi

rbenv update
rbenv rehash
NEW_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $NEW_VERSION
rbenv global $NEW_VERSION
which ruby
ruby -v

