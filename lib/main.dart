import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/App/cubit.dart';
import 'package:social_app/shared/cubit/App/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';

import 'modules/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget? widget;

  uId = CacheHelper.getData(key: 'uId');



  if(uId != null){
    widget = const HomeScreen();
  }else{
    widget = const LoginScreen();
  }

  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key, this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
          ),
          BlocProvider(
            create: (context) => SocialCubit()..getUserData(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: ThemeMode.light,
                  home: startWidget
              );
            })
    );
  }
}
