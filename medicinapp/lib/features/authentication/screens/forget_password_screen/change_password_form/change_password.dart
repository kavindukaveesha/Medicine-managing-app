import 'package:flutter/material.dart';


class ChangePasswordFirst extends StatefulWidget {
  const ChangePasswordFirst({super.key});

  @override
  State<ChangePasswordFirst> createState() => _ChangePasswordFirstState();
}

class _ChangePasswordFirstState extends State<ChangePasswordFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Change Your Password',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 35.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 190.0),
                    child: TextButton(
                        onPressed: () {}, child: Text('Try Another Way')),
                  ),
                  SizedBox(height: 55.0),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
