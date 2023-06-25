import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_widget.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isLoading;
  final bool isDisabled;
  final Widget? otherWidget;
  final Widget? leadingWidget;
  final double? fontSize;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonHeight;
  final double? buttonWidth;
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.fontSize,
    this.otherWidget,
    this.buttonColor,
    this.textStyle,
    this.buttonHeight = 50,
    this.borderColor,
    this.leadingWidget,
    this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: !isDisabled && !isLoading ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 60,
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.020),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isDisabled || isLoading
                ? Theme.of(context).primaryColor.withOpacity(0.4)
                : buttonColor ?? Theme.of(context).primaryColor,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: LoadingWidget(),
                )
              : Stack(
                  children: [
                    Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          leadingWidget ?? const SizedBox.shrink(),
                          if (leadingWidget != null)
                            const SizedBox(width: 10)
                          else
                            const SizedBox.shrink(),
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: isDisabled
                                ? Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .textStyle!
                                    .resolve(
                                    {MaterialState.selected},
                                  )!.copyWith(
                                    color: Colors.black38,
                                    fontSize: fontSize ?? 16,
                                  )
                                : textStyle ??
                                    Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .textStyle!
                                        .resolve(
                                      {MaterialState.selected},
                                    )!.copyWith(
                                      color: Colors.black38,
                                      fontSize: fontSize ?? 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    otherWidget ?? const SizedBox()
                  ],
                ),
        ),
      ),
    );
  }
}
