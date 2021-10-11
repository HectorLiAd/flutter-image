import 'dart:convert';

class ModeloImagen {
  var id;
  String title;
  String detail;
  String image;
  String created;
  String modified;

  ModeloImagen({this.title ="",this.id, this.created="", this.modified='', this.detail="", this.image=""});
  factory ModeloImagen.fromJson(Map<String, dynamic> map) {
    return ModeloImagen(
      id: map['id'],
      title: map["title"],
      detail: map["detail"],
      image: map["image"],
      created: map["created"],
      modified: map['modified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "detail": detail,
      "image": image,
      "created": created,
      "modified": modified,
    };
  }

  @override
  String toString() {
    return 'ModeloPersona{id: $id, title: $title}';
  }
}