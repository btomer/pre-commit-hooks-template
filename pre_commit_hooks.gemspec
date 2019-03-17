require 'rubygems'  # Needed for Ruby versions before 1.9
require 'yaml'

SCRIPT_DIR = if Gem::Version.new(RUBY_VERSION) > Gem::Version.new('2.0.0')
  File.realpath(__dir__)
else
  File.dirname(File.realpath(__FILE__))
end

HOOKS_DEFINITIONS_FILENAME = '.pre-commit-hooks.yaml'.freeze
PROJECT_VERSION = '1.0.0'.freeze
# The package name is the name of the directory where we will store our scripts
PACKAGE_NAME = 'pre_commit_hooks'.freeze

Gem::Specification.new do |s|
  project_name = File.basename(SCRIPT_DIR)

  hooks_definitions_filepath = File.join(SCRIPT_DIR, HOOKS_DEFINITIONS_FILENAME)
  hooks_config = YAML.load_file(hooks_definitions_filepath)

  ruby_scripts_filenames = hooks_config
    .select { |hook_data| hook_data.fetch('language', '').chomp.downcase == 'ruby' }
    .map    { |hook_data| hook_data.fetch('entry') }

  s.name = project_name
  s.version = PROJECT_VERSION
  s.summary = project_name
  s.description = project_name
  s.authors = ['']
  s.bindir = PACKAGE_NAME
  s.executables = ruby_scripts_filenames
end
