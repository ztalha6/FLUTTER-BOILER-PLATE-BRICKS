import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onCompleted;
  const CustomPinCodeField({
    Key? key,
    this.controller,
    this.validator,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      // pastedTextStyle: TextStyle(
      //   color: Colors.black,
      //   fontWeight: FontWeight.bold,
      // ),
      length: 4,
      obscureText: true,
      obscuringCharacter: '*',
      // obscuringWidget: const FlutterLogo(
      //   size: 24,
      // ),
      blinkWhenObscuring: true,
      errorTextSpace: 30,
      animationType: AnimationType.fade,
      validator: validator,
      // validator: (v) {
      //   if (v!.length < 3) {
      //     return "I'm from validator";
      //   } else {
      //     return null;
      //   }
      // },
      cursorHeight: Get.height * 0.002,
      cursorWidth: Get.width * 0.020,
      pinTheme: PinTheme(
        borderWidth: 1,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldWidth: 60,
        inactiveColor: Colors.grey,
        selectedColor: Theme.of(context).primaryColor,
        activeColor: Colors.grey,
        errorBorderColor: Colors.red,
      ),
      cursorColor: Colors.grey,
      animationDuration: const Duration(milliseconds: 300),
      // enableActiveFill: true,
      // errorAnimationController: errorController,
      controller: controller,
      keyboardType: TextInputType.number,
      // boxShadows: const [
      //   BoxShadow(
      //     offset: Offset(0, 1),
      //     color: Colors.black12,
      //     blurRadius: 10,
      //   )
      // ],
      onCompleted: onCompleted,
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        debugPrint(value);
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
