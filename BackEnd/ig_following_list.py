from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

user_following_list = Blueprint('ig_user_following_list', __name__)

@user_following_list.route('/api/following_list/<username>/<password>', methods=['GET'])
def following_list(username, password):
    api = ig_login(username, password)
    user_id = api.authenticated_user_id
    following = []
    rank = api.generate_uuid()
    results = api.user_following(user_id, rank)
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.user_following(user_id, rank_token=rank, max_id=next_max_id)
        following.extend(results.get('users', []))
        next_max_id = results.get('next_max_id')
    following.extend(results.get('users', []))
    
    return jsonify({"Data:" : following})

