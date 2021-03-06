# vim: filetype=ruby
require 'fileutils'

IGNORE_FILE_=%w(. .. .git .bundle vendor Rakefile Gemfile Gemfile.lock README.md shell test ruby rbenv_setup.sh .snippets)
LOCAL_BIN_=File.expand_path("bin", "~")
WORKSPACE_=File.expand_path("workspace", "~")

desc "インストール"
task :install => [
  :initialize, :create_symlink,
  "apt:setup", "brew:setup",
  "python:setup", "nodejs:setup", "go:setup",
  "neovim:setup",
  "package:extra_bin"
]

desc "アンインストール"
task :uninstall => ["package:remove"]


desc "0.作業ディレクトリを作成"
task :initialize do
  FileUtils.mkdir_p(LOCAL_BIN_)
  FileUtils.mkdir_p(WORKSPACE_)
end

desc "1.ホームディレクトリ以下にdotfilesのSymlinkを張る"
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

namespace :apt do
  desc "2.aptパッケージセットアップ"
  task :setup => ["apt:get", "apt:add_repository", "apt:update"]

  # apt-getパッケージ(brewの前に実行すると幸せになるよ)
  task :get do
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

  #  aptサードパーティリポジトリを追加
  task :add_repository do
    %w{
      ppa:git-core/ppa
      ppa:ubuntu-lxc/lxd-stable
      ppa:pi-rho/dev
      ppa:webupd8team/java
    }.each do |repository|
      sh %(sudo add-apt-repository #{repository}), verbose: true
    end
  end

  task :update do
    sh %(sudo apt-get update && sudo apt-get upgrade -y), verbose: true
  end
end

namespace :brew do
  desc "3.brewセットアップ"
  task :setup => ["brew:ruby", "brew:linuxbrew", "brew:formula"]

  task :ruby do
    if RUBY_VERSION.to_f < 2.2
      puts "!!! Please install Ruby version >= 2.1"
      next
    end
  end

  task :linuxbrew do |task|
    next if installed?(task.name.top)

    brew_dir = File.expand_path(".linuxbrew", "~")
    sh %(ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"), verbose: true do |ok, _|
      unless ok
        puts "!!! Can not linuxbrew setup"
        next
      end
    end
  end

  desc "linuxbrewの更新(時間がかかる)"
  task :upgrade do |task|
    sh %(brew upgrade), verbose: true
  end

  task :formula do
    {
      tmux: nil,
      git:  nil,
      hub:  nil,
      tig:  nil,
      go:   nil,
      perl: [
        File.expand_path(".linuxbrew/opt/openssl/bin/c_rehash", '~'),
        %(PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib)
      ],
      pyenv: [
        "mkdir -p ~/.local/lib/python3.5/site-packages",
        %(echo 'import site; site.addsitedir("~/.linuxbrew/lib/python2.7/site-packages")' >> ~/.local/lib/python3.5/site-packages/homebrew.pth)
      ],
      vim: nil
    }.each do |formula, options|
      formula = formula.to_s

      next if installed?(formula)

      sh %(brew install #{formula}), verbose: true
      options.each do |command|
        sh command, verbose: true do |ok, _|
          next unless ok
        end
      end unless options.nil?
    end
  end

end

namespace :neovim do
  desc "5.NeoVimセットアップ"
  task :setup => ["neovim:brew", "neovim:pip3"]

  desc "NeoVim依存解決"
  task :depended => ["apt:setup", "python:setup"]

  task :brew do
    [
      "brew reinstall -s libtool",
      "brew install neovim/neovim/neovim"
    ].each do |command|
      sh command, verbose: true
    end
  end

  # 依存解決に apt:setup & python:setup すること
  task :apt do
    %w{
      add-apt-repository ppa:neovim-ppa/unstable
      apt-get update
      apt-get install neovim
    }.each do |command|
      sh %(sudo #{command}), verbose: true
    end
  end

  task :pip3 do |task|
    next unless installed?(task.name.bottom)

    sh %(pip3 install neovim)
  end
end

namespace :go do
  desc "Golangセットアップ"
  task :setup => ["go:package", "go:enhancd", "go:fzf"]

  task :package do
    unless installed?('go')
      puts "!!! Will not install Go. Please try again: brew install go"
    end

    %w{
      github.com/motemen/ghq
      github.com/peco/peco/cmd/peco
      github.com/b4b4r07/gch
    }.each do |package|
      sh %(go get #{package}), verbose: true do |ok, _|
        next unless ok
      end
    end
  end

  # depended peco
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

  desc "fzfのセットアップ"
  task :fzf do
    sh %(git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf), verbose: true do |ok, _|
      next unless ok

      puts " `.bashrc` への書き込み要求は [N] を選択してください"
      sh %(~/.fzf/install), verbose: true
    end
  end
end

namespace :nodejs do
  desc "Node.jsセットアップ"
  task :setup => ["nodejs:nodebrew", "nodejs:version", "nodejs:npm"]

  task :nodebrew do |task|
    unless installed?(task.name.bottom)
      sh %(curl -L git.io/nodebrew | perl - setup), verbose: true
    end
  end

  task :version do
    versions = %w(v4.x latest)

    versions.each do |version|
      sh %(nodebrew install-binary #{version}), verbose: true do |ok, _|
        next unless ok
      end
    end

    # versionsの最後に定義したnode.jsバージョンを使用する
    sh %(nodebrew use #{versions.last})
  end

  task :npm do
    sh %(npm update -g npm), verbose: true
  end

  task :global do
    %w{
      webpack
      babel-cli
      git-grep-edit
    }.each do |package|
      sh %(npm install -g #{package}), verbose: true
    end
  end
end

namespace :python do
  desc "Pythonセットアップ"
  task :setup => ["python:pyenv", "python:pip"]

  task :initialize do
    %w(
      python
      sphinx-doc
    ).each do |formula|
      sh %(brew install #{formula}), verbose: true
    end
  end

  task :pyenv do |task|
    next unless installed?(task.name.bottom)

    [
      "install 3.5.1",
      "global 3.5.1"
    ].each do |command|
      sh %(pyenv #{command}), verbose: true do |ok, _|
        unless ok
          puts "!!! Warning can note use Python: Please try execute: rake #{task.name}"
        end
      end
    end
  end

  task :pip do
    sh %(pip install --upgrade pip setuptools sphinx), verbose: true
  end
end

# cloudfoundry/blurmix
namespace :cloudfoundry do
  desc 'cfコマンド'
  task :cli do
    if /x86_64|amd64/i !~ RUBY_PLATFORM
      puts "!!! Can not install cf command. binary is published with only 64bit."
      next
    end

    sh %(curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx), verbose: true do |ok, _|
      next unless ok
    end

    FileUtils.cp("cf", LOCAL_BIN_, verbose: true)
    sh %(cf --version), verbose: true
  end
end


# その他
namespace :package do
  desc "shell拡張"
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

  desc "環境削除"
  task :remove do
    [
      File.expand_path(".linuxbrew", "~"),
      File.expand_path(".pyenv", "~"),
      File.expand_path(".nodebrew", "~"),
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

def installed?(package)
  status = sh %(type #{package} 2> /dev/null) do |ok, _|
    ok
  end
end

class String
  def bottom
    self.split(':').last
  end

  def top
    self.split(':').first
  end
end
