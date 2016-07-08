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
    sh "type brew 2> /dev/nul" do |ok, status|
      next if ok
    end

    brew_dir = File.expand_path(".linuxbrew", "~")
    sh %(git clone https://github.com/linuxbrew/brew.git #{brew_dir}), verbose: true do |ok, status|
      if ok
        envs = [
          %(# linuxbrew),
          %(export PATH="$HOME/.linuxbrew/bin:$PATH"),
          %(export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"),
          %(export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH")
        ]
        export_environment(envs)
      else
        puts "!!! Can not linuxbrew setup"
        next
      end
    end
  end

  # brew setup
  task :brionac do
    sh "type brew 2> /dev/nul" do |ok, status|
      next unless ok

      [
        %(brew tap b4b4r07/brionac),
        %(brew install brionac),
      ].each {|command| sh %(#{command}) }

      sh %(type brionac 2> /dev/nul) do |ok, status|
        unless ok
          puts "!!! Can not brew sub-tool setup"
          next
        end

        sh %(brionac attack), verbose: true
      end
    end

  end
end

def backup!(fullpath)
  if File.exists?(fullpath)
    FileUtils.cp_r(fullpath, "%s_" % fullpath, preserve: true, verbose: true)
    FileUtils.rm_r(fullpath)
  end
end

def export_environment(environments=[])
  env_file = File.expand_path('shell/export.sh')
  if File.exists?(env_file)
    File.open(env_file) do |f|
      f.puts environments.join("\n")
    end

    sh "source #{env_file}", verbos: true
  end
end

