# vim: filetype=ruby
require 'fileutils'

IGNORE_FILE_=%w(. .. .git .bundle vendor Rakefile Gemfile Gemfile.lock README.md shell test ruby)
LOCAL_BIN_=File.expand_path("bin", "~")
WORKSPACE_=File.expand_path("workspace", "~")

task :install => [:initialize, :create_symlink, "package:install"]
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

      profile = Fite.expand_path(".bash_profile", "~")
      puts "You try: source #{profile}"
    rescue Errno::EEXIST
      puts "!!! Already exists: ~/#{filename}"
    end
  end
end

desc "Install some packages!!"
namespace :package do
  task :install => ["package:linuxbrew", "package:go", "package:enhancd"]

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
      python3
      perl
      vim
    }.each do |formula|
      sh %(brew install #{formula}), verbose:true
    end
  end

  desc " ... go"
  task :go do
    %w{
      github.com/motemen/ghq
      github.com/peco/peco/cmd/peco
      github.com/b4b4r07/gch
    }.each do |package|
      sh %(go get #{package}), verbose: true
    end
  end

  desc " ... peco depended go"
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
    sh %(brew install neovim/neovim/neovim), verbos: true
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

