class IGMyData {
  String userId;
  String username;

  IGMyData({ this.username, this.userId });

  factory IGMyData.fromJson(Map<String, dynamic> json) {
    return IGMyData(
      userId: json['userId'],
      username: json['title'],
    );
  }
}

class IGMyFollowers {
  String username;
  String mediaURL;
  
  IGMyFollowers({ this.username, this.mediaURL });

  factory IGMyFollowers.fromJson(Map<String, dynamic> json) {
    return IGMyFollowers(
      username: json['username'].toString(),
      mediaURL: json['profile_pic_url'].toString(),
    );

  }

}

class IGMyInsights {
  String lostFollower_label;
  String lostFollowers_value; 
  String newFollowers_value;
  String newFollowers_label;
  var newFollowers_date;

  String userReached_label;
  String userReached_value;

  IGMyInsights({this.lostFollowers_value, this.lostFollower_label, this.newFollowers_value, this.newFollowers_label, this.userReached_label, this.userReached_value, this.newFollowers_date});

  factory IGMyInsights.lostFollowes(Map<String, dynamic> json) {
    return IGMyInsights(
      //data: json['account_actions_graph']['total_count_graph']['data_points'],
      lostFollower_label: json['timestamp'].toString(),
      lostFollowers_value: json['value'].toString(),
    );
  }

  factory IGMyInsights.newFollower(Map<String, dynamic> json) {
    return IGMyInsights(
      //data: json['account_actions_graph']['total_count_graph']['data_points'],
      newFollowers_value: json['timestamp'].toString(),
      newFollowers_label: json['value'].toString(),
    );
  }


  factory IGMyInsights.usersReached(Map<String, dynamic> json) {
    return IGMyInsights(
      //data: json['account_actions_graph']['total_count_graph']['data_points'],
      userReached_label: json['label'].toString(),
      userReached_value: json['value'].toString(),
    );
  }


}
