import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isObsecureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool isReadOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final String? initialValue; 

  const MyTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
    this.suffixIcon,
    this.onChanged,
    this.isReadOnly = false,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (initialValue != null && controller.text.isEmpty) {
      controller.text = initialValue!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        TextFormField(
          readOnly: isReadOnly,
          controller: controller,
          keyboardType: keyboardType,
          autofocus: false,
          onTap: onTap,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            hintText: hintText,
            hintStyle: textTheme.titleSmall!.copyWith(color: AppPallete.grey),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          obscureText: isObsecureText,
        ),
      ],
    );
  }
}
