import 'package:phone_verification/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_home_page.dart';
import '../qr_scan/qr_create.dart';
import '../qr_scan/qr_scan.dart';
import 'login_screen.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Stay for the Taste',style: TextStyle(letterSpacing: 4)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: MyHomePage(),
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                icon: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 35,
                )
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
                },
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 35,
                )
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreatePage()));
                },
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 35,
                )
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen())  , (route) => false);
                  logout(context);
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 35,
                )
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[100],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
        },
        child: ImageIcon(
          AssetImage('images/coffee_bean.png'),
          size: 150,
          color: Colors.brown[800],
        ),
      ),*/
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}













//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../widgets/my_home_page.dart';
// import '../qr_scan/qr_create.dart';
// import '../qr_scan/qr_scan.dart';
// import 'login_screen.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         title: Text('Stay for the Taste',style: TextStyle(letterSpacing: 4)),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: MyHomePage(),
//       ),
//
//       bottomNavigationBar: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.deepPurple,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//                 enableFeedback: false,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreatePage()));
//                 },
//                 icon: Icon(
//                   Icons.person_pin,
//                   color: Colors.white,
//                   size: 35,
//                 )
//             ),
//             IconButton(
//                 enableFeedback: false,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
//                 },
//                 icon: Icon(
//                   Icons.qr_code,
//                   color: Colors.white,
//                   size: 35,
//                 )
//             ),
//             IconButton(
//                 enableFeedback: false,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreatePage()));
//                 },
//                 icon: Icon(
//                   Icons.qr_code_scanner,
//                   color: Colors.white,
//                   size: 35,
//                 )
//             ),
//             IconButton(
//                 enableFeedback: false,
//                 onPressed: () {
//                   //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen())  , (route) => false);
//                   logout(context);
//                 },
//                 icon: Icon(
//                   Icons.logout_rounded,
//                   color: Colors.white,
//                   size: 35,
//                 )
//             ),
//           ],
//         ),
//       ),
//       /*floatingActionButton: FloatingActionButton(               //commented from here
//         backgroundColor: Colors.brown[100],
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
//         },
//         child: ImageIcon(
//           AssetImage('Images/coffee_bean.png'),
//           size: 150,
//           color: Colors.brown[800],
//         ),
//       ),  */                   // commented till here
//     );
//   }
//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginScreen()));
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
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:phone_verification/screens/login_screen.dart';
// // import 'package:phone_verification/widgets/my_home_page.dart';
// //
// // import '../qr_scan/qr_create.dart';
// // import '../qr_scan/qr_scan.dart';
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //
// //   final _auth = FirebaseAuth.instance;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: MyHomePage(title:'know your coffee'),
// //       ),
// //       bottomNavigationBar: Container(
// //         height: 60,
// //         decoration: BoxDecoration(
// //           color: Colors.brown[700],
// //           borderRadius: const BorderRadius.only(
// //             topLeft: Radius.circular(20),
// //             topRight: Radius.circular(20),
// //           ),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //           children: [
// //             IconButton(
// //                 enableFeedback: false,
// //                 onPressed: () {
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreatePage()));
// //                 },
// //                 icon: Icon(
// //                   Icons.person_pin,
// //                   color: Colors.white,
// //                   size: 30,
// //                 )
// //             ),
// //             IconButton(
// //                 enableFeedback: false,
// //                 onPressed: () {
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
// //                 },
// //                 icon: Icon(
// //                   Icons.qr_code,
// //                   color: Colors.white,
// //                   size: 30,
// //                 )
// //             ),
// //             IconButton(
// //                 enableFeedback: false,
// //                 onPressed: () {
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreatePage()));
// //                 },
// //                 icon: Icon(
// //                   Icons.qr_code_scanner,
// //                   color: Colors.white,
// //                   size: 30,
// //                 )
// //             ),
// //             IconButton(
// //                 enableFeedback: false,
// //                 onPressed: () {
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
// //                 },
// //                 icon: Icon(
// //                   Icons.logout_rounded,
// //                   color: Colors.white,
// //                   size: 30,
// //                 )
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: ()async{
// //           await _auth.signOut();
// //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
// //         },
// //         child: Icon(Icons.logout_rounded),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import '../../widgets/my_home_page.dart';
// // // class HomeScreen extends StatefulWidget {
// // //   @override
// // //   _HomeScreenState createState() => _HomeScreenState();
// // // }
// // //
// // // class _HomeScreenState extends State<HomeScreen> {
// // //
// // //   //final _auth = FirebaseAuth.instance;
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //
// // //       body:  Center(
// // //         child: MyHomePage(),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         backgroundColor: Colors.brown[100],
// // //         onPressed: () {  },
// // //         child: ImageIcon(
// // //           AssetImage('Images/coffee_bean.png'),
// // //           size: 150,
// // //           color: Colors.brown[800],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }