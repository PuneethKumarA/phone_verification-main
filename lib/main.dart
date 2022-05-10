import 'package:phone_verification/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:phone_verification/screens/home_screen.dart';
import 'package:phone_verification/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

/*void main( ) {
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.deepPurple
        ),
        debugShowCheckedModeBanner: false,
        home: InitializerWidget());
  }
}
class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {

  FirebaseAuth  _auth;       //removed ? in FirebaseAuth?

  User  _user;        //removed ? in User?

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;      //removed ! after auth!.currentuser
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : _user == null ? LoginScreen() : HomeScreen();
  }
}













// import 'package:phone_verification/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:phone_verification/screens/home_screen.dart';
// import 'package:flutter/services.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(MyApp());
// }
//
// /*void main( ) {
//   runApp(MyApp());
// }*/
// class MyApp extends StatelessWidget {
//
//   static final String title = 'QR Code Scanner';
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter App',
//         theme: ThemeData(
//           primarySwatch: Colors.brown,
//           scaffoldBackgroundColor: Colors.brown[100],
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: InitializerWidget());
//   }
// }
// class InitializerWidget extends StatefulWidget {
//   @override
//   _InitializerWidgetState createState() => _InitializerWidgetState();
// }
//
// class _InitializerWidgetState extends State<InitializerWidget> {
//
//   FirebaseAuth _auth;
//   User _user;
//   bool isLoading = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _auth = FirebaseAuth.instance;
//     _user = _auth.currentUser;
//     isLoading = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading ? Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     ) : _user == null ? LoginScreen() : HomeScreen();
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:phone_verification/screens/home_screen.dart';
// // import 'package:phone_verification/screens/login_screen.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         title: 'Flutter Demo',
// //         theme: ThemeData(
// //           primarySwatch: Colors.brown,
// //           visualDensity: VisualDensity.adaptivePlatformDensity,
// //         ),
// //         debugShowCheckedModeBanner: false,
// //         home: InitializerWidget());
// //   }
// // }
// //
// // class InitializerWidget extends StatefulWidget {
// //   @override
// //   _InitializerWidgetState createState() => _InitializerWidgetState();
// // }
// //
// // class _InitializerWidgetState extends State<InitializerWidget> {
// //
// //   FirebaseAuth _auth;
// //
// //   User _user;
// //
// //   bool isLoading = true;
// //
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _auth = FirebaseAuth.instance;
// //     _user = _auth.currentUser;
// //     isLoading = false;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return isLoading ? Scaffold(
// //       body: Center(
// //         child: CircularProgressIndicator(),
// //       ),
// //     ) : _user == null ? LoginScreen() : HomeScreen();
// //   }
// // }
// //
