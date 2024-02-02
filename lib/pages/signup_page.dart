// signup use cubit
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/pages/login_page.dart';
import '../helper/show_snackbar.dart';
import '../widgets/buttons.dart';
import '../widgets/text_field.dart';

class SignUp extends StatelessWidget {
  static String signup = "Sign up";
  String? username;

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  //we use authcubit in signup page
  Widget build(BuildContext context) {
    //this will show loading screen while signup proccessing
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is SignupFailuer) {
          showSnackBar(context, state.erorrMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 70),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scholar Chat",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'Pacifico-Regular',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    CustomValidatorTextfield(
                      onChanged: (data) {
                        username = data;
                      },
                      hintText: "enter username",
                    ),
                    SizedBox(height: 30),
                    CustomValidatorTextfield(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: "enter email",
                    ),
                    SizedBox(height: 30),
                    CustomValidatorTextfield(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: "enter password",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      //this code will vaildate user input
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          //activate isloading
                          isLoading = true;
                          //after validate , use blocprovider to performe signup for user
                          BlocProvider.of<AuthCubit>(context)
                              .signupUser(email: email!, password: password!);
                        }
                      },
                      textButton: "Sign up",
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " already have an account?  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        //this code use pop to back to previous screen "sign in"
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, SignIn());
                          },
                          child: Text(
                            " Sign in",
                            style: TextStyle(
                              color: Color.fromARGB(255, 241, 156, 150),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//these codes are refactored to use in try and catch

  Future<void> signupUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
