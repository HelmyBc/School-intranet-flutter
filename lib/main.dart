import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/views/admin_views/classes/add_classe_screen.dart';
import 'package:enetcom_app/views/admin_views/test_screen.dart';
import 'package:enetcom_app/views/root_app_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Palette.scaffold,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ENETCom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        //primaryColor: const Color(0xFF3EBACE),
        //accentColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: RootAppAnimated(),
    );
  }
}
