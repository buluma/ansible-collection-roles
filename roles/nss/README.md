# [nss](#nss)

Role for prepare an entire development environment for NSS.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nss/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nss/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nss/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nss)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/nss)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/nss)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nss.svg)](https://github.com/buluma/ansible-role-nss/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nss.svg)](https://github.com/buluma/ansible-role-nss/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nss.svg)](https://github.com/buluma/ansible-role-nss/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.nss
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: false
  become: true

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Important information about the use of this file.
# All lists has an "enabled" parameter. This parameter only says if that element
# will be used by this module or will be totally ignored when set to "False".
# I did not test all the combinations of False|True values in all Module. So, if
# you find any problem, please, inform in the official Github repository.
# I will thank : )
#
# Take care with the "state" parameter. If the element is "enabled" and the state
# parameter is set to "absent", the element will be totally removed.
#
# This module was designed to be very flexible and the configurations parameters
# centralized in this file. Please, don't modify the tasks. If you have some
# improvement suggestions, send to official repository, please.
#
# In some rare cases, you may change some variable in files included in "vars"
# folder. Again, if you have any improvement suggestion, mainly focused in
# automation, send to official repository to help other people too. :)
#
# I will be glad to land everything related to efficiency and performance
# improvements.
# Finally, thanks to use this module. I hope it save your time and permits you
# be less stressed and more focused only in coding. : )

# This folder will maintain the last changeset of the official repos and
# will be used as source for new workspaces. The main_dir should not be modified
# manually. It is a very important folder for the rest of this module.
main_dir: "{{ ansible_facts['user_dir'] }}/MOZILLA"

# Here is the place where your patches will be developed. The bugs that you are
# working will be here.
bugzilla_dev_dir: "{{ ansible_facts['user_dir'] }}/BUGZILLA"

# Some personal configurations that I hope you set correctly : )
hg_username: 'Name Surname <myemail@mydomain.com>'
git_username: 'Name Surname'
git_email: 'myemail@mydomain.com'
nss_try: 'ssh://<myemail>@<mydomain>.com@hg.mozilla.org/projects/nss-try'

# I strongly recommend to not change this paths, for organization purposes.
mozbuild_dir: "{{ main_dir }}/.mozbuild"
moz_phab_dir: '{{ mozbuild_dir }}/moz-phab'
moz_phab_file: 'https://raw.githubusercontent.com/mozilla-conduit/review/master/moz-phab'

# This granular approach make the module more powerful.
# Observe the first letter of True or False (uppercase).
# Some tasks need escalated permissions. This will be done with "become"
# parameter of Ansible. The default is "sudo". So, ensure your username has
# sudo permissions to install packages and change some system files (repos).
# Then, you can call the ansible-playbook command with the -K option.
available_tasks:
  - { enabled: True, name: 'install_packages' }     # Requires -K option
  - { enabled: True, name: 'configure_env' }        # Requires -K option
  - { enabled: True, name: 'configure_mercurial' }
  - { enabled: True, name: 'configure_git' }
  # Requires -K option if "install" is True
  # Depends of "configure_env"
  - { enabled: True,  name: 'configure_vscode' }

# This module was designed to work with NSS, but is very flexible to be
# increased.
# "support_repo" usually are not modified. We will just ensure they are updated.
hg_repos:
  - { enabled: True, support_repo: False,  name: 'nspr',                   repo: 'https://hg.mozilla.org/projects/nspr',                   dest: '{{ main_dir }}/nspr' }
  - { enabled: True, support_repo: False,  name: 'nss',                    repo: 'https://hg.mozilla.org/projects/nss',                    dest: '{{ main_dir }}/nss' }
  - { enabled: True, support_repo: True,   name: 'evolve',                 repo: 'https://www.mercurial-scm.org/repo/evolve',              dest: '{{ mozbuild_dir }}/evolve' }
  - { enabled: True, support_repo: True,   name: 'version-control-tools',  repo: 'https://hg.mozilla.org/hgcustom/version-control-tools',  dest: '{{ mozbuild_dir }}/version-control-tools' }

# Here are the ui options considered very useful to work with development.
hg_ui_config:
  - { enabled: True, state: 'present', parameter: 'interface',     value: 'curses' }
  - { enabled: True, state: 'present', parameter: 'tweakdefaults', value: 'true' }
  - { enabled: True, state: 'present', parameter: 'username',      value: '{{ hg_username }}' }

# Most of this extensions are set when we use ????
# References:
hg_extensions:
  - { enabled: True, state: 'present', parameter: 'absorb',        value: '' }
  - { enabled: True, state: 'present', parameter: 'blackbox',      value: '' }
  - { enabled: True, state: 'present', parameter: 'clang-format',  value: '{{ mozbuild_dir }}/version-control-tools/hgext/clang-format' }
  - { enabled: True, state: 'present', parameter: 'evolve',        value: '{{ mozbuild_dir }}/evolve/hgext3rd/evolve' }
  - { enabled: True, state: 'present', parameter: 'firefoxtree',   value: '{{ mozbuild_dir }}/version-control-tools/hgext/firefoxtree' }
  - { enabled: True, state: 'present', parameter: 'histedit',      value: '' }
  - { enabled: True, state: 'present', parameter: 'push-to-try',   value: '{{ mozbuild_dir }}/version-control-tools/hgext/push-to-try' }
  - { enabled: True, state: 'present', parameter: 'rebase',        value: '' }
  - { enabled: True, state: 'present', parameter: 'strip',         value: '' }

# If your current version of Mercurial has some newer or older extensions
# defined in the repository, here you can adjust.
hg_requires:
  - { enabled: True,  state: 'absent', name: 'sparserevlog' }

# These repos are very important to work with NSS and Phabricator.
git_repos:
  - { enabled: True, name: 'nss-tools',  repo: 'https://github.com/mozilla/nss-tools.git',   dest: '{{ main_dir }}/nss-tools' }
  - { enabled: True, name: 'arcanist',   repo: 'https://github.com/phacility/arcanist.git',  dest: '{{ mozbuild_dir }}/arcanist' }
  - { enabled: True, name: 'libphutil',  repo: 'https://github.com/phacility/libphutil.git', dest: '{{ mozbuild_dir }}/libphutil' }

git_user_config:
  - { enabled: True,  state: 'present', parameter: 'name',  value: '{{ git_username }}' }
  - { enabled: True,  state: 'present', parameter: 'email', value: '{{ git_email }}' }

# This module will install the VSCode for you and customize it according with
# the development environment designed by this module.
# If you want to install more repositories, here is the place.
linux_repos:
  - { enabled: True,  state: 'present', name: 'VSCode', repo: 'https://packages.microsoft.com/yumrepos/vscode', gpgcheck: '1', gpgkey: 'https://packages.microsoft.com/keys/microsoft.asc' }

# This module will increment the PATH environment for the useful commands
path_env:
  - { enabled: True,  name: 'arcanist', path: '{{ mozbuild_dir }}/arcanist/bin' }
  - { enabled: True,  name: 'moz-phab', path: '{{ mozbuild_dir }}/moz-phab' }

# If you are working in a BUG, add the infos here to create a clean workspace
# for it. This role will not delete any workspace directory from if the action
# is "remove". The "remove" action will only remove the reference in VSCode
# workspaces. If you want to remove completely the folder, change the state to
# "absent". Care with this option.
#
# DON'T CHANGE THE STATE OF THE FIRST (REFERENCE) REPO UNLESS YOU KNOW WHAT
# YOU ARE DOING. IT WILL REMOVE THE MAIN_DIR COMPLETELY. TO AVOID UNDESIRED
# MISTAKES, I SET AN EXTRA CONTROL IN THE TASK. CHANGE THERE TOO IF REALLY
# DESIRED.
#
# If "rebase" is True, the module will rebase your workspace always when a new
# changeset arrives. I am yet working in this option. So, I strongly recommend
# to leave it "False" this meantime.
vscode_workspaces:
  - { enabled: True,  state: 'directory', rebase: False,  action: 'add',    name: 'Reference',  bugId: '',        path: '{{ main_dir }}' }
  - { enabled: False, state: 'directory', rebase: True,   action: 'remove', name: 'GTest',      bugId: '1577624', path: '{{ bugzilla_dev_dir }}' }

# This will be prefixed in the new Bugzilla dev workspaces configured in VSCode
dev_ws_prefix: 'BUG'

# The "installed" parameter determines if the extension will be installed or
# removed. Observe that if your VSCode is opened, may be needed to restart it
# to commit some extensions changes.
vscode_extensions:
  - { enabled: True,  installed: True,  name: 'streetsidesoftware.code-spell-checker' }
  - { enabled: True,  installed: True,  name: 'ms-vscode.cpptools' }
  - { enabled: True,  installed: True,  name: 'vscode-icons-team.vscode-icons' }
  - { enabled: True,  installed: True,  name: 'ms-python.python' }
  - { enabled: True,  installed: True,  name: 'xaver.clang-format' }
  - { enabled: True,  installed: True,  name: 'adamvoss.vscode-languagetool-en' }
  - { enabled: True,  installed: True,  name: 'adamvoss.vscode-languagetool' }

sysctl_config:
  - { enabled: True,  state: 'present', parameter: 'fs.inotify.max_user_watches', value: '524288' }

# As defined in nss/nss.gyp and nss/build.sh, some binaries are not compiled
# by default. If you want to compile this extra binaries or build with any
# other available option, here is the place to define this.
# The possible options could be found with "./build.sh --help"
# This build will only run for the main_dir|reference repository.
# For your BUGs workspaces, purposely, you must deal manually there.
build:
  - { enabled: True,  name: 'nss', command: './build.sh' }

# The "all" test is very long and you need to consider this when running this
# module. Most of times, is preferable to run tests manually in each workspace,
# but this module permits to use here too, if you want. I didn't fill all the
# NSS tests here. Please, consult the tests/all.sh for more details.
# TIP: dist/Debug/bin/ssl_gtest -d . -w --gtest_filter"*string*"
nss_tests:
  - { enabled: False, name: 'all', command: './all.sh', dir: 'nss/tests' }
  - { enabled: False, name: 'gtests', command: './gtests.sh', dir: 'nss/tests/gtests' }
...
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nss/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nss/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7|
|fedora|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nss/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-nss/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
