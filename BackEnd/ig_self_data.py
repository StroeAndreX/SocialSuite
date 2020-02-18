from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_user_data = Blueprint('ig_self_data', __name__)

@self_user_data.route('/api/self_data/<username>/<password>', methods=['GET'])
def ig_self_data(username, password):
    api = ig_login(username, password)
    data = api.user_detail_info(api.authenticated_user_id)

    return jsonify({'Data': data})
