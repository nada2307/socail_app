// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/Screens/Login/Cubit/cubit.dart';
import 'package:socail_app/Screens/Login/loginScreen.dart';
import 'package:socail_app/Screens/Register/Cubit/cubit.dart';
import 'package:socail_app/Screens/Register/registerScreen.dart';
import 'package:socail_app/Screens/login1/login_screen.dart';
import 'package:socail_app/cubit/cubit.dart';
import 'package:socail_app/firebase_options.dart';
import 'package:socail_app/phone_auth/phone_auth_cubit.dart';
import 'package:socail_app/shared/bloc_observer.dart';
import 'package:socail_app/shared/components/constants.dart';
import 'package:socail_app/shared/network/local/cache_helper.dart';
import 'package:socail_app/shared/network/remote/dio_helper.dart';
import 'package:socail_app/shared/styles/themes.dart';
import 'Screens/home.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned(
    () {
      RegisterCubit();
      LoginCubit();
      SocialCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget startScreen;

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      startScreen = Login();
    } else {
      startScreen = Home();
    }
  });
  /*uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    startScreen = Home();
  } else {
    startScreen = LoginScreen();
  }*/

//  startScreen = Login();
  runApp(MyApp(isDark, startScreen));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startScreen;

  MyApp(this.isDark, this.startScreen);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
        BlocProvider(
          create: (BuildContext context) => PhoneAuthCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: PhoneScreen(),
          );
        },
      ),
    );
  }
}
