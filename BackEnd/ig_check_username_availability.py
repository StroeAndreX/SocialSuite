from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

check_username_availability = Blueprint('ig_check_username_availability', __name__)

@check_username_availability.route('/api/<username>/<password>/<newusername>', methods=['GET'])
def check_username(username, password, newusername):
    api = ig_login(username, password)
    result = api.check_username(newusername)

    return jsonify({"Data: " : result})