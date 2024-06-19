import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChange,
      this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(color: colors.primary)
    );
    return TextFormField(
        onChanged: onChange,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder:
                border.copyWith(borderSide: BorderSide(color: colors.primary)),
            errorBorder: border.copyWith(
                borderSide: BorderSide(color: Colors.red.shade800)),
            focusedErrorBorder: border.copyWith(
                borderSide: BorderSide(color: Colors.red.shade800)),
            isDense: true,
            label: label != null ? Text(label ?? "") : null,
            hintText: hint,
            errorText: errorMessage,
            focusColor: colors.primary));
  }
}
