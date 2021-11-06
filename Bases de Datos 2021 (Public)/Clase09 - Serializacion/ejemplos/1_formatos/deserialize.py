#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

# Serializers/printers
import xmlrpc.client as xmlrpclib   # python 3
import json
import yaml
from pprint import pprint


if __name__ == '__main__':
    # Uso: deserialize #formato
    # Formato puede ser: xml, json, yaml
    format = sys.argv[1] if len(sys.argv) == 2 else 'xml'

    bytes = sys.stdin.read()

    if format == 'xml':
        data = xmlrpclib.loads(bytes)
    elif format == 'json':
        data = json.loads(bytes)
    elif format == 'yaml':
        data = yaml.load(bytes, Loader=yaml.Loader)

    pprint(data)
