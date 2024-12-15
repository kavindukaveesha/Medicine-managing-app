import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/features/authentication/screens/forgot_password_method_screen/method_email_getcode.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

import '../../../../common/custom_shape/widgets/text_inputs/text_input_field.dart';
import '../../controller/sign_in_controller.dart';
import '../sign_up_screen/sign_up_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // this is the two text controllers to get user inputs
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    left: MediaQueryUtils.getHeight(context) * 0.3,
                    child: Container(
                      child: Image.asset(
                        MediImages.img2,
                        height: MediaQueryUtils.getWidth(context) * 0.45,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        InputField(
                          labelText: 'Email',
                          prefixIcon: Icons.mail,
                          borderEnabled: false,
                          controller: emailController,
                        ),
                        InputField(
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          borderEnabled: false,
                          controller: passwordController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => MethodEmail());
                                  },
                                  child: Text('FORGET PASSWORD'),
                                ),
                                SizedBox(
                                  width: MediaQueryUtils.getWidth(context) * .4,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _signInController.signIn(
                                          emailController.text,
                                          passwordController.text); // Corrected
                                    },
                                    child: Text('Login'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 96, 202, 208),
                    ),
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
