from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_archived_media = Blueprint('ig_self_archived_media', __name__)

@self_archived_media.route('/api/archivied_media/<username>/<password>', methods=['GET'])
def archivied_media(username, password):
    api = ig_login(username, password)
    results = api.feed_only_me()
    next_max_id = results.get('next_max_id')

    while next_max_id:
        results = api.feed_only_me(max_id=next_max_id)
        next_max_id = results.get('next_max_id')
    
    return jsonify({"Data:" : results})

