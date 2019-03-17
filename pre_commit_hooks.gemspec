require 'rubygems'  # Needed for Ruby versions before 1.9
require 'yaml'

HOOKS_DEFINITIONS_FILENAME = '.pre-commit-hooks.yaml'.freeze
PROJECT_VERSION = '1.0.0'.freeze
# The package name is the name of the directory where we will store our scripts
PACKAGE_NAME = 'pre_commit_hooks'.freeze

def script_dir
  if Gem::Version.new(RUBY_VERSION) > Gem::Version.new('2.0.0')
    __dir__
  else
    File.dirname(File.realpath(__FILE__))
  end
end

def project_name
  File.basename(script_dir)
end

def hooks_config
  hooks_definitions_filepath = File.join(script_dir, HOOKS_DEFINITIONS_FILENAME)
  YAML.load_file(hooks_definitions_filepath)
end

def ruby_scripts_filenames
  hooks_config
    .select { |hook_data| hook_data.fetch('language', '').chomp.downcase == 'ruby' }
    .map    { |hook_data| hook_data.fetch('entry') }
end

Gem::Specification.new do |s|
  s.name = project_name
  s.version = PROJECT_VERSION
  s.summary = project_name
  s.description = project_name
  s.bindir = PACKAGE_NAME
  s.executables = ruby_scripts_filenames
end
