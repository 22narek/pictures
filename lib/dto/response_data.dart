import 'package:picture_app/dto/picture_entity.dart';

class ResponseData<T> {
  late final int totalItems;
  late final int itemsPerPage;
  late final int countOfPages;
  late final List<T> data;

  ResponseData({
    required this.totalItems,
    required this.itemsPerPage,
    required this.countOfPages,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData<T>(
        totalItems: json['totalItems'],
        itemsPerPage: json['itemsPerPage'],
        countOfPages: json['countOfPages'],
        data: ResponseData._dataFromJson<T>(json['data'] as List),
      );

  static _dataFromJson<T>(List json) {
    if (T == PictureEntity) {
      return json.map((e) => PictureEntity.fromJson(e) as T).toList();
    }
    return json.map((e) => e as T).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['totalItems'] = totalItems;
    map['itemsPerPage'] = itemsPerPage;
    map['countOfPages'] = countOfPages;

    if (T is PictureEntity) {
      map['data'] =
          List<T>.from(data.map((x) => (x as PictureEntity).toJson()));
    }

    return map;
  }
}
