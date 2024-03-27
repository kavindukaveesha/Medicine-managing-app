import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class SignUpScreenMain extends StatefulWidget {
  const SignUpScreenMain({super.key});

  @override
  State<SignUpScreenMain> createState() => _SignUpScreenMainState();
}

class _SignUpScreenMainState extends State<SignUpScreenMain> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   TextEditingController _nameController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _passController = TextEditingController();
   TextEditingController _confirmPassController = TextEditingController();


   String _name = "";
   String _email = "";
   String _password = "";
   String _confirmPassword = "";
   //void _handleSignUp();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
          child: Form(
           // key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit_note_outlined),
                  labelText: 'FULL NAME',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please Enter Your Full Name";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'EMAIL',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please Enter Your Email";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _passController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Create Your Password";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _passController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Create Your Password";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _confirmPassController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  labelText: 'CONFIRM PASSWORD',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please Enter Same Password";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
              ),

              SizedBox(height: 20.0),

              ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      //_handleSignUp();
                    }
                  },
                  child: Text(
                      'SignUp'
                  ),
              ),
              SizedBox(height: 20.0),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder()
                ),
                  onPressed: () {},
                  child: Text(
                      'SignUp'
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
