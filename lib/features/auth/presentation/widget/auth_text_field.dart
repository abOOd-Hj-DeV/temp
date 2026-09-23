import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController? controller;
  final bool obscureText;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.controller,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppFonts.tajawalMedium16.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        CustomCard(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(
            bottom: AppSizes.lgPadding,
            top: AppSizes.smPadding,
          ),
          borderRadius: BorderRadius.circular(AppSizes.slRadius),
          child: TextFormField(
            cursorColor: AppColors.primary,
            controller: widget.controller,
            obscureText: _obscureText,
            maxLines: widget.maxLines,
            validator: widget.validator,
            textAlign: TextAlign.right,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppFonts.tajawalRegular16.copyWith(
                color: AppColors.greyAA,
              ),
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: AppColors.greyAA,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        color: AppColors.greyAA,
                      ),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.greyAA,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.mdPadding,
                vertical: AppSizes.mdPadding,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
