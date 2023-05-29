
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'homepage.dart';


void main() {
  SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Color.fromARGB(255, 36, 36, 36),
    systemNavigationBarDividerColor: Colors.black,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const calsi());
}


class calsi extends StatefulWidget {
  const calsi({super.key});

  @override
  State<calsi> createState() => _calsiState();
}

class _calsiState extends State<calsi> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420,933),
      builder: (context , child){
        return  MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(31, 25, 25, 25)),
        // theme: ThemeData(
        //   useMaterial3: true,
        //   brightness: Brightness.dark,
        // ),
        home: homepage(),
      );
      } 
    );
  }
}
