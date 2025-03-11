import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color inputColor;
  final Color iconBackgroundColor;
  final String placeholder;
  final double screenWidth;
  final TextEditingController controller;
  final void Function(String val)? onChanged;
  final double? height;
  final double? borderRadius;
  final double? iconSize;
  final TextInputType? type;
  final bool? obscure;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.inputColor,
    required this.iconBackgroundColor,
    required this.placeholder,
    required this.screenWidth,
    required this.controller,
    this.onChanged,
    this.height,
    this.borderRadius,
    this.iconSize,
    this.type,
    this.obscure,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth,
      height: widget.height ?? 60,
      decoration: BoxDecoration(
        color: widget.inputColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
      ),
      child: Row(
        children: [
          Padding(
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
          ),
          SizedBox(
            width: widget.screenWidth * 0.7,
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
            ),
          ),
        ],
      ),
    );
  }
}