"""Check that every module a role calls resolves with the ansible-core in use.

ansible-playbook --syntax-check skips files that are loaded with include_tasks
and include_role, so a module name that does not resolve there is only found
when a host runs it. This reads the tasks and handlers of every role, collects
the module names (including inside block, rescue and always) and resolves each
one against ansible-core and the installed collections.

Usage: check_modules.py ROLES_DIRECTORY
"""

import sys
from pathlib import Path

import yaml
from ansible.plugins.loader import action_loader, init_plugin_loader, module_loader

# Task keywords that are not module names.
KEYWORDS = {
    "name", "when", "register", "become", "become_user", "become_method", "become_flags", "become_exe",
    "loop", "loop_control", "notify", "listen", "tags", "vars", "environment", "delegate_to", "delegate_facts",
    "run_once", "ignore_errors", "ignore_unreachable", "changed_when", "failed_when", "no_log", "until",
    "retries", "delay", "check_mode", "diff", "args", "async", "poll", "connection", "remote_user", "port",
    "module_defaults", "any_errors_fatal", "throttle", "timeout", "collections", "debugger", "block",
    "rescue", "always", "action", "local_action", "static", "no_block", "serial", "strategy",
}


def module_names(items):
    """Yield the module name of every task in a (possibly nested) list of tasks."""
    if isinstance(items, dict):
        items = [items]
    if not isinstance(items, list):
        return
    for task in items:
        if not isinstance(task, dict):
            continue
        for key in ("block", "rescue", "always"):
            if key in task:
                yield from module_names(task[key])
        for key in ("action", "local_action"):
            value = task.get(key)
            if isinstance(value, str):
                yield value.split()[0]
            elif isinstance(value, dict) and "module" in value:
                yield value["module"]
        for key in task:
            if key not in KEYWORDS and not key.startswith("with_"):
                yield key


def main(roles_dir):
    used = {}
    for role in sorted(Path(roles_dir).iterdir()):
        for directory in ("tasks", "handlers"):
            for path in sorted((role / directory).rglob("*.y*ml")):
                for module in module_names(yaml.safe_load(path.read_text())):
                    used.setdefault(module, set()).add(role.name)

    # Collections come from ANSIBLE_COLLECTIONS_PATH or the default paths.
    init_plugin_loader()
    unresolved = {
        module: roles
        for module, roles in used.items()
        if not (module_loader.find_plugin_with_context(module).resolved or action_loader.find_plugin_with_context(module).resolved)
    }
    print(f"{len(used)} module names used by {len(set().union(*used.values()))} roles, {len(unresolved)} do not resolve")
    for module, roles in sorted(unresolved.items()):
        print(f"::error::{module} does not resolve, used by {', '.join(sorted(roles))}")
    return 1 if unresolved else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
