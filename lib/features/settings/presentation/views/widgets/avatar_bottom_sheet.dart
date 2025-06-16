import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_intent_icon.dart';

class AvatarBottomSheet extends StatelessWidget {
  const AvatarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    double iconSize = 40;

    return SafeArea(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.gray.withOpacity(0.3),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomIntentIcon(
                  title: "Camera",
                  iconSize: iconSize,
                  titleStyle: style,
                  onTap: () {
                    context.read<CloudinaryBloc>().pickImage(
                      ImageSource.camera,
                    );
                    context.pop();
                  },
                  icon: Icons.photo_camera,
                ),
                CustomIntentIcon(
                  title: "Gallery",
                  iconSize: iconSize,
                  titleStyle: style,
                  onTap: () {
                    context.read<CloudinaryBloc>().pickImage(
                      ImageSource.gallery,
                    );
                    context.pop();
                  },
                  icon: Icons.photo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
