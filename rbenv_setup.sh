#!/bin/sh

# apt-get update and upgrade
# ---------------------------------------
sudo apt-get update && sudo apt-get upgrade -y

# for development
# ---------------------------------------
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

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
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RPLUGIN_PATH/rbenv-gem-rehash
  git clone https://github.com/rkh/rbenv-update.git $RPLUGIN_PATH/rbenv-update
  git clone https://github.com/jf/rbenv-gemset.git $RPLUGIN_PATH/rbenv-gemset


  cat<<'_GROBAL_'>$HOME/.rbenv/default-gems
bundler
rubocop
rcodetools
hpricot
pry
pry-doc
activesupport
neovim
watson-ruby

_GROBAL_
fi

rbenv update
rbenv rehash
NEW_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $NEW_VERSION
rbenv global $NEW_VERSION
which ruby
ruby -v

