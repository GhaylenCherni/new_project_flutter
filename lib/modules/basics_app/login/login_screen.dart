import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

// reusible componennts :
// 1. timing
// 2. quality
// 3. refactor

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailcontroller,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be Empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    label: 'Password',
                    prefix: Icons.lock,
                    type: TextInputType.visiblePassword,
                    suffix:
                        isPassword ? Icons.visibility_off : Icons.visibility,
                    isPassword: isPassword,
                    suffixpressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailcontroller);
                        print(passwordController);
                      }
                    },
                    text: 'login',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      print(emailcontroller);
                      print(passwordController);
                    },
                    text: 'ReGisTer',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Registre Now',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
