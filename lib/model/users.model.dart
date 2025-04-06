List<UsersModel> usersModelFromJson(str) =>
    List<UsersModel>.from(str.map((x) => UsersModel.fromJson(x.data())));

// String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class UsersModel {
  String? emailAddress;
  String? fullName;
  bool? isVerify;
  String? phoneNumber;
  String? role;
  bool? isBlock; // New field
  String? userId; // New field

  UsersModel({
    this.emailAddress,
    this.fullName,
    this.isVerify,
    this.phoneNumber,
    this.role,
    this.isBlock, // New field
    this.userId, // New field
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        emailAddress: json["email_address"],
        fullName: json["full_name"],
        isVerify: json["is_verify"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        isBlock: json["isBlock"], // New field
        userId: json["userId"], // New field
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress,
        "full_name": fullName,
        "is_verify": isVerify,
        "phone_number": phoneNumber,
        "role": role,
        "isBlock": isBlock, // New field
        "userId": userId, // New field
      };
}
