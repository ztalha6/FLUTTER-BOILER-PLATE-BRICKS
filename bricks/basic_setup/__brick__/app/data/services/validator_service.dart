import 'package:get/get.dart';

class Validator {
  static final Validator _singleton = Validator._internal();

  factory Validator() {
    return _singleton;
  }

  Validator._internal();
  //  String? validateEmployeeID(String employeeID) {
  //   if (employeeID.isEmpty) {
  //     return 'Please enter Employee ID KE';
  //   }
  //   return null;
  // }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter Password';
    }
    if (GetUtils.isLengthGreaterThan(password, 8)) {
      return 'Password length should be atleast 8 characters';
    }
    return null;
  }

  String? validateFullname(String fullname) {
    if (fullname.isEmpty) {
      return 'Please enter Full Name';
    }
    return null;
  }

  List<String?> validatePasswords(
    String password,
    String confirmPassword, {
    bool withOldPassword = false,
    String? oldPassword,
  }) {
    if (withOldPassword) {
      if (oldPassword != null && oldPassword.isEmpty) {
        return ['Please enter Password', null, null];
      }
      if (oldPassword!.length < 8) {
        return ['Password length should be atleast 8 characters', null, null];
      }
      if (password.isEmpty) {
        return [null, 'Please enter Password', null];
      }
      if (confirmPassword.isEmpty) {
        return [null, null, 'Please confirm password'];
      }
      if (password.length < 8) {
        return [null, 'Password length should be atleast 8 characters', null];
      }
      if (password != confirmPassword) {
        return [null, 'Passwords do not match', 'Passwords do not match'];
      }
      return [null, null, null];
    }
    if (password.isEmpty) {
      return ['Please enter Password', null];
    }
    if (confirmPassword.isEmpty) {
      return [null, 'Please confirm password'];
    }
    if (password.length < 8) {
      return ['Password length should be atleast 8 characters', null];
    }
    if (password != confirmPassword) {
      return ['Passwords do not match', 'Passwords do not match'];
    }
    return [null, null];
  }

  //  String? validateCNIC(String cnic) {
  //   if (cnic.isEmpty) {
  //     return 'Please enter CNIC Number';
  //   }
  //   if (cnic.length < 13) {
  //     return 'Invalid CNIC Number';
  //   }
  //   return null;
  // }

  String? validatePhoneNumber(String mobile) {
    if (mobile.isEmpty) {
      return 'Please enter Mobile Number';
    }
    if (mobile.length < 10) {
      return 'Invalid Mobile Number';
    }
    return null;
  }

  /* 
  If the email address is empty, return an error message. If the email address is not empty, check if
  it is a valid email address. If it is a valid email address, return null. If it is not a valid
  email address, return an error message. 
  This validatation is checked according to Env. of application.
  
  Args:
    emailAddress (String): The email address to validate.
  
  Returns:
    A string. 
  */
  String? validateEmail(String emailAddress) {
    if (emailAddress.isEmpty) {
      return 'Please enter Email Address';
    }
    bool emailValid;

    emailValid = GetUtils.isEmail(emailAddress);
    if (!emailValid) {
      return 'Please enter valid Email Address';
    }
    return null;
  }

  //  String? validateLocation(String location) {
  //   if (location.isEmpty) {
  //     return 'Please select Location';
  //   }
  //   return null;
  // }

  //  String? validatePost(String post) {
  //   if (post.isEmpty) {
  //     return 'Please enter Post text';
  //   }
  //   return null;
  // }

  //  String? validateOldPassword(String oldPassword, String actual) {
  //   if (oldPassword.isEmpty) {
  //     return 'Please enter old password';
  //   }
  //   if (actual != oldPassword) {
  //     return 'Invalid old password';
  //   }
  //   return null;
  // }

  //  String? validateDescription(String description) {
  //   if (description.isEmpty) {
  //     return 'Please enter Description text';
  //   }
  //   return null;
  // }
}

// class Mask {
//    MaskTextInputFormatter cnicMaskFormatter = MaskTextInputFormatter(
//     mask: '#####-#######-#',
//     filter: {"#": RegExp(r'[0-9]')},
//   );
//    MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
//     mask: '###-#######',
//     filter: {"#": RegExp(r'[0-9]')},
//   );

//   String getMaskedCNIC(String cnic) {
//     return cnicMaskFormatter.maskText(cnic).replaceRange(3, 12, "*********");
//   }

//   String getMaskedEmail(String email) {
//     return email.replaceRange(0, email.indexOf("@") - 3, "*****");
//   }

//   String getMaskedPhone(String phone) {
//     return phoneMaskFormatter.maskText(phone).replaceRange(3, 8, "*****");
//   }
// }
