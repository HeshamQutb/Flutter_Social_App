class PostModel{

  dynamic name;
  dynamic uId;
  dynamic image;
  dynamic postImage;
  dynamic dateTime;
  dynamic clockTime;
  dynamic text;

  PostModel(
      this.name,
      this.uId,
      this.image,
      this.postImage,
      this.dateTime,
      this.clockTime,
      this.text,
      );


  PostModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    uId = json?['uId'];
    image = json?['image'];
    postImage = json?['postImage'];
    dateTime = json?['dateTime'];
    clockTime = json?['clockTime'];
    text = json?['text'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'postImage':postImage,
      'dateTime':dateTime,
      'clockTime':clockTime,
      'text':text,
    };
}
}