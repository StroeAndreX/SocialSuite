from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

explore = Blueprint('ig_explore', __name__)

@explore.route('/api/explore/<username>/<password>/', methods=['GET'])
def get_explore(username, password):
    api = ig_login(username, password)
    data = api.explore()

    return jsonify({'Data': data})

