import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/themes/dark_theme.dart';
import 'package:hessa/core/themes/light_theme.dart';

import 'package:hessa/core/utils/service_locator.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color inputColor;
  final String? placeholder;
  final String? label;
  final Color? labelColor;
  final TextEditingController controller;
  final void Function(String val)? onChanged;
  final void Function()? suffixFunction;
  final String? Function(String?)? validator;
  final double? height;
  final double? borderRadius;
  final double? iconSize;
  final TextInputType? type;
  final bool? obscure;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? inputAction;
  final bool fieldTocuhed;
  final EdgeInsets? contentPadding;

  const CustomTextField({
    super.key,
    this.icon,
    required this.inputColor,
    this.placeholder,
    this.label,
    this.labelColor,
    required this.controller,
    this.onChanged,
    this.validator,
    this.height,
    this.borderRadius,
    this.iconSize,
    this.type,
    this.obscure,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.suffixIcon,
    this.suffixFunction,
    this.borderColor,
    this.inputAction,
    this.focusNode,
    this.fieldTocuhed = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Theme(
      data: isDark ? getDarkThemeData() : getLightThemeData(),
      child: TextFormField(
        focusNode: focusNode,
        autovalidateMode:
            fieldTocuhed
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          errorMaxLines: 10,
          errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDark ? Colors.white : Colors.black,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDark ? Colors.white : AppColors.accentColor,
              width: 2.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.5),
          ),
          suffixIcon:
              suffixIcon != null
                  ? InkWell(
                    onTap: suffixFunction,
                    child: Icon(
                      suffixIcon,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  )
                  : null,
          prefixIcon:
              icon != null
                  ? Icon(
                    icon,
                    size: iconSize ?? 20,
                    color: isDark ? Colors.white : Colors.black,
                  )
                  : null,
          labelText: placeholder,
          floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : null,
          ),
        ),
        enabled: enabled ?? true,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscure ?? false,
        controller: controller,
        keyboardType: type,
        minLines: 1,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        textInputAction: inputAction,
      ),
    );
  }
}
