import 'package:flutter/material.dart';

class CompanyCustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color btnColor;
  final VoidCallback onPressed;

  const CompanyCustomButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.btnColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Makes the button full width
      height: 45, // Ensures a height between 30-45
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor, // Button text color
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
