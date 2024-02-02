import 'package:flutter_bloc/flutter_bloc.dart';

//this class to track states in debug consol
class SimpleBlocObserver extends BlocObserver {
  @override
  //work with bloc
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  //work with cubit
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print(change);
  }
}
