import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';
import 'package:medicinapp/features/authentication/screens/verify_screen/verify_main_screen.dart';
import 'package:medicinapp/utils/validators/validation.dart';

import '../../../common/custom_shape/widgets/snack_bar/snack_bar.dart';
import '../../../utils/constants/colors.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(
    String fullName,
    String email,
    String password,
    String gender,
    String age,
    String language,
    String country,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(), // Fixed variable name
        );
        addUser(fullName, email, language, country, gender, age);
        SnackbarHelper.showSnackbar(
          title: 'Success',
          message: 'You have successfully signed up. Please proceed to login.',
          backgroundColor: TColors.appPrimaryColor,
        );
      } catch (e) {
        SnackbarHelper.showSnackbar(
          title: 'Error',
          message: e.toString(),
          backgroundColor: Colors.red,
        );
      }
    } else {
      SnackbarHelper.showSnackbar(
        title: 'Error',
        message: 'Please fill all inputs',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> addUser(
    String fullName,
    String email,
    String language,
    String country,
    String gender,
    String age,
  ) async {
    await FirebaseFirestore.instance.collection('app_user').doc(email).set({
      'Full Name': fullName,
      'Email': email,
      'Age': age,
      'Gender': gender,
      'Language': language,
      'Country': country,
    });
  }

 Future<void> sendVerificationEmail(
  String fullName,
  String email,
  String password,
  String language,
  String country,
  String gender,
  String age,
  BuildContext context,
) async {
  // Check email format
  if (Validator.isValidEmail(email)) {
    // ActionCodeSettings initialization
    var acs = ActionCodeSettings(
      url: email,
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    // Send verification email
    await FirebaseAuth.instance
        .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
        .then((_) {
      SnackbarHelper.showSnackbar(
        title: 'Success!',
        message:
            'Verification email sent. Please verify your email to complete registration.',
      );
      // Navigate to verification screen
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => VerificationScreen(
              fullName: fullName,
              email: email,
              password: password,
              gender: gender,
              age: age,
              language: language,
              country: country,
              context: context,
            ));
      });
    }).catchError((error) {
      // Handle error
      SnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        backgroundColor: Colors.red,
      );
    });
  } else {
    // Show error message for invalid email format
    SnackbarHelper.showSnackbar(
      title: 'Error',
      message: 'Email is not in correct format',
      backgroundColor: Colors.red,
    );
  }
}

  Future<void> verifyUser(
      String fullName,
      String email,
      String gender,
      String age,
      String language,
      String country,
      String password,
      BuildContext context) async {
    await FirebaseAuth.instance.currentUser!.reload();

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      register(
          fullName, email, password, gender, age, language, country, context);

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => const LogInScreen());
      });
    } else {
      Get.snackbar(
        'Info',
        'Please verify your email to complete registration',
        backgroundColor: Colors.red,
      );
    }
  }
}
