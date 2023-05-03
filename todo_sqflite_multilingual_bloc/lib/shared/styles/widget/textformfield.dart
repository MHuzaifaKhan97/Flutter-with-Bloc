import 'package:flutter/material.dart';

Widget CustomTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required ValueChanged<String>? onFieldSubmitted,
  required FormFieldValidator<String>? validator,
  required String labelText,
  required String hintText,
  required IconData prefixIcon,
  GestureTapCallback? onTap,
  int? maxLines,
}) =>
    TextFormField(
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        isDense: true,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
