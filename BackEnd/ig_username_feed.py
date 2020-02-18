from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

username_feed = Blueprint('ig_username_feed', __name__)

@username_feed.route('/api/username_feed/<username>/<password>/<username_id>', methods=['GET'])
def get_user_data(username, password, username_id):
    api = ig_login(username, password)
    data = api.username_feed(username_id)

    return jsonify({'Data': data})


