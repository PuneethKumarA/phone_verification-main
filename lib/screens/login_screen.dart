import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:phone_verification/screens/home_screen.dart';

import '../shared/constants.dart';
import '../shared/user_model.dart';
import 'home_screen.dart';

//to handle views in the login screen(like a wrapper)
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //set the default screen
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  // form Key
  final _formKey = GlobalKey<FormState>();

  // firebase
  final _auth = FirebaseAuth.instance;

  //Editing Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();

  // string for displaying the error Message
  String errorMessage;

   String verificationId;

  bool showLoading = false;

// function for User details form
  getMobileFormWidget(context) {

    // userName field
    final userNameField = TextFormField(
      autofocus: false,
      controller: userNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Name(Min. 3 Characters)");
        }
        return null;// check this out
      },
      onSaved: (value){
        userNameController.text = value ;
      },
      textInputAction: TextInputAction.next,
      decoration: textInputDecoration.copyWith(
          hintText: 'Enter your Name',prefixIcon: const Icon(Icons.person)),
    );

    //EmailField
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value.isEmpty){
          return('Please Enter Your Email');
        }
        // reg exp for email validation
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
            .hasMatch(value)) {
          return ('Please Enter a valid email');
        }
        return null;
      },
      onSaved: (value){
        emailController.text = value ;
      },
      textInputAction: TextInputAction.next,
      decoration: textInputDecoration.copyWith(
        hintText: 'Enter your @dxc.com email address',prefixIcon: const Icon(Icons.email),),
    );

    //phoneNumber field
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if(value.isEmpty){
          return('Please Enter Your Phone Number');
        }
        // reg exp for phone validation
        if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
            .hasMatch(value)) {
          return ('Please Enter a valid email');
        }
        return null;
      },
      onSaved: (value){
        phoneController.text = value ;
      },
      textInputAction: TextInputAction.done,
      decoration: textInputDecoration.copyWith(
        hintText: 'Enter your PhoneNumber',prefixIcon: const Icon(Icons.phone_android),),
    );

    //login button
    final loginButton =SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            showLoading = true;
          });

          await _auth.verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: (phoneAuthCredential) async {
              setState(() {
                showLoading = false;
              });
              //signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            verificationFailed: (verificationFailed) async {
              setState(() {
                showLoading = false;
              });
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text(
                      verificationFailed.message.toString())));
            },
            codeSent: (verificationId, resendingToken) async {
              setState(() {
                showLoading = false;
                currentState =
                    MobileVerificationState.SHOW_OTP_FORM_STATE;
                this.verificationId = verificationId;
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {},
          );
        },
        child: const Text("Register"),
      ),
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 100,
            centerTitle: true,
            floating: true,
            title: Column(
              children: [
                ClipOval(
                  child: SizedBox(
                    child: Image.asset('Images/coffee_bean.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Center(
                      child: SizedBox(
                          child: Center(
                              child: Image.asset('images/coffee_bean.png')),
                          height: 100,
                          width: 100),
                    ),*/
                    const Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 20),
                      child: Center(
                        child: Text(
                          'Universal ID',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    userNameField,
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Email ID',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    //emailField,
                    emailField,
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    //phoneNumberField,
                    phoneNumberField,
                    const SizedBox(height: 35),
                    //signInButton,
                    loginButton,
                    /*SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showLoading = true;
                          });

                          await _auth.verifyPhoneNumber(
                            phoneNumber: phoneController.text,
                            verificationCompleted: (phoneAuthCredential) async {
                              setState(() {
                                showLoading = false;
                              });
                              //signInWithPhoneAuthCredential(phoneAuthCredential);
                            },
                            verificationFailed: (verificationFailed) async {
                              setState(() {
                                showLoading = false;
                              });
                              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                  content: Text(
                                      verificationFailed.message.toString())));
                            },
                            codeSent: (verificationId, resendingToken) async {
                              setState(() {
                                showLoading = false;
                                currentState =
                                    MobileVerificationState.SHOW_OTP_FORM_STATE;
                                this.verificationId = verificationId;
                              });
                            },
                            codeAutoRetrievalTimeout: (verificationId) async {},
                          );
                        },
                        child: Text("Sign In"),
                      ),
                    ),*/
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//function for OTP Verification form
  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: TextFormField(
            controller: otpController,
            keyboardType: TextInputType.visiblePassword,
            decoration: textInputDecoration.copyWith(
              hintText: 'Enter OTP',
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(right: 48, left: 48),
            child: ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: const Text(
                'VERIFY',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          toolbarHeight: 50,
          toolbarOpacity: 0.0,
          title: Center(
            child: SizedBox(
              height: 50,
              child: Image.asset(
                'Images/logo.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        //https://ok12static.oktacdn.com/fs/bco/1/fs0woruuvIgAGwAdl5d6
        /*actions: [
          FlatButton.icon(
              icon: Icon(Icons.coffee,color: Colors.brown[900]),
            onPressed: () {},
            label: Text('Brew', style: TextStyle(color: Colors.brown[900]),),
          ),
        ],*/
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Center(
          child: showLoading
              ? CircularProgressIndicator()
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
        ));
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {

    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        postDetailsToFirestore();
        /*Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));*/
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  postDetailsToFirestore() async {

    // calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    // calling our user model
    UserModel userModel = UserModel();


    // writing all the values
    userModel.phoneNumber = user.phoneNumber;
    userModel.uid = user.uid;
    userModel.userName = userNameController.text;
    userModel.email = emailController.text;

    //default
    userModel.imageUrl = 'https://firebasestorage.googleapis.com/v0/b/fir-profile-d94fb.appspot.com/o/coffee-bean-2-256.png?alt=media&token=96a16bfd-851f-498c-be68-0e1ce51fedc7';

    // sending these values
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created Successfully :) ', style: TextStyle(fontSize: 18.0))));

    /* Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);*/
  }
}













// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import "package:flutter/material.dart";
// import 'package:phone_verification/screens/home_screen.dart';
//
// import '../shared/constants.dart';
//
// //to handle views in the login screen(like a wrapper)
// enum MobileVerificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
// }
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   //set the default screen
//   MobileVerificationState currentState =
//       MobileVerificationState.SHOW_MOBILE_FORM_STATE;
//
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   final emailController = TextEditingController();
//   final userNameController = TextEditingController();
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // form Key
//   final _formKey = GlobalKey<FormState>();
//
//   String verificationId; // removed late from all this 4 before string -ed
//   String email;
//   String phoneNumber;
//   String userName;
//
//   bool showLoading = false;
//
//   //email field
//
//
//   void signInWithPhoneAuthCredential(
//       PhoneAuthCredential phoneAuthCredential) async {
//     setState(() {
//       showLoading = true;
//     });
//
//     try {
//       final authCredential =
//       await _auth.signInWithCredential(phoneAuthCredential);
//
//       setState(() {
//         showLoading = false;
//       });
//
//       if (authCredential.user != null) {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         showLoading = false;
//       });
//       _scaffoldKey.currentState
//           ?.showSnackBar(SnackBar(content: Text(e.message.toString())));
//     }
//   }
//
// // function for User details form
//   getMobileFormWidget(context) {
//
//     // userName field
//     final userNameField = TextFormField(
//       autofocus: false,
//       controller: userNameController,
//       keyboardType: TextInputType.name,
//       validator: (value) {
//         RegExp regex = new RegExp(r'^.{3,}$');
//         if (value.isEmpty) {      //removed ! after value
//           return ("First Name cannot be Empty");
//         }
//         if (!regex.hasMatch(value)) {
//           return ("Enter Valid Name(Min. 3 Characters)");
//         }
//         return null;// check this out
//       },
//       onSaved: (value){
//         userNameController.text = value ;     //removed ! after value (eg: value!)
//       },
//       textInputAction: TextInputAction.next,
//       decoration: textInputDecoration.copyWith(
//           hintText: 'Enter your Name'),
//
//     );
//
//     //EmailField
//     final emailField = TextFormField(
//       autofocus: false,
//       controller: emailController,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if(value.isEmpty){           //removed ! after value
//           return('Please Enter Your Email');
//         }
//         // reg exp for email validation
//         if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
//             .hasMatch(value)) {
//           return ('Please Enter a valid email');
//         }
//         return null;
//       },
//       onSaved: (value){
//         emailController.text = value ;        //removed ! after value
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.email),
//           contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 28.0, 15.0),
//           hintText: 'Email',
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10)
//           )
//       ),
//
//     );
//
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             toolbarHeight: 100,
//             centerTitle: true,
//             floating: true,
//             title: Column(
//               children: [
//                 ClipOval(
//                   child: SizedBox(
//                     child: Image.asset('Images/coffee_bean.png'),   //ed
//                     width: 100,
//                     height: 100,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//         body: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     /*Center(
//                       child: SizedBox(
//                           child: Center(
//                               child: Image.asset('images/coffee_bean.png')),
//                           height: 100,
//                           width: 100),
//                     ),*/
//
//                     const Padding(
//                       padding: EdgeInsets.only(top: 0, bottom: 20),
//                       child: Center(
//                         child: Text(
//                           'Universal ID',
//                           style: TextStyle(
//                               color: Colors.black54,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 10),
//                       child: Text(
//                         'Username',
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: textInputDecoration.copyWith(
//                           hintText: 'Enter your Name'),
//                       validator: (String val) =>    //removed ? after string
//                       val.isEmpty ? 'Enter a User Name' : null,  //removed ! after val
//                       onChanged: (val) {
//                         setState(() {
//                           userName = val;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20.0),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 10, bottom: 10),
//                       child: Text(
//                         'Email ID',
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17),
//                       ),
//                     ),
//                     //emailField,
//                     TextFormField(
//                       decoration: textInputDecoration.copyWith(
//                           hintText: 'Enter your @dxc.com email address'),
//                       validator: (String val) =>        //removed ? after string
//                       val.isEmpty ? 'Enter an Email' : null,     //removed ! after val
//                       onChanged: (val) {
//                         setState(() {
//                           email = val;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 10, top: 10),
//                       child: Text(
//                         'Phone Number',
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17),
//                       ),
//                     ),
//                     //phoneNumberField,
//                     TextFormField(
//                       controller: phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: textInputDecoration.copyWith(
//                         hintText: 'Phone Number',
//                       ),
//                       validator: (val) => val.length < 10    //removed  ! in val!.length<10
//                           ? 'Enter a valid Phone Number'
//                           : null,
//                       onChanged: (val) {
//                         setState(() {
//                           phoneNumber = val;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 35),
//                     //signupButton,
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           setState(() {
//                             showLoading = true;
//                           });
//
//                           await _auth.verifyPhoneNumber(
//                             phoneNumber: phoneController.text,
//                             verificationCompleted: (phoneAuthCredential) async {
//                               setState(() {
//                                 showLoading = false;
//                               });
//                               //signInWithPhoneAuthCredential(phoneAuthCredential);
//                             },
//                             verificationFailed: (verificationFailed) async {
//                               setState(() {
//                                 showLoading = false;
//                               });
//                               _scaffoldKey.currentState?.showSnackBar(SnackBar(
//                                   content: Text(
//                                       verificationFailed.message.toString())));
//                             },
//                             codeSent: (verificationId, resendingToken) async {
//                               setState(() {
//                                 showLoading = false;
//                                 currentState =
//                                     MobileVerificationState.SHOW_OTP_FORM_STATE;
//                                 this.verificationId = verificationId;
//                               });
//                             },
//                             codeAutoRetrievalTimeout: (verificationId) async {},
//                           );
//                         },
//                         child: Text("Sign In"),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// //function for OTP Verification form
//   getOtpFormWidget(context) {
//     return Column(
//       children: [
//         Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(left: 48, right: 48),
//           child: TextFormField(
//             controller: otpController,
//             keyboardType: TextInputType.visiblePassword,
//             decoration: textInputDecoration.copyWith(
//               hintText: 'Enter OTP',
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 48, left: 48),
//             child: ElevatedButton(
//               onPressed: () async {
//                 PhoneAuthCredential phoneAuthCredential =
//                 PhoneAuthProvider.credential(
//                     verificationId: verificationId,
//                     smsCode: otpController.text);
//
//                 signInWithPhoneAuthCredential(phoneAuthCredential);
//               },
//               child: const Text(
//                 'VERIFY',
//                 style:
//                 TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//         Spacer(),
//       ],
//     );
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           toolbarHeight: 50,
//           toolbarOpacity: 0.0,
//           title: Center(
//             child: SizedBox(
//               height: 50,
//               child: Image.asset(
//                 'Images/logo.jpg',     //edited
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//         //https://ok12static.oktacdn.com/fs/bco/1/fs0woruuvIgAGwAdl5d6
//         /*actions: [
//           FlatButton.icon(
//               icon: Icon(Icons.coffee,color: Colors.brown[900]),
//             onPressed: () {},
//             label: Text('Brew', style: TextStyle(color: Colors.brown[900]),),
//           ),
//         ],*/
//         backgroundColor: Colors.white,
//         key: _scaffoldKey,
//         body: Center(
//           child: showLoading
//               ? CircularProgressIndicator()
//               : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
//               ? getMobileFormWidget(context)
//               : getOtpFormWidget(context),
//         ));
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
//
//
//
//
//
//
// // import 'package:firebase_auth/firebase_auth.dart';
// // import "package:flutter/material.dart";
// // import 'package:phone_verification/screens/home_screen.dart';
// //
// // enum MobileVerificationState {
// //   SHOW_MOBILE_FORM_STATE,
// //   SHOW_OTP_FORM_STATE,
// // }
// //
// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   MobileVerificationState currentState =
// //       MobileVerificationState.SHOW_MOBILE_FORM_STATE;
// //
// //   final phoneController = TextEditingController();
// //   final otpController = TextEditingController();
// //
// //   FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   String verificationId;
// //
// //   bool showLoading = false;
// //
// //   void signInWithPhoneAuthCredential(
// //       PhoneAuthCredential phoneAuthCredential) async {
// //     setState(() {
// //       showLoading = true;
// //     });
// //
// //     try {
// //       final authCredential =
// //           await _auth.signInWithCredential(phoneAuthCredential);
// //
// //       setState(() {
// //         showLoading = false;
// //       });
// //
// //       if(authCredential?.user != null){
// //         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
// //       }
// //
// //     } on FirebaseAuthException catch (e) {
// //       setState(() {
// //         showLoading = false;
// //       });
// //
// //       _scaffoldKey.currentState
// //           .showSnackBar(SnackBar(content: Text(e.message)));
// //     }
// //   }
// //
// //   getMobileFormWidget(context) {
// //     return Column(
// //       children: [
// //         Spacer(),
// //         TextField(
// //           controller: phoneController,
// //           decoration: InputDecoration(
// //             hintText: "Phone Number",
// //           ),
// //         ),
// //         SizedBox(
// //           height: 16,
// //         ),
// //         FlatButton(
// //           onPressed: () async {
// //             setState(() {
// //               showLoading = true;
// //             });
// //
// //             await _auth.verifyPhoneNumber(
// //               phoneNumber: phoneController.text,
// //               verificationCompleted: (phoneAuthCredential) async {
// //                 setState(() {
// //                   showLoading = false;
// //                 });
// //                 //signInWithPhoneAuthCredential(phoneAuthCredential);
// //               },
// //               verificationFailed: (verificationFailed) async {
// //                 setState(() {
// //                   showLoading = false;
// //                 });
// //                 _scaffoldKey.currentState.showSnackBar(
// //                     SnackBar(content: Text(verificationFailed.message)));
// //               },
// //               codeSent: (verificationId, resendingToken) async {
// //                 setState(() {
// //                   showLoading = false;
// //                   currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
// //                   this.verificationId = verificationId;
// //                 });
// //               },
// //               codeAutoRetrievalTimeout: (verificationId) async {},
// //             );
// //           },
// //           child: Text("SEND"),
// //           color: Colors.brown,
// //           textColor: Colors.white,
// //         ),
// //         Spacer(),
// //       ],
// //     );
// //   }
// //
// //   getOtpFormWidget(context) {
// //     return Column(
// //       children: [
// //         Spacer(),
// //         TextField(
// //           controller: otpController,
// //           decoration: InputDecoration(
// //             hintText: "Enter OTP",
// //           ),
// //         ),
// //         SizedBox(
// //           height: 16,
// //         ),
// //         FlatButton(
// //           onPressed: () async {
// //             PhoneAuthCredential phoneAuthCredential =
// //                 PhoneAuthProvider.credential(
// //                     verificationId: verificationId, smsCode: otpController.text);
// //
// //             signInWithPhoneAuthCredential(phoneAuthCredential);
// //           },
// //           child: Text("VERIFY"),
// //           color: Colors.brown,
// //           textColor: Colors.white,
// //         ),
// //         Spacer(),
// //       ],
// //     );
// //   }
// //
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.brown[100],
// //
// //         key: _scaffoldKey,
// //         body: Container(
// //           child: showLoading
// //               ? Center(
// //                   child: CircularProgressIndicator(),
// //                 )
// //               : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
// //                   ? getMobileFormWidget(context)
// //                   : getOtpFormWidget(context),
// //           padding: const EdgeInsets.all(16),
// //         ));
// //   }
// // }
