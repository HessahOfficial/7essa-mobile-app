import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/data/models/upload_image_request.dart';
import 'package:hessa/features/settings/data/models/upload_image_response.dart';
import 'package:hessa/features/settings/data/repositories/cloudinary_service.dart';
import 'package:hessa/features/settings/presentation/views/widgets/avatar_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'cloudinary_event.dart';
part 'cloudinary_state.dart';

class CloudinaryBloc extends Bloc<CloudinaryEvent, CloudinaryState> {
  final CloudinaryService service;

  File? image;

  final imagePicker = getIt.get<ImagePicker>();

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ChangeImage());
    }
  }

  void showAvatarBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: AvatarBottomSheet(),
        );
      },
    );
  }

  CloudinaryBloc({required this.service}) : super(CloudinaryInitial()) {
    on<UploadImageEvent>((event, emit) async {
      emit(UploadImageLoading());
      final response = await service.uploadImage(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(UploadImageFailure(message: failure.message));
        },
        (data) {
          print(data);
          emit(UploadImageSuccess(response: data));
        },
      );
    });
  }
}
