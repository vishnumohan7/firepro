class UserModel {
   String? id;
  final String email;
  final String? password;
  final String address;
  final String? mobNo;
  final String? name;

  UserModel(
      {this.id,
        this.name,
        this.password,
      required this.email,
      required this.address,
       this.mobNo});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      id: json["id"],
      email: json["email"],
      address: json["address"],
      mobNo: json["mobNo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "address": this.address,
      "mobNo": this.mobNo,
    };
  }
//

  // saveUserData(UserModel userModel) {}
}
