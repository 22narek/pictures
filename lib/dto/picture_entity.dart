// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:picture_app/dto/image_entity.dart';

class PictureEntity {
  final int id;
  final ImageEntity image;
  final bool? isNew;
  final bool? isPopular;
  final String? name;
  final String? dateCreate;
  final String? description;
  final String? user;

  PictureEntity({
    required this.id,
    required this.image,
    this.isNew,
    this.isPopular,
    this.name,
    this.dateCreate,
    this.description,
    this.user,
  });

  factory PictureEntity.fromJson(dynamic json) => PictureEntity(
        id: json['id'],
        name: json['name'],
        dateCreate: json['dateCreate'],
        description: json['description'],
        isNew: json['new'],
        isPopular: json['popular'],
        user: json['user'],
        image: ImageEntity.fromJson(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dateCreate': dateCreate,
        'description': description,
        'new': isNew,
        'popular': isPopular,
        'user': user,
        'image': image.toJson(),
      };
}
