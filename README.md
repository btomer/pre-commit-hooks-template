# Pre-commit hooks template

A template project to help writing pre-commit hooks for use with the [pre-commit-hooks](https://pre-commit.com) framework.

## How to use this template

If you want to write a new hook that can be included using the pre-commit-hooks framework:

- Fork this repository
- Place your hook scripts under the `pre_commit_hooks` directory
- Create a `.pre-commit-hooks.yaml` file in the root of your repository, describing each hook (see [instructions](https://pre-commit.com/#new-hooks))

Here's an example `.pre-commit-hooks.yaml` file, that assumes you created a shell script hook at `pre_commit_hooks/my_shell_script_hook.sh`, a Python hook at `pre_commit_hooks/my_python_hook.py` and a Ruby hook at `pre_commit_hooks/my_ruby_hook.rb`:

```yaml
- id: my_shell_script_hook
  name: My shell script hook
  description: A sample shell script hook
  entry: pre_commit_hooks/my_shell_script_hook.sh
  language: script
  pass_filenames: true
  types: ['python']
  verbose: true
- id: my_python_hook
  name: My Python hook
  description: A sample Python hook
  entry: my_python_hook.py
  language: python
  pass_filenames: true
  types: ['python']
  verbose: true
- id: my_ruby_script_hook
  name: My Ruby hook
  description: A sample Ruby hook
  entry: my_ruby_hook.rb
  language: ruby
  pass_filenames: true
  types: ['python']
  verbose: true
```

Note the difference in the way the `entry` field is specified (for some languages it contains the pre_commit_hooks directory and for some it doesn't).

## Why is this needed

Writing pre-commit hooks for some languages requires creating and maintaining a package file.

For example, a `setup.py` file is required when writing Python hooks and a `.gemspec` file is required for Ruby hooks.

This repo contains generic versions of these configuration files so that you don't have to write or maintain them.

## What languages are supported

The following languages currently contain template configurations:

- Python
- Ruby

Note that some languages do not require a configuration at all, such as `script`.
If you only use these languages in your hooks repository, you don't need this template.

See [here](https://pre-commit.com/#supported-languages) for a full list of languages generally supported by pre-commit-hooks and their prerequisites.
