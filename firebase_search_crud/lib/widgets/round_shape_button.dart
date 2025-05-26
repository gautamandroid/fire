import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundShapeButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onTap;
  final Size size;
  final bool isLoading;
  final double? textSize;
  final Widget? titleWidget;

  const RoundShapeButton({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
    this.textSize,
    this.isLoading = false,
    this.titleWidget,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(size),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>
          (RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: buttonColor))),
      ),
      onPressed: onTap,
      child: !isLoading  ?
      Text(title, style:
          GoogleFonts.inter(fontSize: textSize ?? 16)
      // TextStyle(fontFamily: FontFamily.medium, fontSize: textSize ?? 16,
      //     fontWeight: FontWeight.w600, color: buttonTextColor),
      )
        :  const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    );
  }
}
