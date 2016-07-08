# vim: filetype=ruby
require 'fileutils'

IGNORE_FILE_=%w(. .. .git .bundle vendor Rakefile Gemfile Gemfile.lock README.md shell test)
WORKSPACE_=File.expand_path("workspace", "~")
SHELL_=ENV['SHELL'].split("/")[1]

task :install => [:initialize, :create_symlink, "package:linuxbrew"]

task :initialize do
  user_bin = File.expand_path("bin", "~")

  FileUtils.mkdir_p(user_bin)
  FileUtils.mkdir_p(WORKSPACE_)
end

task :create_symlink do
  Dir.foreach(".") do |filename|
    next if IGNORE_FILE_.include?(filename)

    file_path = File.expand_path(filename)
    symlink_path = File.expand_path(filename, "~")

    begin
      backup!(symlink_path)
      symlink(file_path, symlink_path)
    rescue Errno::EEXIST
      puts "!!! Already exists: ~/#{filename}"
    end
  end
end

namespace :package do
  # iunstall linuxbrew
  task :linuxbrew do
    sh "type brew 2> /dev/null" do |ok, status|
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

  # packages with linuxbrew
  task :formula do
    %w{
      tmux
      git
      tig
      go
    }.each do |formula|
      sh %(brew install #{formula}), verbose:true
    end
  end

  # go packages
  task :go do
    %w{
      github.com/motemen/ghq
      github.com/peco/peco/cmd/peco
      github.com/b4b4r07/gch
    }.echo do |package|
      sh %(go get #{package}), verbose: true
    end
  end

  # depended peco
  task :enhancd do
    sh "type peco 2>/dev/null" {|ok, _| next unless ok }

    enhancd_dir = File.expand_path("bin/enhancd", "~")
    repository = "https://github.com/b4b4r07/enhancd"
    sh %(git clone #{repository} #{enhancd_dir}), verbose: true do |ok, _|
      unless ok
        puts "!!! Not compleated b4b4r07/enhancd setup, check repository issue: #{repository}"
        next
      end

      sh "#{SHELL_} #{enhancd_dir}/init.sh", verbose: true
    end
  end
end

def backup!(fullpath)
  if File.exists?(fullpath)
    FileUtils.cp_r(fullpath, "%s_" % fullpath, preserve: true, verbose: true)
    FileUtils.rm_r(fullpath)
  end
end

