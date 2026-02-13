import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:saad_test/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final Color? fieldColor;
  final dynamic prefixIcon;
  final Color? prefixIconColor;
  final dynamic suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FocusNode? focusnode;
  final int? maxLine;
  final String hintText;
  final String? labelText;
  final String? errorText;
  final dynamic onChanged;
  final dynamic validator;
  final bool? readOnly;
  final Color? inputTextColor;
  final bool? obscureText;
  final dynamic onComplete;
  final dynamic contentPadding;
  final double? fontSize;
  final FontWeight? fontweight;
  final dynamic textAlign;
  final Color? borderColor;
  final Color? hintColor;
  final double? radius;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Function()? onTap;
  final bool? enableInteractiveSelection;
  final bool showCustomPrefixIcon;
  final dynamic customPrefixIcon;
  final double? borderWidth;

  const CustomTextField({
    super.key,
    this.height,
    this.width,
    this.controller,
    this.fieldColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.inputType,
    this.maxLine,
    required this.hintText,
    this.labelText,
    this.errorText,
    this.onChanged,
    this.validator,
    this.readOnly,
    this.inputTextColor,
    this.inputAction,
    this.focusnode,
    this.obscureText,
    this.onComplete,
    this.contentPadding,
    this.fontSize,
    this.fontweight,
    this.textAlign,
    this.borderColor,
    this.hintColor,
    this.radius,
    this.inputFormatters,
    this.maxLength,
    this.onTap,
    this.enableInteractiveSelection,
    this.showCustomPrefixIcon = false,
    this.customPrefixIcon,
    this.borderWidth,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width ?? double.maxFinite,
            height: height,
            child: TextFormField(
              obscureText: obscureText ?? false,
              readOnly: readOnly ?? false,
              controller: controller,
              focusNode: focusnode,
              maxLines: maxLine,
              textInputAction: inputAction,
              maxLength: maxLength,
              autocorrect: true,
              textAlign: textAlign ?? TextAlign.left,
              keyboardType: inputType,
              inputFormatters: inputFormatters,
              style: TextStyle(
                fontFamily: 'PolySans',
                color: inputTextColor ?? AppColors.themeText,
                fontSize: fontSize ?? 16,
                fontWeight: fontweight ?? FontWeight.w400,
              ),
              onTap: onTap ?? () {},
              enableInteractiveSelection: enableInteractiveSelection ?? true,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: contentPadding ?? const EdgeInsets.all(20),
                fillColor: fieldColor ?? AppColors.whiteColor,
                filled: true,
                prefixIcon: showCustomPrefixIcon
                    ? customPrefixIcon
                    : Icon(
                        prefixIcon,
                        color: AppColors.unSelectedColor,
                        size: 20,
                      ),
                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintColor ?? AppColors.themeTextLight,
                  fontSize: fontSize,
                ),
                errorText: errorText,
                errorStyle: const TextStyle(
                  fontFamily: 'PolySans',
                  color: AppColors.textRed,
                  fontSize: 0,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(
                    width: borderWidth ?? 0.1,
                    color: AppColors.textRed,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(
                    width: borderWidth ?? 0.1,
                    color: AppColors.textRed,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(
                    width: borderWidth ?? 0.1,
                    color: borderColor ?? AppColors.buttonlinearYellowColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: BorderSide(
                    width: borderWidth ?? 0.1,
                    color: borderColor ?? AppColors.textGrey,
                  ),
                ),
              ),
              onChanged: onChanged,
              validator: validator,
              onEditingComplete: onComplete,
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10),
              child: Text(
                errorText!,
                style: TextStyle(color: AppColors.textRed),
              ),
            ),
        ],
      ),
    );
  }
}
