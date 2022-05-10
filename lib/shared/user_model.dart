class UserModel {
  String uid;
  String email;
  String userName;
  String phoneNumber;
  String imageUrl;

  UserModel({this.uid, this.email, this.userName, this.imageUrl, this.phoneNumber});

  // data from firestore database
  factory UserModel.fromMap(map)
  {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        userName: map['userName'],
        phoneNumber: map['phoneNumber'],
        imageUrl: map['imageUrl']
    );
  }

  //sending data to our database
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'imageUrl' : imageUrl,
    };
  }


}