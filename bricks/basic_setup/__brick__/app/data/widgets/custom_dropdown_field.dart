import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.selectedValue,
    required this.onChangeCallback,
    required this.items,
    required this.label,
    this.isMandatory = false,
  });

  final T? selectedValue;
  final Function(T? value) onChangeCallback;
  final List<T> items;
  final String label;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: const Color(0xFF707581),
                          fontSize: 16,
                        ),
                  ),
                  if (isMandatory)
                    Text(
                      '*',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 1.5.h),
        FormField<T>(
          builder: (FormFieldState<T> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                filled: true,
                fillColor: Colors.grey.shade200,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.grey),
                floatingLabelStyle: Theme.of(context).textTheme.headlineMedium,
                // label: widget.label == null ? null : Text(widget.label!),
                // hintText: "widget.hintText",
                hintStyle: Theme.of(context).textTheme.headlineMedium,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFF6F7F9),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // errorText: widget.errorText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFF6F7F9),
                  ),
                ),
              ),
              isEmpty: selectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: selectedValue,
                  isDense: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onChanged: (T? newValue) {
                    onChangeCallback(newValue);
                  },
                  items: items.map((T value) {
                    return DropdownMenuItem<T>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
