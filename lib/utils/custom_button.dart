import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:saad_test/utils/custom_spaces.dart';

import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final Color? color;
  final Color? color2;
  final double? radius;
  final bool isIcon;
  final dynamic icon;
  final Color? textColor;
  final double? textSize;
  final TextStyle? style;
  final dynamic pressed;
  final bool showBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? shadowColor;
  final bool isLoading;
  final bool onlyIcon;
  final Color? loadingColor;
  final bool defaultIcon;
  final Color? iconColor;
  final bool? isIconLeft;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient; // add this

  const CustomButton({
    super.key,
    this.height,
    this.width,
    required this.title,
    this.color,
    this.color2,
    this.radius,
    required this.isIcon,
    this.icon,
    this.textColor,
    this.textSize,
    this.style,
    this.pressed,
    required this.showBorder,
    this.borderColor,
    this.borderWidth,
    this.blurRadius,
    this.spreadRadius,
    this.shadowColor,
    required this.isLoading,
    this.onlyIcon = false,
    this.loadingColor,
    this.defaultIcon = true,
    this.iconColor,
    this.borderRadius,
    this.isIconLeft,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Bounce(
        onPressed: isLoading ? () {} : pressed,
        duration: const Duration(milliseconds: 50),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: height ?? 80,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 15),
            color: gradient == null
                ? color ?? AppColors.primaryColor
                : null, // only use color if gradient is null
            gradient: gradient,
            border: showBorder
                ? Border.all(
                    width: borderWidth ?? 1.0,
                    color: borderColor ?? AppColors.lightGrey,
                  )
                : Border.all(color: AppColors.transparent),
            boxShadow: [
              BoxShadow(
                blurRadius: blurRadius ?? 3,
                spreadRadius: spreadRadius ?? 3,
                offset: const Offset(0, 3),
                color:
                    shadowColor ?? AppColors.blackColor.withValues(alpha: 0.1),
              ),
            ],
          ),
          child: isLoading
              ? Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: loadingColor ?? AppColors.whiteColor,

                    size: 35,
                  ),
                )
              : isIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isIconLeft == true) icon,
                    if (isIconLeft == true) const SpaceW10(),
                    _text(title: title, style: style),
                    if (isIconLeft == false) const SpaceW10(),
                    if (isIconLeft == false) icon,
                  ],
                )
              : onlyIcon
              ? icon
              : Center(
                  child: _text(title: title, style: style),
                ),
        ),
      ),
    );
  }

  Text _text({required String title, required style}) {
    return Text(
      title,
      style:
          style ??
          TextStyle(
            fontSize: textSize ?? 20,
            color: textColor ?? AppColors.whiteColor,
          ),
    );
  }
}
