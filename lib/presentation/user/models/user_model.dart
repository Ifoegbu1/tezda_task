class UserModel {
  String uid;

  String email;

  String displayName;

  String? photoURL;

  String? phoneNumber;

  DateTime? creationTimestamp;

  DateTime? lastSignInTimestamp;
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.creationTimestamp,
    this.lastSignInTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'creationTimestamp': creationTimestamp?.millisecondsSinceEpoch,
      'lastSignInTimestamp': lastSignInTimestamp?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoURL: map['photoURL'],
      phoneNumber: map['phoneNumber'],
      creationTimestamp: map['creationTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['creationTimestamp'])
          : null,
      lastSignInTimestamp: map['lastSignInTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastSignInTimestamp'])
          : null,
    );
  }
}
