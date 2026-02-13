import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/constants/colors.dart';
class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final Widget? icon;
  final Color? color;

  const CustomDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.hintText = "Select an option",
    this.icon,
    this.color,
  });

  @override
  State<CustomDropdown<T>> createState() =>
      _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.08,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          
          value: _selectedItem,
          isExpanded: true,
          alignment: Alignment.center,
          icon:
              widget.icon ??
              Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: AppColors.textRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.blackColor,
                ),
              ),

          /// 👇 Centered hint
          hint: Center(
            child: Text(
              "Select an option",
              style: TextStyle(color: widget.color ?? AppColors.textBlueColor),
            ),
          ),

          /// 👇 Centered selected item
          selectedItemBuilder: (context) {
            return widget.items.map((item) {
              return Center(
                child: Text(
                  item.toString(),
                  style: TextStyle(color: widget.color ?? AppColors.textBlueColor,
                  ),
                ),
              );
            }).toList();
          },

          onChanged: (T? value) {
            setState(() => _selectedItem = value);
            widget.onChanged(value);
          },

          items: widget.items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: const TextStyle(color: AppColors.blackColor),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
