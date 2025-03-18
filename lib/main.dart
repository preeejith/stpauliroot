import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/bloc/mainbloc.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/services/firebase_options.dart';
import 'package:iroots/services/notification_service.dart';
import 'package:iroots/src/utility/const.dart';

import 'src/ui/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeFirebase();
  NotificationService().initNotification();
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
  ));
  try {
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const MyApp());
}

initializeFirebase() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    print('Initialized default app $app');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (BuildContext context) => MainBloc()),
      ],
      child: GetMaterialApp(
        title: appName,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ConstClass.themeColor,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            // backgroundColor: Colors.blue, // Change this to match your theme
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
