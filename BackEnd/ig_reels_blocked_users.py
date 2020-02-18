from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_reels_blocked_list = Blueprint('ig_self_reels_blocked_list', __name__)

@self_reels_blocked_list.route('/api/reels_blocked_list/<username>/<password>', methods=['GET'])
def reels_blocked_list(username, password):
    api = ig_login(username, password)
    reels_blocked_users = api.blocked_reels()
    
    return jsonify({"Data:" : reels_blocked_users})

