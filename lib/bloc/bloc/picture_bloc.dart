import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_app/api/api_request.dart';
import 'package:picture_app/bloc/bloc/picture_event.dart';
import 'package:picture_app/bloc/bloc/picture_state.dart';
import 'package:picture_app/dto/picture_entity.dart';
import 'package:picture_app/dto/response_data.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final bool isNew;
  final bool isPopular;

  int _page = 0;
  final List<PictureEntity> _photos = [];
  final int _limit = 14;
  int _countOfPages = 0;
  bool _hasReachedMax = false;

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  PictureBloc({this.isNew = false, this.isPopular = false})
      : super(PictureInitial()) {
    on<PictureFetched>(
      _onPhotoFetched,
      transformer: throttleDroppable(const Duration(seconds: 1)),
    );
    on<PictureRefreshed>(_onPhotoRefreshed);
  }

  Future<void> _onPhotoFetched(
    PictureFetched event,
    Emitter<PictureState> emit,
  ) async {
    try {
      if (!_hasReachedMax) {
        await _fetchPhotos();
        emit(PictureSuccess(pictures: _photos, hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      emit(PictureError(e.toString()));
    }
  }

  Future<void> _onPhotoRefreshed(
    PictureRefreshed event,
    Emitter<PictureState> emit,
  ) async {
    try {
      _hasReachedMax = false;
      _page = 0;
      _photos.clear();
      _countOfPages = 0;
      await _fetchPhotos();
      emit(PictureSuccess(pictures: _photos, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(PictureError(e.toString()));
    }
  }

  Future<void> _fetchPhotos() async {
    _page++;
    RequestApi requestApi = RequestApi();
    ResponseData responseData = await requestApi.getPhotos(
      isNew: isNew,
      isPopular: isPopular,
      page: _page,
      limit: _limit,
    );
    _countOfPages = responseData.countOfPages;
    final List<PictureEntity> photos = responseData.data as List<PictureEntity>;
    _photos.addAll(photos);
    _hasReachedMax = photos.isEmpty || _page > _countOfPages;
  }
}
