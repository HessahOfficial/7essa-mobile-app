part of 'cloudinary_bloc.dart';

@immutable
abstract class CloudinaryEvent {}

class UploadImageEvent extends CloudinaryEvent {
  final UploadImageRequest request;

  UploadImageEvent({required this.request});
}
