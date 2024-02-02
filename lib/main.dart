import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholar_chat/simple_bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Bloc.Observer is insted of onChanged and onTranstion
  //to use blocobserver class we created
  //SimpleBlocObserver class that we created to use onChange and onTransition
  Bloc.observer = SimpleBlocObserver();
  runApp(ScholarChat());
}

//before using bloc observer
//runApp(ScholarChat());

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to make UI deal with login/signup cubit we warp matrialapp blocprovider
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        //to enable pushNamed in signup page code
        routes: {
          SignUp.signup: (context) => SignUp(),
          SignIn.signin: (context) => SignIn(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: SignIn.signin,
      ),
    );
  }
}
