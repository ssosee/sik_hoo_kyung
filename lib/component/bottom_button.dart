import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final void Function() onClick;
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;

  const BottomButton({
    super.key,
    required this.onClick,
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
