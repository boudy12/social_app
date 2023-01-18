class PostModel{

  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;

  PostModel({
    this.name,
    this.dateTime,
    this.postImage,
    this.uId,

    this.image,
    this.text,
  });
  PostModel.fromJson(Map<String,dynamic> json){

    name = json['name'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    image = json['image'];
    uId = json['uId'];
    text = json['text'];
  }

  Map<String,dynamic> toMap ()
  {
    return {
      'name':name,
      'dateTime':dateTime,
      'postImage':postImage,
      'uId':uId,
      'text':text,
      'image':image,
    };
  }
}
