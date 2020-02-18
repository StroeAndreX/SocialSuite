from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

direct_data = Blueprint('ig_direct_data', __name__)

@direct_data.route('/api/direct/<username>/<password>/', methods=['GET'])
def direct_info(username, password):
    api = ig_login(username, password)
    direct = api.direct_v2_inbox()

    return jsonify({'Data': direct})

