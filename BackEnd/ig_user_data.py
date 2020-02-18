from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

user_data = Blueprint('ig_user_data', __name__)

@user_data.route('/api/user_data/<username>/<password>/<user_id>', methods=['GET'])
def get_user_data(username, password, user_id):
    api = ig_login(username, password)
    data = api.user_detail_info(user_id)

    return jsonify({'Data': data})


