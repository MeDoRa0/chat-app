// login page use bloc
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/pages/signup_page.dart';
import '../constant.dart';
import '../helper/show_snackbar.dart';
import '../widgets/buttons.dart';
import '../widgets/text_field.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  static String signin = "Sign in";
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  //we use authbloc in login page
  Widget build(BuildContext context) {
    //we use blocListener because it ofer excute spacific code dependeng on spacific state
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          //before going to chat page get all messeages from server so when chat page open
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is LogingFailuer) {
          showSnackBar(context, state.erorrMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // we use ListView in page that contain textfield, to avoid screen error when keyboard show up
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  //sizedbox will make an empty container with height to make space between widgets
                  SizedBox(height: 70),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
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
                        "Sign in",
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
                      email = data;
                    },
                    hintText: "enter email",
                  ),
                  SizedBox(height: 30),
                  CustomValidatorTextfield(
                    //this will make password show like this *****
                    obsecuteText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: "enter password",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        //after validate , use blocprovider to performe login for user
                        BlocProvider.of<AuthBloc>(context).add(
                            SighninEvent(email: email!, password: password!));
                      }
                    },
                    textButton: "Sign in",
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " don`t have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      //this code use pushnamed to open sign in page when user click on sign up , it is easier than push
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUp.signup);
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                              color: Color.fromARGB(255, 241, 156, 150)),
                        ),
                      )
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

  Future<void> signinUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
