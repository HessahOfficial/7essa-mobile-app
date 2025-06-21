import 'package:flutter/material.dart';
import 'package:hessa/core/widgets/custom_button.dart';

class CustomInfoPopup extends StatelessWidget {
  final IconData icon;
  final String message;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final String? textButton;

  const CustomInfoPopup({
    super.key,
    required this.icon,
    required this.message,
    this.onPressed,
    this.width,
    this.height,
    this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        width: width ?? 200,
        height: height ?? 150,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed != null
                ? CustomButton(
                  width: 100,
                  height: 40,
                  onPressed: onPressed,
                  text: textButton ?? "Send",
                  textColor: Colors.white,
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
