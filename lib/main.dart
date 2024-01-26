import 'package:enebla_new/bloc/auth/auth_bloc.dart';
import 'package:enebla_new/pages/Onboarding.dart';
import 'package:enebla_new/pages/home/enebla_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic isViewed = prefs.get('onboarding');

  runApp(MultiBlocProvider(
    providers: [BlocProvider<AuthBloc>(create: (context) => AuthBloc())],
    child: EneblaApp(
      isViewed: isViewed,
    ),
  ));
}

class EneblaApp extends StatelessWidget {
  final isViewed;
  const EneblaApp({super.key, required this.isViewed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isViewed != 0 ? const OnBording() : const EneblaHome(),
    );
  }
}
