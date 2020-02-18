from flask import Flask, jsonify, abort, Blueprint
from instagram_private_api import Client, ClientCompatPatch
from login import ig_login

news = Blueprint('ig_news', __name__)

@news.route('/api/news/<username>/<password>', methods=['GET'])
def ig_news(username, password):
    api = ig_login(username, password)
    news = api.news_inbox()

    return jsonify({'Data': news})