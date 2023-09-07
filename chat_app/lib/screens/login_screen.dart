import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/Regsiter_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset('assets/images/scholar.png'),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'pacifico',
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            const Row(
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
             CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
             CustomTextField(
              hintText: 'Password',
            ),
            const SizedBox(
              height: 20,
            ),
             CustomButton(buttonText: 'LOGIN'),
            const SizedBox(
              height: 10,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const  Text(
                  "don't have an account ?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child:const Text(
                    " Register",
                    style: TextStyle(
                      color: Color(0xffC7EDE6),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
