from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_blocked_list = Blueprint('ig_self_blocked_list', __name__)

@self_blocked_list.route('/api/blocked_list/<username>/<password>', methods=['GET'])
def blocked_list(username, password):
    api = ig_login(username, password)
    blocked_users = api.blocked_user_list()
    
    return jsonify({"Data:" : blocked_users})

