#!/usr/bin/env python
import sys
sys.path.insert(1,'{{ galaxy_install_path }}')
sys.path.insert(1,'{{ galaxy_install_path }}/lib')

from galaxy.model import User, APIKeys
from galaxy.model.mapping import init
from galaxy.model.orm.scripts import get_config
import argparse

#______________________________________
def cli_options():
  parser = argparse.ArgumentParser(description='Delete galaxy users')
  parser.add_argument('-u', '--user',  dest='user', help='User to delete')
  parser.add_argument('-c', '--config-file', dest='config_file', help='Galaxy ini file')
  return parser.parse_args()

#______________________________________
def delete_user(sa_session, security_agent, email):

  query = sa_session.query( User ).filter_by( email=email )

  if query.count() > 0:
    user = query.first()
    sa_session.delete(user)
    sa_session.flush()
  else:
    print 'No user %s found' % email
    #raise Exception('No user %s found' % email)

#______________________________________
def delete_galaxy_user():

  db_url = get_config(sys.argv, use_argparse=False)['db_url']

  options = cli_options()

  mapping = init('/tmp/', db_url)
  sa_session = mapping.context
  security_agent = mapping.security_agent

  delete_user(sa_session, security_agent, options.user)

#______________________________________
if __name__ == "__main__":
   delete_galaxy_user()
