import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../pages/screens/home_page/home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulating a delay for splash screen
    Future.delayed(Duration(seconds: 3), () async {
      // Check if the user is logged in or not using Firebase Auth
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If user is logged in, navigate to home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        // If user is not logged in, navigate to login screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LogInScreen(),
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              MediImages.img1,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
