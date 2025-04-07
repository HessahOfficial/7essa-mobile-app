import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color inputColor;
  final Color? iconBackgroundColor;
  final String placeholder;
  final double screenWidth;
  final TextEditingController controller;
  final void Function(String val)? onChanged;
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
    required this.placeholder,
    required this.screenWidth,
    required this.controller,
    this.onChanged,
    this.height,
    this.borderRadius,
    this.iconSize,
    this.type,
    this.obscure,
    this.maxLines,
    this.maxLength
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.screenWidth,
        decoration: BoxDecoration(
          color: widget.inputColor,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        ),
        child: Row(
          children: [
            widget.icon != null ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundColor: widget.iconBackgroundColor,
                radius: widget.borderRadius ?? 20,
                child: Icon(
                  widget.icon,
                  size: widget.iconSize ?? 17,
                  color: widget.iconColor,
                ),
              ),
            ) : Container(),
            Expanded(child: SizedBox(
              width: widget.screenWidth * 0.7,
              child: Expanded(
                  child: TextField(
                    onChanged: widget.onChanged,
                    obscureText: widget.obscure ?? false,
                    controller: widget.controller,
                    keyboardType: widget.type ?? TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(
                        color: Colors.grey, // Replace with your AppColors.gray
                      ),
                    ),
                    minLines: 1,
                    maxLines: widget.maxLines ?? 1,
                    maxLength: widget.maxLength,
                  )
              ),
            )),
          ],
        ),
      ),
    );
  }
}