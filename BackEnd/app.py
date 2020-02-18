from flask import Flask, jsonify, abort, make_response, request
from os import environ
from instagram_private_api import Client, ClientCompatPatch
from ig_self_data import self_user_data, ig_login
from ig_insights import self_insights
from ig_user_data import user_data
from ig_media_data import media_data
from ig_direct_info import direct_data
from ig_follower_list import user_follower_list
from ig_following_list import user_following_list
from ig_blocked_users import self_blocked_list
from ig_reels_blocked_users import self_reels_blocked_list
from ig_check_username_availability import check_username_availability
from ig_feed_liked import feed_liked
from ig_explore import explore
from ig_archived_media import self_archived_media
from ig_media_likers import media_likers
from ig_media_likers_chrono import media_likers_chrono
from ig_news import news
from ig_save_media import save_media
from ig_saved_feed import self_saved_feed
from ig_search_users import search_users
from ig_user_geo import user_geo
from ig_username_data import username_data
from ig_username_feed import username_feed
import sys
import json
import codecs
import datetime
import os.path
import logging
import argparse
try:
    from instagram_private_api import (
        Client, ClientError, ClientLoginError,
        ClientCookieExpiredError, ClientLoginRequiredError,
        __version__ as client_version)
except ImportError:
    sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
    from instagram_private_api import (
        Client, ClientError, ClientLoginError,
        ClientCookieExpiredError, ClientLoginRequiredError,
        __version__ as client_version)

# --- configure flask
app = Flask(__name__)

#### ENDPOINTS ####

app.register_blueprint(self_user_data) #Detailed information about self.profile
app.register_blueprint(self_insights) #Detailed information about self.insights --- insights -> Business Accounts details
app.register_blueprint(user_data) #Detailed information about someones profile --- Only public profiles 
app.register_blueprint(user_data) #Informations about a media [Video / Photo]
app.register_blueprint(direct_data) #Get SELF direct index overview 
app.register_blueprint(user_follower_list) #User list of follower
app.register_blueprint(user_following_list) #User list of following
app.register_blueprint(self_blocked_list) #List of users I blocked 
app.register_blueprint(self_reels_blocked_list) #List of users I blocked 
app.register_blueprint(check_username_availability) #Check whether a username is available or not 
app.register_blueprint(feed_liked) #All the posts I recently Liked. 
app.register_blueprint(explore) #A couple of explore pages medias
app.register_blueprint(self_archived_media) #Get all the media I archived.. 
app.register_blueprint(media_likers) #All the users who liked a media.. 
app.register_blueprint(media_likers_chrono) #All the users who liked a media, but listed in chronological order. 
app.register_blueprint(news) #This returns the items in the ‘Following’ tab.
app.register_blueprint(save_media) #Save media. 
app.register_blueprint(self_saved_feed) #Get All the media I saved
app.register_blueprint(search_users) #Search for a user
app.register_blueprint(user_geo) #List of Geo-Tagged media from a user 
app.register_blueprint(username_data) #User Data based on the username string and not his ID 
app.register_blueprint(username_feed) #User Feed based on the username string and not his ID 

@app.route('/')
def index():
    return "<h1>Welcome to our server !!</h1>"

@app.route('/login/<username>/<password>', methods=["GET"])
def login(username, password):
    api = ig_login(username, password)

    if isinstance(api, dict) and "status" in api and api["status"] == "error":
        return jsonify(api)
    else:
        current_user = api.current_user()
        return jsonify(current_user)

if __name__ == '__main__':
    app.run(threaded=True, port=5000)