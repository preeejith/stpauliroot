class SignupUser {
  String? name;
  String? email;
  String? uid;
  String? authProvider;
  String? profilePic;
  String? mobileNumber;
  String? userToken;
  String? userType;
  bool? currentStatus;

  SignupUser({
    this.name,
    this.email,
    this.uid,
    this.authProvider,
    this.profilePic,
    this.mobileNumber,
    this.currentStatus,
    this.userToken,
    this.userType,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      authProvider: json['authProvider'],
      profilePic: json['profilePic'],
      mobileNumber: json['mobileNumber'],
      currentStatus: json['currentStatus'],
      userToken: json['userToken'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'authProvider': authProvider,
        'profilePic': profilePic,
        'mobileNumber': mobileNumber,
        'currentStatus': currentStatus,
        'userToken': userToken,
        'userType': userType,
      };
}
