from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

self_insights = Blueprint('ig_insights', __name__)

@self_insights.route('/api/insights/<username>/<password>', methods=['GET'])
def user_insights(username, password):
    api = ig_login(username, password)
    insights = api.insights()

    return jsonify({'Data': insights})