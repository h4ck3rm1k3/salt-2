#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Salt returner that reports errors to sentry

Inside Pillar you need to specify the following data
for the python `raven` module:

raven:
  servers:
    - http://192.168.0.1
  public_key: asdasdasdasdasdasdasdasd
  secret_key: dsadsadsadsadsadsadsadsa
  project: 1

Your minions will also require `raven` for python:

    pip install raven

or install it via a salt-state:

    raven:
      pip.installed
"""

import logging

try:
    import datetime
    import urllib
    import urllib2
    has_imports = True
except ImportError:
    has_imports = False

logger = logging.getLogger(__name__)

def __virtual__():
    if not has_imports:
        logger.error("Missing a required import 'urllib', 'urllib2' or 'datetime'")
        return False
    pillar_data = __salt__['pillar.data']()
    if 'salt-logger' not in pillar_data:
        logger.error("Missing pillar data 'salt-logger'")
        return False
    for key in [ 'key', 'servers' ]:
        if 'key' not in pillar_data['salt-logger']:
            logger.error("Missing config '%s' in pillar 'salt-logger'", key)
            return False
    return 'salt-logger'

def returner(ret):
    """
    Log return data to the remote server
    """
    pillar_data = __salt__['pillar.data']()
    remote_data = {
        'returned': ret,
        'pillar': pillar_data,
        'grains': __salt__['grains.items']()
    }
    servers = []
    for server in pillar_data['salt-logger']['servers']:
        servers.append(server + '/submit/')
    try:
        data = urllib.urlencode({'data':remote_data})
        for server in servers:
            logger.debug('Submitting results to server: {0}'.format(server))
            req = urllib2.Request(url=server)
            salt_header = '{"Date":"%s","ID":"%s","Key":"%s"}' % (datetime.datetime.now(),ret['id'],pillar_data['salt-logger']['key'])
            req.add_header('X-Salt-Logger', salt_header)
            req.add_data(data)
            r = urllib2.urlopen(req)
    except Exception, err:
        logger.error("Can't send message to remote logging server: %s", err, exc_info=True)
