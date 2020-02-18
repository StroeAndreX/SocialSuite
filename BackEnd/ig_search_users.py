from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

search_users = Blueprint('ig_search_users', __name__)

@search_users.route('/api/saved_feed/<username>/<password>/<user>', methods=['GET'])
def ig_search_users(username, password, user):
    api = ig_login(username, password)
    results = api.search_users(user)
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.search_users(user, max_id=next_max_id)
        next_max_id = results.get('next_max_id')
    
    return jsonify({"Data:" : results})

