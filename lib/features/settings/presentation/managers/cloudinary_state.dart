part of 'cloudinary_bloc.dart';

@immutable
abstract class CloudinaryState {}

class CloudinaryInitial extends CloudinaryState {}

class ChangeImage extends CloudinaryState {}

class UploadImageLoading extends CloudinaryState {}

class UploadImageSuccess extends CloudinaryState {
  final UploadImageResponse response;

  UploadImageSuccess({required this.response});
}

class UploadImageFailure extends CloudinaryState {
  final String message;

  UploadImageFailure({required this.message});
}
