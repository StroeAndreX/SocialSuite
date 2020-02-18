from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

user_geo = Blueprint('ig_user_geo', __name__)

@user_geo.route('/api/user_map/<username>/<password>/<user_id>', methods=['GET'])
def get_user_data(username, password, user_id):
    api = ig_login(username, password)
    data = api.user_map(user_id)

    return jsonify({'Data': data})


