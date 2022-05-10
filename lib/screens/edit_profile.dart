import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_verification/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../shared/user_model.dart';
import 'home_screen.dart';

//cloud_firestore: ^2.5.1
//image_picker: ^0.8.4+10
//firebase_storage: ^10.2.7

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
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

            //editingProfile controller
            final userNameProfileEditingController = TextEditingController(
                text: snapshot.data['userName']);
            final emailProfileEditingController = TextEditingController(
                text: snapshot.data['email']);


            //userNameField
            final userNameField = TextFormField(
              autofocus: false,
              controller: userNameProfileEditingController,
              keyboardType: TextInputType.name,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{5,}$');
                if (value.isEmpty) {
                  return ("userName cannot be Empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid Name(Min. 5 Characters)");
                }
                return null; // check this out
              },
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                userNameProfileEditingController.text = value;
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_pin),
                  contentPadding:
                  const EdgeInsets.fromLTRB(20.0, 15.0, 28.0, 15.0),
                  labelText: '${snapshot.data['userName']}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            );
            //emailField
            final emailField = TextFormField(
              autofocus: false,
              controller: emailProfileEditingController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return ("Email Cannot be empty");
                }
                return null;
              },
              onSaved: (value) {
                emailProfileEditingController.text = value;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  contentPadding:
                  const EdgeInsets.fromLTRB(20.0, 15.0, 28.0, 15.0),
                  labelText: '${snapshot.data['email']}',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            );

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
                                    child: Ink.image(
                                      image: NetworkImage('${loggedInUser
                                          .imageUrl}'),
                                      fit: BoxFit.cover,
                                      width: 128,
                                      height: 128,
                                      child: file == null ?
                                      InkWell(
                                          onTap: () async {
                                            XFile xfile = await ImagePicker()
                                                .pickImage(
                                                source: ImageSource.gallery);
                                            print('File ${xfile?.path}');
                                            file = File(xfile.path);
                                            setState(() {});
                                          }
                                      ) :
                                      Image.file(file),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: buildCircle(
                                    color: Colors.white,
                                    all: 3,
                                    child: buildCircle(
                                      color: Colors.deepPurple.shade900,
                                      all: 8,
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.white,
                                      ),
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
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 13)),
                              const SizedBox(height: 35),
                              Text('${snapshot.data['email']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      color: Colors.deepPurple)),
                              const SizedBox(height: 20),
                              Text(
                                '${snapshot.data['userName']}',
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepPurple),
                              ),
                              const SizedBox(height: 45),
                              userNameField,
                              const SizedBox(height: 20),
                              emailField,
                              const SizedBox(height: 20),
                            ],
                          ),
                          const SizedBox(height: 24),
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
                                child: const Text('Update Profile',
                                  style: TextStyle(fontSize: 19,
                                    fontWeight: FontWeight.w700,),),
                                onPressed: () {
                                  updateDetailsToFirestore(
                                      userNameProfileEditingController.text,
                                      emailProfileEditingController.text,
                                      snapshot.data['imageUrl'], context);
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

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(
        '${FirebaseAuth.instance.currentUser?.uid} _ ${basename(file.path)}')
        .putFile(file);

    return taskSnapshot.ref.getDownloadURL();
  }

  updateDetailsToFirestore(String userName, String email, String imageUrl,
      BuildContext context) async {
    // calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    Map<String, dynamic> map = Map();
    if (file != null) {
      String imageUrl = await uploadImage();
      map['imageUrl'] = imageUrl;
    }

    if (_formKey.currentState.validate()) {
      // writing all the values
      map['userName'] = userName;
      map['email'] = email;


      // sending these values
      await firebaseFirestore
          .collection('users')
          .doc(user?.uid)
          .update(map);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account Updated Successfully :) ',
              style: TextStyle(fontSize: 18.0))));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account update Unsuccessful :(',
              style: TextStyle(fontSize: 18.0))));
      Navigator.pop(context);
    }
  }


  Widget buildCircle({
    @required Widget child,       //ed @
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