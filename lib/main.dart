import 'package:flutter/material.dart';
//import 'package:flutter_chat/page/home_page.dart';
import 'package:app_festi/page/login.dart';
//import 'package:flutter_chat/page/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: white,
      ),
      home: const Login(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const Login(),
        },
      );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late SharedPreferences sharedPreferences;

  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Festiv'all", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(onPressed: (){
            sharedPreferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
          },
              child: const Text("Log out", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: const Center(child: Text("MainPage")),
      drawer: Drawer(),
    );
  }
}


const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
