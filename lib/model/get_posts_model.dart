class GetPostModel {
  int? userId, id;
  String? title, body;

  GetPostModel({this.userId, this.id, this.title, this.body});

  factory GetPostModel.fromJson(Map<String, dynamic> json) {
    return GetPostModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"]
    );
  }
}