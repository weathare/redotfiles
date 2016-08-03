# vim: filetype=ruby
require 'fileutils'

IGNORE_FILE_=%w(. .. .git .bundle vendor Rakefile Gemfile Gemfile.lock README.md shell test ruby rbenv_setup.sh)
LOCAL_BIN_=File.expand_path("bin", "~")
WORKSPACE_=File.expand_path("workspace", "~")

desc "インストール"
task :install => [:initialize, :create_symlink, "package:apt_update", "package:install", "package:nvim_setup"]

desc "アンインストール"
task :uninstall => ["package:remove"]


desc "作業ディレクトリを作成"
task :initialize do
  FileUtils.mkdir_p(LOCAL_BIN_)
  FileUtils.mkdir_p(WORKSPACE_)
end

desc "ホームディレクトリ以下にdotfilesのSymlinkを張る"
task :create_symlink do
  Dir.foreach(".") do |filename|
    next if IGNORE_FILE_.include?(filename)

    file_path = File.expand_path(filename)
    symlink_path = File.expand_path(filename, "~")

    begin
      backup!(symlink_path)
      symlink(file_path, symlink_path)

      profile = File.expand_path(".bash_profile", "~")
      puts "You try: source #{profile}"
    rescue Errno::EEXIST
      puts "!!! Already exists: ~/#{filename}"
    end
  end
end

desc "Install some packages!!"
namespace :package do
  desc "基本セットアップ"
  task :install => ["package:linuxbrew", "package:formula", "package:go", "package:enhancd"]

  desc "OSサードパーティ系セットアップ"
  task :apt_update => ["package:apt", "package:add_apt"]

  desc "NeoVimセットアップ"
  task :nvim_setup => ["package:pyenv", "package:neovim"]

  desc " ... apt-getパッケージ(brewの前に実行すると幸せになるよ)"
  task :apt do
    %w{
      software-properties-common
      python-software-properties
      libtool
      unzip
      liblua5.2-dev
      vim.nox
    }.each do |package|
      sh %(sudo apt-get install -y #{package}), verbose: true
    end
  end

  desc " ... aptサードパーティリポジトリを追加"
  task :add_apt do
    %w{
      ppa:git-core/ppa
      ppa:ubuntu-lxc/lxd-stable
      ppa:pi-rho/dev
      ppa:webupd8team/java
    }.each do |repository|
      sh %(sudo add-apt-repository #{repository}), verbose: true
    end

    sh %w(sudo apt-get update && sudo apt-get upgrade -y), verbose: true
  end

  desc " ... linuxbrew"
  task :linuxbrew do
    sh %(type brew 2> /dev/null) do |ok, _|
      next if ok
    end

    brew_dir = File.expand_path(".linuxbrew", "~")
    sh %(ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"), verbose: true do |ok, _|
      unless ok
        puts "!!! Can not linuxbrew setup"
        next
      end
    end
  end

  desc " ... formula with linuxbrew"
  task :formula do
    %w{
      tmux
      git
      tig
      go
      perl
      pyenv
      vim
    }.each do |formula|
      sh %(brew install #{formula}), verbose: true
    end
  end

  desc " ... setup pyenv & pip"
  task :pyenv do
    sh %(type pyenv 2> /dev/null) do |ok, _|
      unless ok
        puts "!!! Will not install Python. Please try again: brew install pyenv"
        next
      end
    end

    sh %(pyenv install 3.5.1), verbose: true do |ok, _|
      [
        "pyenv global 3.5.1",
        "pip install --upgrade pip setuptools"
      ].each do |command|
        sh command, verbose: true
      end
    end
  end

  desc " ... install go package"
  task :go do
    %w{
      github.com/motemen/ghq
      github.com/peco/peco/cmd/peco
      github.com/b4b4r07/gch
    }.each do |package|
      sh %(go get #{package}), verbose: true
    end
  end

  desc " ... enhancd depended peco"
  task :enhancd do
    sh %(type peco 2> /dev/null) do |ok, _|
      next unless ok
    end

    enhancd_dir = File.expand_path("enhancd", LOCAL_BIN_)
    repository = "https://github.com/b4b4r07/enhancd"
    sh %(git clone #{repository} #{enhancd_dir}), verbose: true do |ok, _|
      unless ok
        puts "!!! Not compleated b4b4r07/enhancd setup, check repository issue: #{repository}"
        next
      end

      puts "You try: source #{enhancd_dir}/init.sh"
    end
  end

  desc " ... neovim with python and perl"
  task :neovim do
    sh %(brew install neovim/neovim/neovim), verbose: true
  end

  desc " ... extra scripts"
  task :extra_bin do
    %w{
      https://raw.githubusercontent.com/yuroyoro/git-ignore/master/git-ignore
    }.each do |script|
      setting_path = File.expand_path(File.basename(script), LOCAL_BIN_)
      unless File.exists?(setting_path)
        sh %(curl -sL #{script} > #{setting_path}), verbose: true do |ok, _|
          if ok
            File.chmod(0755, setting_path)
          else
            puts "!!! Not Completed download and setting: #{scripts}"
          end
        end
      end
    end
  end

  desc "Installed packages delete!"
  task :remove do
    [
      File.expand_path(".linuxbrew", "~"),
      File.expand_path("go", WORKSPACE_),
      File.expand_path("enhancd", LOCAL_BIN_)
    ].each do |path|
      FileUtils.remove_entry_secure(path)
    end
  end
end

def backup!(fullpath)
  if File.exists?(fullpath)
    FileUtils.cp_r(fullpath, "%s_" % fullpath, preserve: true, verbose: true)
    FileUtils.rm_r(fullpath)
  end
end

