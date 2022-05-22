class UserInformation {
  String uid;
  String email;
  bool isSeller;

  UserInformation(
      {required this.uid, required this.email, this.isSeller = false});
}
