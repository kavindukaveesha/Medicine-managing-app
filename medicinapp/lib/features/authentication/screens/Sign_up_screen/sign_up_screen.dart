import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/features/authentication/controller/sign_up_controller.dart';
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';
import 'package:medicinapp/utils/constants/colors.dart';
import 'package:medicinapp/utils/validators/validation.dart';

import '../../../../common/custom_shape/widgets/text_inputs/text_input_field.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/mediaQuery.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    conformpasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Image.asset(
              MediImages.img3,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              'MediMate',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: MediaQueryUtils.getHeight(context) * 0.32,
                    child: Container(
                      child: Image.asset(
                        MediImages.img1,
                        height: MediaQueryUtils.getWidth(context) * 0.3,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Form(
                        key: _signUpController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15),
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Please sign up to continue',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            InputField(
                              labelText: 'Full Name',
                              prefixIcon: Icons.person,
                              borderEnabled: false,
                              controller: nameController,
                              validator: Validator.validFullName,
                            ),
                            InputField(
                              labelText: 'Email',
                              prefixIcon: Icons.mail,
                              borderEnabled: false,
                              controller: emailController,
                              validator: Validator.validateEmail,
                            ),
                            InputField(
                              labelText: 'Password',
                              prefixIcon: Icons.lock,
                              borderEnabled: false,
                              controller: passwordController,
                              validator: Validator.validatePassword,
                            ),
                            InputField(
                              controller: conformpasswordController,
                              labelText: 'Comform Password',
                              prefixIcon: Icons.lock,
                              borderEnabled: false,
                              validator: Validator.validatePassword,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQueryUtils.getWidth(context) * .4,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _signUpController.register(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          conformpasswordController.text,
                                          '',
                                          '',
                                          '',
                                          '',
                                          context);
                                    },
                                    child: Text('SignUp'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => LogInScreen());
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TColors.appPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
