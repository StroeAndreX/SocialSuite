from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

media_likers = Blueprint('ig_media_likers', __name__)

@media_likers.route('/api/media_likers/<username>/<password>/<media_id>', methods=['GET'])
def ig_media_likers(username, password, media_id):
    api = ig_login(username, password)
    likers = []
    results = api.media_likers(media_id)
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.media_likers(media_id, max_id=next_max_id)
        likers.extend(results.get('users', []))
        next_max_id = results.get('next_max_id')

    likers.extend(results.get('users', []))
    
    return jsonify({"Data:" : likers})

