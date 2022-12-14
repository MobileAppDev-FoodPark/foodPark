class UserModel {
  String? uid;
  String? username;
  String? email;

  UserModel({
    this.uid,
    this.username,
    this.email,
  });
  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }
}
