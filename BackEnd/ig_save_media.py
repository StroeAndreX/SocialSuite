from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

save_media = Blueprint('ig_save_media', __name__)

@save_media.route('/api/save_media/<username>/<password>/<media_id>', methods=['GET'])
def ig_save_media(username, password, media_id):
    api = ig_login(username, password)
    media_id = api.save_photo(media_id)

    return jsonify({'Data': media_id})