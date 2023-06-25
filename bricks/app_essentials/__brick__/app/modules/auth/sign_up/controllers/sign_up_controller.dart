import 'package:app_essentials/app/data/config/app_configuration.dart';
import 'package:app_essentials/app/data/model/sign_up/sign_in_request_model.dart';
import 'package:app_essentials/app/data/repositories/auth_repository.dart';
import 'package:app_essentials/app/data/services/validator_service.dart';
import 'package:app_essentials/app/data/utils/utils.dart';
import 'package:app_essentials/core/env/env_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  Configuration configs = Configuration();
  Validator validator = Validator();
  Rxn<MemoryImage> image = Rxn<MemoryImage>();
  Configuration configuration = Configuration();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Rxn<PhoneNumber> phone = Rxn<PhoneNumber>();

  RxnString emailErrorText = RxnString();
  RxnString passwordErrorText = RxnString();
  RxnString firstNameErrorText = RxnString();
  RxnString lastNameErrorText = RxnString();
  RxnString phoneErrorText = RxnString();
  RxnString dobErrorText = RxnString();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Environment.currentEnv.prefillForms) {
      emailController.text = 'talha.siddique@tekrevol.com';
      passwordController.text = '12345678';
      firstnameController.text = 'Muhammad Talha';
      lastnameController.text = 'Siddique';
    }
    super.onInit();
  }

  Future<void> onSignInTap() async {
    Utils().clearKeyboardFocus();
    final bool isValid = checkForError();
    if (!isValid) return;
    isLoading.value = true;
    if (await AuthRepository().signUp(
      SignUpRequest(
        fullName: firstnameController.text,
        phone: "${phone.value!.dialCode}${phoneController.text}",
        email: emailController.text,
        password: passwordController.text,
      ),
    )) {
      Get.toNamed(
        Routes.VERIFY_OTP,
        arguments: [true, false, emailController.text],
      );
      clearFields();
    }
    isLoading.value = false;
  }

  bool checkForError() {
    emailErrorText.value = null;
    passwordErrorText.value = null;
    firstNameErrorText.value = null;
    emailErrorText.value = validator.validateEmail(emailController.text);
    passwordErrorText.value =
        validator.validatePassword(passwordController.text);
    firstNameErrorText.value =
        validator.validateFullname(firstnameController.text);
    phoneErrorText.value = validator.validatePhoneNumber(phoneController.text);

    return emailErrorText.value == null &&
        passwordErrorText.value == null &&
        firstNameErrorText.value == null &&
        phoneErrorText.value == null;
  }

  void clearFields() {
    emailController.text = '';
    firstnameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
  }

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> onChangePhotoTapped({bool camera = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        // androidUiSettings: AndroidUiSettings(
        //     toolbarColor: AppTheme.orange,
        //     toolbarWidgetColor: Colors.white,
        //     initAspectRatio: CropAspectRatioPreset.original,
        //     lockAspectRatio: false),
        // iosUiSettings: const IOSUiSettings(
        //   minimumAspectRatio: 1.0,
        // ),
      );
      if (croppedFile != null) {
        image = XFile(croppedFile.path);
      }
      this.image.value = MemoryImage(await image.readAsBytes());
    }
  }
}
