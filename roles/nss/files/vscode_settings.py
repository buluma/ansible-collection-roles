# This is a very simple script created very fast with only
# goal to deal with VSCode json files.
# Parameters are not validated, as they are hardcoded in this Ansible Module.
# So, be careful if using it manually or if modifying the Module.
# 
# And, feel free to suggest improvements. : )

#!/usr/bin/python
import json
import sys

if len(sys.argv) == 6:
    action = sys.argv[1]
    json_file = sys.argv[2]
    section = sys.argv[3]
    parameter = sys.argv[4]
    value = sys.argv[5]
else:
   print ("Syntax: ",sys.argv[0]," <add|remove> <file> <section> <parameter> <value>")
   print ("Syntax: ",sys.argv[0]," add /tmp/workstaces.json folders path /home/user/DEV/BUG000_TTT")
   sys.exit(1)

with open(json_file, "r+") as roFile:
    data = json.load(roFile)
    roFile.close

# Prepare the entry in a generic way
entry = { parameter: value }

if action == 'add':
    try:
        if entry not in data[section]:
            data[section].append(entry)
    except:
        print ("Cannot add the entry. Possibly some argument is wrong.")
        # I know. This script was made to work with this Ansible role.
        sys.exit(0)
elif action == 'remove':
    try:
        data[section].remove(entry)
    except:
        print ("Cannot remove the entry. Possibly some argument is wrong or the entry doesn't exist.")
        sys.exit(0)
else:
    print ("Invalid Action")
    sys.exit(3)

#print(json.dumps(data, indent = 8, sort_keys=True))
with open(json_file, "w") as rwFile:
    rwFile.seek(0)  # rewind
    rwFile.write(json.dumps(data, indent = 8, sort_keys=True))
    rwFile.truncate()
    rwFile.close
sys.exit(0)