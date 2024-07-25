class UserModel {
  final String fullName;
  final String email;
  final String? photoUrl; // Make it nullable as it might be null
  final String userId;
  final String signUpMethod;
 final DateTime? createdAt; // Make it nullable as it might be null

  UserModel({
    required this.fullName,
    required this.email,
    this.photoUrl,
    required this.userId,
    required this.signUpMethod,
    this.createdAt,
  });

  // Factory method to create UserData object from a map (e.g., Firebase snapshot)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      userId: map['userId'] ?? '',
      signUpMethod: map['signUpMethod'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  // Method to convert UserData object to a map (e.g., for saving to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
      'userId': userId,
      'signUpMethod': signUpMethod,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }
}
