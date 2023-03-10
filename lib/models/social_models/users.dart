class SocialUserModel{

  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  bool? isEmailVerified;
  String? image;
  String? cover;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.isEmailVerified,
    this.image,
    this.cover,
});
  SocialUserModel.fromJson(Map<String,dynamic> json){

    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    uId = json['uId'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap ()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };
  }
}
