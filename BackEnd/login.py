from flask import Flask, jsonify, abort, make_response, request
from instagram_private_api import Client, ClientCompatPatch
import sys
import json
import codecs
import datetime
import os.path
import logging
import argparse
try:
    from instagram_private_api import (
        Client, ClientError, ClientLoginError,
        ClientCookieExpiredError, ClientLoginRequiredError,
        __version__ as client_version)
except ImportError:
    sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
    from instagram_private_api import (
        Client, ClientError, ClientLoginError,
        ClientCookieExpiredError, ClientLoginRequiredError,
        __version__ as client_version)

# --- configure root directory path relative to this file
THIS_FOLDER_G = ""
if getattr(sys, 'frozen', False):
    # frozen
    THIS_FOLDER_G = os.path.dirname(sys.executable)
else:
    # unfrozen
    THIS_FOLDER_G = os.path.dirname(os.path.realpath(__file__))


# --- Helper Functions for instagram Login
def to_json(python_object):
    if isinstance(python_object, bytes):
        return {'__class__': 'bytes',
                '__value__': codecs.encode(python_object, 'base64').decode()}
    raise TypeError(repr(python_object) + ' is not JSON serializable')

def from_json(json_object):
    if '__class__' in json_object and json_object['__class__'] == 'bytes':
        return codecs.decode(json_object['__value__'].encode(), 'base64')
    return json_object

def onlogin_callback(api, new_settings_file):
    cache_settings = api.settings
    with open(new_settings_file, 'w') as outfile:
        json.dump(cache_settings, outfile, default=to_json)
        print('SAVED: {0!s}'.format(new_settings_file))

def ig_login(username, password):    
    device_id = None
    settings_file = THIS_FOLDER_G + "/data" + username 

    try:
        if not os.path.isfile(settings_file):
            # settings file does not exist
            print('Unable to find file: {0!s}'.format(settings_file))

            # login new
            api = Client(
                username, password,
                on_login=lambda x: onlogin_callback(x, settings_file))
        else:
            with open(settings_file) as file_data:
                cached_settings = json.load(file_data, object_hook=from_json)
            print('Reusing settings: {0!s}'.format(settings_file))

            device_id = cached_settings.get('device_id')
            # reuse auth settings
            api = Client(
                username, password,
                settings=cached_settings)
        
        current_user = api.current_user()

    except (ClientCookieExpiredError, ClientLoginRequiredError) as e:
        print('ClientCookieExpiredError/ClientLoginRequiredError: {0!s}'.format(e))
        if os.path.isfile(settings_file):
            os.remove(settings_file)
        return {"status": "error", "msg": "Invalid Username or Password."}
        # Login expired
        # Do relogin but use default ua, keys and such
        # settings_file = THIS_FOLDER_G + "/db/data/cookies/" + username + "_" + _ID + ""
        # api = Client(
        #     username, password,
        #     device_id=device_id,
        #     on_login=lambda x: onlogin_callback(x, settings_file))

    except ClientLoginError as e:
        print('ClientLoginError {0!s}'.format(e))
        if os.path.isfile(settings_file):
            os.remove(settings_file)
        return {"status": "error", "msg": "Invalid Username or Password."}

    except ClientError as e:
        print('ClientError {0!s} (Code: {1:d}, Response: {2!s})'.format(e.msg, e.code, e.error_response))
        # if os.path.isfile(settings_file):
        #     os.remove(settings_file)
        return {"status": "error", "msg": e.msg}

    except Exception as e:
        print('Unexpected Exception: {0!s}'.format(e))
        return {"status": "error", "msg": "Something went wrong."}

    # Show when login expires
    cookie_expiry = api.cookie_jar.expires_earliest
    print('Cookie Expiry: {0!s}'.format(datetime.datetime.fromtimestamp(cookie_expiry).strftime('%Y-%m-%dT%H:%M:%SZ')))
    print('All ok')

    return api
