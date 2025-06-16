part of 'cloudinary_bloc.dart';

@immutable
abstract class CloudinaryEvent {}

class UplodImageEvent extends CloudinaryEvent {
  final UploadImageRequest request;

  UplodImageEvent({required this.request});
}
