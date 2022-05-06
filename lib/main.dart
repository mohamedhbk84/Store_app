import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'package:store/shared/style/theme.dart';

import 'shared/network/bloc_observer.dart';
import 'view/splach/splach.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.data.toString());
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAVORW_RyDu2uMWsOa0L47wHQ_sazKq0Cg',
      appId: '1:91785275733:android:7ebc41deaa8116aa0627dc',
      messagingSenderId: '91785275733',
      projectId: 'storeshopping-22586',
      storageBucket: 'storeshopping-22586.appspot.com',

    ),
  );
  EasyLocalization.logger.enableBuildModes = [];
  firebaseToken= (await FirebaseMessaging.instance.getToken())!;
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(
          () {
            runApp(
                EasyLocalization(
                    supportedLocales: [
                      Locale('ar'), Locale('en')],
                    path: 'assets/language',
                    // <-- change the path of the translation files
                    fallbackLocale: Locale('en'),
                    child: const MyApp()));
          },
      blocObserver: MyBlocObserver(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext context)=>ProfileCubit()..getDataShared()..getDataCity()..getDataCity()..getDataRegion(idCity: 0),
    child: BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
      },
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: lightmode,
          darkTheme: darkMode,
          themeMode:ProfileCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
          // ThemeData(
          //   // This is the theme of your application.
          //   //
          //   // Try running your application with "flutter run". You'll see the
          //   // application has a blue toolbar. Then, without quitting the app, try
          //   // changing the primarySwatch below to Colors.green and then invoke
          //   // "hot reload" (press "r" in the console where you ran "flutter run",
          //   // or simply save your changes to "hot reload" in a Flutter IDE).
          //   // Notice that the counter didn't reset back to zero; the application
          //   // is not restarted.
          //   primarySwatch: Colors.blue,
          // ),

          home:const SplashScreen(),

        );
      },
    ),

    );


  }
}


