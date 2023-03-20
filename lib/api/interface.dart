import 'package:picture_app/dto/picture_entity.dart';
import 'package:picture_app/dto/response_data.dart';

abstract class RequestInterface {
  Future<ResponseData<PictureEntity>> getPhotos({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  });
}
