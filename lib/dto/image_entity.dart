import 'package:picture_app/consts/endpoints.dart';

class ImageEntity {
  final int id;
  final String name;

  ImageEntity({required this.id, required this.name});

  factory ImageEntity.fromJson(dynamic json) =>
      ImageEntity(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  String getUrl() {
    return Endpoint.apiImageUrl + name;
  }
}
