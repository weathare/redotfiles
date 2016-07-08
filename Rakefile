# vim: filetype=ruby
require 'fileutils'

IGNORE_FILE_=%w(. .. .git .bundle vendor Rakefile Gemfile Gemfile.lock README.md shell test)
WORKSPACE_=File.expand_path("workspace", "~")

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
    sh %(git clone https://github.com/linuxbrew/brew.git #{brew_dir}), verbose: true do |ok, status|
      unless ok
        puts "!!! Can not linuxbrew setup"
        next
      end
    end
  end
end

namespace :setup do
  task :linuxbrew do
    Rake::Task["package:linuxbrew"].invoke

    [
      "tmux",
      "git",
      "tig",
      "go"
    ].each do |formula|
      sh %(brew install #{formula}), verbose:true
    end
  end
end

def backup!(fullpath)
  if File.exists?(fullpath)
    FileUtils.cp_r(fullpath, "%s_" % fullpath, preserve: true, verbose: true)
    FileUtils.rm_r(fullpath)
  end
end

