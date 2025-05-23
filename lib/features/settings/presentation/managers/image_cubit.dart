import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/presentation/views/widgets/avatar_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

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
}
