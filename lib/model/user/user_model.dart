class UserModel {
  int userID;
  String email;
  String username;
  String password;
  String fullname;

  UserModel({
    required this.userID,
    required this.email,
    required this.username,
    required this.password,
    required this.fullname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      fullname: json['fullname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'email': email,
      'username': username,
      'password': password,
      'fullname': fullname,
    };
  }
}
