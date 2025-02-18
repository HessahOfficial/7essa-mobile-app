import 'package:flutter/material.dart';
import 'package:hessa/constants/app_colors.dart';

Widget customTextField({
  required IconData icon,
  required Color iconColor,
  required Color inputColor,
  required Color iconBackgroundColor,
  required String placeholder,
  required double screenWidth,
  required TextEditingController controller,
  double? height,
  double? borderRadius,
  TextInputType? type,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
    width:  screenWidth,
    height: height?? 60,
    decoration: BoxDecoration(
      color: inputColor,
      borderRadius: BorderRadius.circular(borderRadius?? 20)
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundColor: iconBackgroundColor,
            radius: borderRadius?? 20,
            child: Icon(
                icon,
                size: 17,
                color: iconColor
            ),
          ),),
        SizedBox(
          width: screenWidth * 0.7,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: placeholder,
                hintStyle: TextStyle(
                    color: AppColors.gray
                )
            ),
          ),
        )
      ],
    ),
  );
}