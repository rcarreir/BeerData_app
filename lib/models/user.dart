class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final double balance;
  // final bool emailVerified;

  UserData(
      {this.uid, this.name, this.email, this.balance /*,this.emailVerified*/});
}
