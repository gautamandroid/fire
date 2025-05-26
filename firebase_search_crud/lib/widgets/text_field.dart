import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme_data.dart';

  class CustomTextFormField extends StatelessWidget {
  final String? title;
  final String hintText;
  final validator;
  bool? obscureText = false;
  Color? color;
  final int? line;
  final TextEditingController controller;
  final Function() onPress;
  final Widget? prefix;
  final Widget? suffix;
  final bool? enable;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Function(String)? onChanged;

  CustomTextFormField({
    super.key,
    this.textInputType,
    this.validator,
    this.enable,
    this.prefix,
    this.suffix,
    this.obscureText,
    this.title,
    required this.hintText,
    required this.controller,
    required this.onPress,
    this.enabled,
    this.readOnly,
    this.color,
    this.line,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: validator ?? (value) => value != null && value.isNotEmpty ? null : 'This field required',
            keyboardType: textInputType ?? TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            textAlign: TextAlign.start,
            enabled: enabled,
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            maxLines: line ?? 1,
            textAlignVertical: TextAlignVertical.top,
            onChanged: onChanged,
            style: GoogleFonts.inter(fontSize: 14, color: AppThemeData.grey800,
                fontWeight: FontWeight.w400),
            decoration:
            prefix != null
                ? InputDecoration(
              errorStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
              // const TextStyle(fontFamily: FontFamily.regular),
              isDense: true,
              filled: true,
              enabled: enable ?? true,
              fillColor: AppThemeData.grey50,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              prefix: Padding(padding: EdgeInsets.only(right: 12), child: prefix!),
              suffixIcon:
              Padding(padding: EdgeInsets.all(suffix != null ? 12 : 0), child: suffix),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.danger300, width: 1)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.primary300, width: 1)),
              hintText: hintText,
              labelText: title!,
              labelStyle: GoogleFonts.inter(fontSize: 14, color: AppThemeData.grey800),
              hintStyle: GoogleFonts.inter(fontSize: 14, color: AppThemeData.grey600),
            )
                : InputDecoration(
              errorStyle: GoogleFonts.inter(fontSize: 14),
              // const TextStyle(fontFamily: FontFamily.regular),
              isDense: true,
              filled: true,
              enabled: enable ?? true,
              fillColor: AppThemeData.grey50,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              suffixIcon   : Padding(padding: EdgeInsets.all(suffix != null ? 12 : 0),
                  child: suffix),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppThemeData.danger300, width: 1)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppThemeData.grey400, width: 1)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppThemeData.primary300, width: 1)),
              hintText: hintText,
              labelText: title!,
              labelStyle: GoogleFonts.inter(fontSize: 14, color: AppThemeData.grey800),
              hintStyle: GoogleFonts.inter(fontSize: 14, color: AppThemeData.grey600),
            ),
          ),
        ],
      ),
    );
  }
}
