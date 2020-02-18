from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

media_data = Blueprint('ig_media_data', __name__)

@media_data.route('/api/media_data/<username>/<password>/<media_id>', methods=['GET'])
def media_informations(username, password, media_id):
    api = ig_login(username, password)
    data = api.user_feed(media_id)

    return jsonify({'Data': data})

