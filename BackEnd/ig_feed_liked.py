from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

feed_liked = Blueprint('ig_feed_liked', __name__)

@feed_liked.route('/api/feed_liked/<username>/<password>/', methods=['GET'])
def self_feed_liked(username, password):
    api = ig_login(username, password)
    data = api.feed_liked()

    return jsonify({"Data: " : data})
