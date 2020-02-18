from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

user_follower_list = Blueprint('ig_user_follower_list', __name__)

@user_follower_list.route('/api/follower_list/<username>/<password>', methods=['GET'])
def followers_list(username, password):
    api = ig_login(username, password)
    user_id = api.authenticated_user_id
    followers = []
    rank = api.generate_uuid()
    results = api.user_followers(user_id, rank)
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.user_followers(user_id, rank_token=rank, max_id=next_max_id)
        followers.extend(results.get('users', []))
        next_max_id = results.get('next_max_id')
    followers.extend(results.get('users', []))
    
    return jsonify({"Data:" : followers})

