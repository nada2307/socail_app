class UserModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late String? bio;
  late String? uId;
  late String? cover;
  late bool? mailVerification;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.bio,
    this.cover,
    this.mailVerification,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    mailVerification = json['mailVerification'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'mailVerification': mailVerification,
    };
  }
}
