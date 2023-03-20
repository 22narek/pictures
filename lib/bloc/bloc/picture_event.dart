abstract class PictureEvent {
  List<Object> get props => [];
}

class PictureFetched extends PictureEvent {}

class PictureRefreshed extends PictureEvent {}
