import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/common/custom_shape/widgets/text_inputs/text_input_field.dart';
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import 'package:medicinapp/utils/constants/text_strings.dart';
import 'package:medicinapp/utils/validators/validation.dart';
import '../../../../../utils/constants/mediaQuery.dart';

class MethodEmail extends StatelessWidget {
  const MethodEmail({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    // Function to handle password reset
    Future<void> passwordReset() async {
      String email = _emailController.text.trim();

      // Email validation
      if (!Validator.isValidEmail(email)) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content:
                  Text('Invalid email format. Please enter a valid email.'),
            );
          },
        );
      }
      try {
        // Send password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        SnackbarHelper.showSnackbar(
            title: 'Password Recovery',
            message: 'Password reset link sent. Check your email.');

        // Redirect to login page after 3 seconds
        Timer(const Duration(seconds: 4), () {
          Get.to(() => const LogInScreen());
        });
      } on FirebaseException catch (e) {
        // Show error dialog if FirebaseException occurs
        SnackbarHelper.showSnackbar(
            backgroundColor: Colors.red, title: 'Eoorr', message: e.toString());
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQueryUtils.getHeight(context) * .1),
              // Header text
              Center(
                child: Text(
                  MedTexts.megHeader,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              // Eco image
              Image(
                image: const AssetImage(MediImages.img5),
                height: MediaQueryUtils.getHeight(context) * .3,
              ),
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .005,
              ),
              // Email input field
              InputField(
                prefixIcon: Icons.mail,
                controller: _emailController,
                labelText: 'Enter your email address',
              ),
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .025,
              ),
              // Send code button
              SizedBox(
                width: MediaQueryUtils.getWidth(context) * .9,
                child: ElevatedButton(
                  onPressed: passwordReset,
                  child: const Text(
                    'Send Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
