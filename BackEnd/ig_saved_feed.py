from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_saved_feed = Blueprint('ig_self_saved_feed', __name__)

@self_saved_feed.route('/api/saved_feed/<username>/<password>', methods=['GET'])
def ig_saved_feed(username, password):
    api = ig_login(username, password)
    results = api.saved_feed()
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.saved_feed(max_id=next_max_id)
        next_max_id = results.get('next_max_id')
    
    return jsonify({"Data:" : results})

