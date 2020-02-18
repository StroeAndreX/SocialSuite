from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

username_data = Blueprint('ig_username_data', __name__)

@username_data.route('/api/username_data/<username>/<password>/<username_id>', methods=['GET'])
def get_user_data(username, password, username_id):
    api = ig_login(username, password)
    data = api.username_info(username_id)

    return jsonify({'Data': data})


