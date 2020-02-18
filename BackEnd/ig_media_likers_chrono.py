from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

media_likers_chrono = Blueprint('ig_media_likers_chrono', __name__)

@media_likers_chrono.route('/api/media_likers_chrono/<username>/<password>/<media_id>', methods=['GET'])
def ig_media_likers_chrono(username, password, media_id):
    api = ig_login(username, password)
    likers = []
    results = api.media_likers_chrono(media_id)
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.media_likers_chrono(media_id)
        likers.extend(results.get('users', []))
        next_max_id = results.get('next_max_id')

    likers.extend(results.get('users', []))
    
    return jsonify({"Data:" : likers})

