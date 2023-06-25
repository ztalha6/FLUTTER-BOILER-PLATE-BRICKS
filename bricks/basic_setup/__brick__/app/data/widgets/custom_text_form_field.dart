import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.onDone,
    this.onEditingComplete,
    this.errorText,
    this.controller,
    this.cursorColor,
    this.reduceContentPadding = false,
    this.perfixIcon,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.inputFormatters,
    this.label,
    this.enabled = true,
    this.isMandatory = false,
    this.suffixIcon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final String? hintText;
  bool? obscureText;
  final Function(String val)? onChanged;
  final Function(String val)? onDone;
  final Function()? onEditingComplete;
  final Function(String?)? onSaved;
  final String? errorText;
  final TextEditingController? controller;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final int maxLines;
  final String? label;
  final bool enabled;
  final bool reduceContentPadding;
  final bool isMandatory;
  final Widget? suffixIcon;
  final Widget? perfixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool? obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      widget.label!,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: widget.errorText != null
                                    ? Colors.red
                                    : const Color(0xFF707581),
                                fontSize: 16,
                              ),
                    ),
                    if (widget.isMandatory)
                      Text(
                        '*',
                        style: TextStyle(
                          color: widget.errorText != null
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(height: 1.5.h),
        TextFormField(
          enabled: widget.enabled,
          validator: widget.validator,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 16, color: Colors.black),
          onChanged: widget.onChanged,
          obscureText: obscureText ?? false,
          onEditingComplete: widget.onEditingComplete,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onDone,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          onSaved: widget.onSaved,
          decoration: InputDecoration(
            contentPadding:
                widget.reduceContentPadding ? EdgeInsets.zero : null,
            filled: true,
            fillColor: widget.errorText != null
                ? Colors.red.withOpacity(0.1)
                : Colors.grey.shade200,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.grey),
            floatingLabelStyle: Theme.of(context).textTheme.headlineMedium,
            // label: widget.label == null ? null : Text(widget.label!),
            hintText: widget.hintText,
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
            errorText: widget.errorText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Color(0xFFF6F7F9),
              ),
            ),

            /* For showing choice chips in textfield */

            // prefixIcon: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ChoiceChip(label: Text('label'), selected: false),
            //     ChoiceChip(label: Text('label'), selected: false)
            //   ],
            // ),
            prefixIcon: widget.perfixIcon,
            suffixIcon: widget.suffixIcon ??
                (obscureText != null
                    ? GestureDetector(
                        onTap: () {
                          obscureText = !obscureText!;
                          setState(() {});
                        },
                        child: Icon(
                          obscureText!
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 3.h,
                        ),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
