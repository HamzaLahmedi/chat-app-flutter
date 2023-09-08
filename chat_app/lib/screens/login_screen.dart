import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/Regsiter_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
static String id = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email, password ;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
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
                CustomFormTextField(
                  hintText: 'Email',
                  onChanged: (data){
                    email=data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obsecureText: true,
                  hintText: 'Password',
                  onChanged: (data){
                    password=data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: 'LOGIN',
                  onTap: () async {
                    isLoading=true;
                    setState(() {
                      
                    });
                    try {
                      await loginUser();
                      showSnackBar(context, 'success', Colors.green);
                      Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'user not found', Colors.red);
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context, 'wrong password', Colors.red);
                      }
                    } catch (e) {
                      print(e);
                      showSnackBar(context, 'there is an error', Colors.red);
                    }
                    isLoading=false;
                    setState(() {
                      
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: const Text(
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
        ),
      ),
    );
  }
  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
 
