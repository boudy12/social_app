import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_app/login/login_screen.dart';
import 'package:social_app/shared/Bloc_Observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/styles/Themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(msg: 'on Background Message', state: ToastStates.SUCCESS);
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(msg: 'on Message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(msg: 'on Message Opened App', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  late bool isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  Widget widget ;

    if(uId != null)
    {
      widget = SocialAppLayoutScreen();
    }
    else{
      widget = SocialAppLoginScreen();
    }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    required this.startWidget
  });
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeMode(fromShared: isDark),),
        BlocProvider(create: (context) => SocialAppCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },

      ),
    );
  }
// This widget is the root of your application.

}

