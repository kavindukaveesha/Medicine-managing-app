import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../controller/sign_up_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    Key? key, // Added Key? for proper initialization
    required this.fullName,
    required this.email,
    required this.gender,
    required this.age,
    required this.language,
    required this.country,
    required this.password,
    required this.context,
  }) : super(key: key); // Fixed super call

  final String fullName;
  final String email;
  final String password;
  final String gender;
  final String age;
  final String language;
  final String country;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              // Do nothing on back button press
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: MediaQueryUtils.getHeight(context) * .05),
                Center(
                  child: Text(
                    MedTexts.vryHeader,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(height: MediaQueryUtils.getHeight(context) * .1),
                Image(
                  image: const AssetImage(MediImages.img4),
                  height: MediaQueryUtils.getHeight(context) * .3,
                ),

                // Start login form
                SizedBox(height: MediaQueryUtils.getHeight(context) * .1),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MedTexts.vryInboxEmail,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                          height: MediaQueryUtils.getHeight(context) * .02),
                      Row(
                        children: [
                          Text(MedTexts.vryCheckEmail,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                          Text(MedTexts.vryCheckEmail2,
                              style: Theme.of(context).textTheme.bodyLarge!),
                        ],
                      ),
                      SizedBox(
                          height: MediaQueryUtils.getHeight(context) * .01),
                    ],
                  ),
                ),
                SizedBox(height: MediaQueryUtils.getHeight(context) * .02),
                SizedBox(
                  width: MediaQueryUtils.getWidth(context) * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.verifyUser(fullName, email, gender, age,
                          language, country, password, context);
                    },
                    child: const Text(
                      'Continue',
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
      ),
    );
  }
}
