class PostModel {
   String? name;
   String? image;
   String? dateTime;
   String? uId;
   String? postImage;
   String? text;

  PostModel({
    this.name,
    this.text,
    this.postImage,
    this.uId,
    this.image,
    this.dateTime,

  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'postImage': postImage,
    };
  }
}
