import 'package:picture_app/dto/picture_entity.dart';

abstract class PictureState {}

class PictureInitial extends PictureState {}

class PictureSuccess extends PictureState {
  final List<PictureEntity> pictures;
  final bool hasReachedMax;

  PictureSuccess({
    required this.pictures,
    this.hasReachedMax = false,
  });

  PictureSuccess copyWith({
    List<PictureEntity>? photos,
    bool? hasReachedMax,
  }) {
    return PictureSuccess(
      pictures: photos ?? pictures,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'PhotoSuccess { hasReachedMax: $hasReachedMax, photos: ${pictures.length} }';
  }

  List<Object> get props => [pictures, hasReachedMax];
}

class PictureError extends PictureState {
  String message = '';

  PictureError([this.message = '']);

  @override
  String toString() {
    return 'PhotoError { message: $message }';
  }
}
