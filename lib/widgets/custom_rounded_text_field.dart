import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable, minimalist rounded text field matching the clean reference design.
class CustomRoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool enabled;

  const CustomRoundedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFEDEEF2),
          width: 1.0,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        enabled: enabled,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        style: const TextStyle(
          color: AppColor.textDark,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB0B7C3),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColor.primaryDark,
              width: 1.2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColor.primaryDark,
              width: 1.5,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: AppColor.primaryDark,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
