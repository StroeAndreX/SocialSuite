class User 
{
  final String uid;

  User({ this.uid });

}

class UserAuthData 
{
  final String firstName;
  final String lastName;

  final String email;
  final String password;

  UserAuthData({this.firstName, this.lastName, this.email, this.password});
}