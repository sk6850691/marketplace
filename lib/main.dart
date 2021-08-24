import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/AppScreen.dart';
import 'package:marketplace/screens/HomeScreen.dart';
import 'package:marketplace/screens/RegistrationScreen.dart';

import 'package:marketplace/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async{

  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await runApp(


      MultiProvider(providers: [
        ChangeNotifierProvider.value(value: AppProvider.initialize())
      ],child: MyApp(
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenController(),
    );
  }
}
class ScreenController extends StatelessWidget {
  const ScreenController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    switch(appProvider.status){
      case Status.Uninitialised:
        return SplashScreen();
      case Status.Authenticating:
      case Status.Unauthenticated:
        return RegistrationScreen();
      case Status.Authenticated:
        return HomeScreen();

      default:HomeScreen();
    }
  }
}



