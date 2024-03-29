import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';

import '../../../common/custom_shape/widgets/snack_bar/snack_bar.dart';
import '../../../utils/constants/colors.dart';
import '../screens/verify_screen/verify_main_screen.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(
      String fullName,
      String email,
      String passsword,
      String conformPassword,
      String gender,
      String age,
      String language,
      String country,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (passsword.trim() == conformPassword.trim()) {
        try {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: passsword.trim(),
          );
          await sendVerificationEmail(userCredential.user!);

          await addUser(
              fullName.trim(), email.trim(), gender, age, language, country);
          SnackbarHelper.showSnackbar(
            title: 'Verify User',
            message: 'Going to Verification page',
            backgroundColor: TColors.appPrimaryColor,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Get.to(() => VerificationScreen());
          });
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
          message: 'Password and confirm password do not match',
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
      'Country': country
    });
  }

  Future<void> sendVerificationEmail(User user) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      print('Verification email sent');
    }
  }

  // Verify User
  Future<void> verifyUser() async {
    // Reload the user data to ensure the latest verification status
    await FirebaseAuth.instance.currentUser!.reload();

    // Check if the email is verified
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      SnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'You have successfully signed up. Please proceed.',
        backgroundColor: TColors.appPrimaryColor,
      );

      // Navigate to the login screen after a delay
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => const LogInScreen());
      });
    } else {
      // User has not verified the email
      Get.snackbar('Info', 'Please verify your email to continue',
          backgroundColor: Colors.red);
    }
  }
}
