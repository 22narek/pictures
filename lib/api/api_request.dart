import 'package:dio/dio.dart';
import 'package:picture_app/api/interface.dart';
import 'package:picture_app/consts/endpoints.dart';
import 'package:picture_app/dto/picture_entity.dart';
import 'package:picture_app/dto/response_data.dart';

class RequestApi implements RequestInterface {
  @override
  Future<ResponseData<PictureEntity>> getPhotos({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  }) async {
    Dio dio = Dio();
    Map<String, dynamic> parameters = {'page': page, 'limit': limit};
    if (isNew) parameters.addAll({'new': isNew});
    if (isPopular) parameters.addAll({'popular': isPopular});
    Response response =
        await dio.get(Endpoint.apiRequestUrl, queryParameters: parameters);
    if (response.statusCode == 200) {
      ResponseData<PictureEntity> responseData =
          ResponseData<PictureEntity>.fromJson(response.data);
      return responseData;
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
