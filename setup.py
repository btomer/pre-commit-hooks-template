import os
from setuptools import setup

try:
    import yaml
except ImportError:
    print('ERROR: Pre-commit hooks template: The "yaml" python is not installed.')
    print('Please install it by running: "pip install pyyaml".')
    print('')
    raise

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))

# We assume that the name of the directory that contains this file is the name of our project
PROJECT_NAME = os.path.basename(SCRIPT_DIR)
PROJECT_VERSION = '1.0.0'
# The package name is the name of the directory where we will store our scripts
PACKAGE_NAME = 'pre_commit_hooks'

HOOKS_DEFINITIONS_FILENAME = '.pre-commit-hooks.yaml'


def read_hooks_config():
    config_file_path = os.path.join(SCRIPT_DIR, HOOKS_DEFINITIONS_FILENAME)
    raw_config = open(config_file_path, 'rb').read()
    hooks_config = yaml.safe_load(raw_config)
    return hooks_config


def get_python_hook_script_names(hooks_config):
    return [hook_data['entry'] for hook_data in hooks_config if hook_data['language'].strip().lower() == 'python']


def main():
    hooks_config = read_hooks_config()
    script_names = get_python_hook_script_names(hooks_config)
    console_scripts = []

    for script_name in script_names:
        script_name_without_suffix = script_name[:-3] if script_name.endswith('.py') else script_name
        console_scripts.append(
            '{script_name} = {package_name}.{script_name_without_suffix}:main'.format(
                script_name_without_suffix=script_name_without_suffix,
                script_name=script_name,
                package_name=PACKAGE_NAME
            )
        )

    setup(
        name=PROJECT_NAME,
        description=PROJECT_NAME,
        version=PROJECT_VERSION,
        packages=[PACKAGE_NAME],
        entry_points={
            'console_scripts': console_scripts,
        },
    )


if __name__ == '__main__':
    main()
