import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color inputColor;
  final Color? iconBackgroundColor;
  final String? placeholder;
  final String? label;
  final Color? labelColor;
  final double screenWidth;
  final TextEditingController controller;
  final void Function(String val)? onChanged;
  final String? Function(String?)? validator;
  final double? height;
  final double? borderRadius;
  final double? iconSize;
  final TextInputType? type;
  final bool? obscure;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    this.icon,
    this.iconColor,
    required this.inputColor,
    this.iconBackgroundColor,
    this.placeholder,
    this.label,
    this.labelColor,
    required this.screenWidth,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(borderRadius ?? 20),
      shadowColor: AppColors.gray,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: inputColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        child: Row(
          children: [
            icon != null
                ? Padding(
                  padding: EdgeInsets.only(
                    left: isArabic() ? 0 : 10,
                    right: isArabic() ? 10 : 0,
                  ),
                  child: CircleAvatar(
                    backgroundColor: iconBackgroundColor,
                    radius: borderRadius ?? 20,
                    child: Icon(icon, size: iconSize ?? 17, color: iconColor),
                  ),
                )
                : Container(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: validator,
                      onChanged: onChanged,
                      obscureText: obscure ?? false,
                      controller: controller,
                      keyboardType: type ?? TextInputType.text,
                      decoration:
                          placeholder != null
                              ? InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: placeholder ?? "",
                                hintStyle: const TextStyle(
                                  color:
                                      Colors
                                          .grey, // Replace with your AppColors.gray
                                ),
                              )
                              : InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: labelColor ?? Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadius ?? 20,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                labelText: label ?? "",
                                labelStyle: TextStyle(
                                  color:
                                      labelColor ??
                                      Colors
                                          .grey, // Replace with your AppColors.gray
                                ),
                              ),
                      minLines: 1,
                      maxLines: maxLines ?? 1,
                      maxLength: maxLength,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(
                          context,
                        ).nextFocus(); // Manually move to next field
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
