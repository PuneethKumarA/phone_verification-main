import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_verification/screens/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/user_model.dart';
import 'home_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _auth = FirebaseAuth.instance;
  // form Key
  final _formKey = GlobalKey<FormState>();

  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  File file;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.deepPurple,
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,

      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: SingleChildScrollView(
                child: Container(

                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Image(
                                      image: NetworkImage('${snapshot.data['imageUrl']}'),
                                      fit: BoxFit.cover,
                                      width: 128,
                                      height: 128,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              Text('${snapshot.data['uid']}',
                                  style: TextStyle(color: Colors.deepPurple,fontSize: 13,fontWeight: FontWeight.w500)),
                              const SizedBox(height: 50),

                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Stack(children: const [
                                        Icon(Icons.circle,color: Colors.grey,size: 50,),
                                        Positioned(
                                            top: 0,
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Icon(Icons.person)
                                        )],)
                                  ),
                                  Text(
                                    '${snapshot.data['userName']}',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(children: const [
                                        Icon(Icons.circle,color: Colors.grey,size: 50,),
                                        Positioned(
                                            top: 0,
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Icon(Icons.phone)
                                        )],)
                                  ),
                                  Text(
                                    '${snapshot.data['phoneNumber']}',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Stack(children: const [
                                          Icon(Icons.circle,color: Colors.grey,size: 50,),
                                          Positioned(
                                              top: 0,
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Icon(Icons.email_rounded)
                                          )],),
                                      )
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text('${snapshot.data['email']}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                              color: Colors.deepPurple)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple[700],
                                  onPrimary: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                ),
                                child: const Text('Edit Profile',style: TextStyle(fontSize: 19,
                                  fontWeight: FontWeight.w700,), ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => EditProfileScreen()));

                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget buildCircle({
    @required Widget child,     //ed @
    @required Color color,
    @required double all,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}














