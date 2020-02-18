import hashlib
import string
import random
import time
import re
import requests
import json
import gzip

from io import BytesIO
from instagram_private_api import Client, ClientCompatPatch
from instagram_private_api.client import compat_urllib_parse, compat_urllib_request, compat_urllib_error, ErrorHandler

from instagram_web_api import Client as WebClient

class MyAppClient(Client):
    
    def login(self):
        """Login."""

        print('overrided login()')

        prelogin_params = self._call_api(
            'si/fetch_headers/',
            params='',
            query={'challenge_type': 'signup', 'guid': self.generate_uuid(True)},
            return_response=True)

        login_params = {
            'device_id': self.device_id,
            'guid': self.uuid,
            'adid': self.ad_id,
            'phone_id': self.phone_id,
            '_csrftoken': self.csrftoken,
            'username': self.username,
            'password': self.password,
            'login_attempt_count': '0',
        }

        try:
            """
            login_response = self._call_api(
            'accounts/login/', params=login_params, return_response=True)
            """

            url = 'https://i.instagram.com/api/v1/accounts/login/'
            params = login_params

            headers = self.default_headers
            headers['Content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
            
            json_params = json.dumps(params, separators=(',', ':'))
            hash_sig = self._generate_signature(json_params)
            post_params = {
                'ig_sig_key_version': self.key_version,
                'signed_body': hash_sig + '.' + json_params
            }

            data = compat_urllib_parse.urlencode(post_params).encode('ascii')
            req = compat_urllib_request.Request(url, data, headers=headers)

            try:
                response = self.opener.open(req, timeout=self.timeout)
            except compat_urllib_error.HTTPError as e:
                response_text = json.loads(e.read().decode('utf8'))
                checkpoint_url = response_text.get('challenge').get('url')
                self.login_challenge(checkpoint_url, headers)
                
        except Exception as e:
            print('unhandled exception', e)

    def login_challenge(self, checkpoint_url, headers):

        try:
            print('redirecting to ..', checkpoint_url)
            headers['X-CSRFToken'] = self.csrftoken
            headers['Referer'] = checkpoint_url
            
            mode = int(input('Choose a challenge mode (0 - SMS, 1 - Email): '))
            challenge_data = {'choice': mode}
            data = compat_urllib_parse.urlencode(challenge_data).encode('ascii')
            
            req = compat_urllib_request.Request(checkpoint_url, data, headers=headers)
            response = self.opener.open(req, timeout=self.timeout)

            code = input('Enter code received: ')
            code_data = {'security_code': code}
            data = compat_urllib_parse.urlencode(code_data).encode('ascii')

            req = compat_urllib_request.Request(checkpoint_url, data, headers=headers)
            response = self.opener.open(req, timeout=self.timeout)

            if response.info().get('Content-Encoding') == 'gzip':
                buf = BytesIO(response.read())
                res = gzip.GzipFile(fileobj=buf).read().decode('utf8')
            else:
                res = response.read().decode('utf8')
    
        except compat_urllib_error.HTTPError as e:
            print('unhandled exception', e)