import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
   final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            physics: ScrollPhysics(),
            itemCount: snapshot.data?.docs?.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot coffee = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  borderOnForeground: true,
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.deepPurple,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                  ),
                  shadowColor: Colors.black,
                  child: ListTile(
                    tileColor: Colors.transparent,
                    title: Material(
                        color: Colors.deepPurple,
                        child: Stack(
                          children: [
                            Image(
                              image: NetworkImage( coffee['imageUrl']),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 350,
                            ),
                            Positioned(
                                top:4,
                                left: 4,
                                child: Material(child: Text(coffee['sd']) , color: Colors.white70,borderRadius: BorderRadius.all(Radius.circular(10)),)
                            )
                          ],
                        ) ,
                    ),
                    subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            coffee['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                          ),
                          Text('\₹ 99', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, ),)
                        ]
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            clipBehavior: Clip.none,
                            contentPadding: EdgeInsets.all(20),
                            content: SizedBox(
                              height: 600,
                              width: 600,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        child:
                                        Image.network(coffee['imageUrl']),
                                        height: 300,
                                        width: 500),
                                    Text(
                                      coffee['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(coffee['desc'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Madley Italic',
                                            fontSize: 20,
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}


















// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
//
// class MyHomePage extends StatefulWidget {
//    final String title;
//
//   const MyHomePage({Key key, this.title}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('products').snapshots(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           return ListView.builder(
//             physics: ScrollPhysics(),
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot coffee = snapshot.data.docs[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//
//                   borderOnForeground: true,
//                   elevation: 20,
//                   shape: const RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.deepPurple,
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20.0),
//                         topRight: Radius.circular(20.0)),
//                   ),
//                   shadowColor: Colors.black,
//                   child: ListTile(
//                     tileColor: Colors.transparent,
//                     leading: SizedBox(
//                         child: ClipOval(
//                           child: Material(
//                             color: Colors.deepPurple,
//                             child: Ink.image(
//                                 image: NetworkImage( coffee['imageUrl']),
//                                 fit: BoxFit.cover,
//                                 width: 128,
//                                 height: 128,
//                                 child: InkWell(
//                                     onTap: () {
//
//                                     }
//                                 )
//                             ),
//                           ),
//                         ),
//                         height: 100,
//                         width: 100),
//                     title: Text(coffee['name']),
//                     trailing: Icon( Icons.forward ),
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             backgroundColor: Colors.white,
//                             clipBehavior: Clip.none,
//                             contentPadding: EdgeInsets.all(20),
//                             content: SizedBox(
//                               height: 600,
//                               width: 600,
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                         child:
//                                         Image.network(coffee['imageUrl']),
//                                         height: 300,
//                                         width: 500),
//                                     Text(
//                                       coffee['name'],
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 40,
//                                           fontStyle: FontStyle.italic),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text(coffee['desc'],
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontFamily: 'Madley Italic',
//                                             fontSize: 20,    //(edited)
//                                         ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ));
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//
//     );
//   }
// }













// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class MyHomePage extends StatefulWidget {
//    final String title;      //removed ? after String
//
//   const MyHomePage({Key key, this.title}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('products').snapshots(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           return ListView.builder(
//             physics: ScrollPhysics(),
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot coffee = snapshot.data.docs[index];       //removed ! in data!.docs
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   borderOnForeground: true,
//                   elevation: 20,
//                   shape: const RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.deepPurple,
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20.0),
//                         topRight: Radius.circular(20.0)),
//                   ),
//                   shadowColor: Colors.black,
//                   child: ListTile(
//                     leading: SizedBox(
//                         child: ClipOval(child: Image.network(coffee['imageUrl']) ),
//                         height: 100,
//                         width: 100),
//                     title: Text(coffee['name']),
//                     trailing: Text('desc'),
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             backgroundColor: Colors.white,
//                             clipBehavior: Clip.none,
//                             contentPadding: EdgeInsets.all(40),
//                             content: Column(
//                               children: [
//                                 SizedBox(
//                                     child:
//                                     Image.network(coffee['imageUrl']),
//                                     height: 300,
//                                     width: 500),
//                                 Text(
//                                   coffee['name'],
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 40,
//                                       fontStyle: FontStyle.italic),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(coffee['desc'],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600)),
//                               ],
//                             ),
//                           ));
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
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
// // import 'dart:core';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// //
// // class MyHomePage extends StatefulWidget {
// //   final String title;  //ed
// //   const MyHomePage({Key key, this.title}) : super(key: key);  //ed
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.brown[100],
// //       appBar: AppBar(
// //         backgroundColor: Colors.brown[700],
// //         title: Center(
// //             child: Text(
// //                 'Know Your Coffee',
// //                 style: const TextStyle(
// //                     letterSpacing: 4))
// //         ),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection('products').snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
// //           if (!snapshot.hasData){
// //             return CircularProgressIndicator();
// //           }
// //           return  ListView.builder(
// //             physics: ScrollPhysics(),
// //             itemCount: snapshot.data?.docs.length,
// //             itemBuilder: (BuildContext context, int index) {
// //               DocumentSnapshot coffee = snapshot.data.docs[index];
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Card(
// //                   borderOnForeground: true,
// //                   elevation: 20,
// //                   shape: const RoundedRectangleBorder(
// //                     side: BorderSide(
// //                       color: Colors.brown,
// //                       width: 1.0,
// //                     ),
// //                     borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(20.0),
// //                         topRight: Radius.circular(20.0)),
// //                   ),
// //                   shadowColor: Colors.black,
// //                   child: ListTile(
// //                     leading: SizedBox(
// //                       child: Image.network(coffee['imageUrl']),height: 70,width: 70,
// //                     ),
// //                     title: Text(coffee['name']),
// //                     trailing: Text('desc'),
// //                     onTap: () {
// //
// //                       showDialog(context: context, builder: (context) => AlertDialog(
// //                         backgroundColor: Colors.brown[100],
// //                         contentPadding: EdgeInsets.all(40) ,
// //                         content: Column(
// //                           children: [
// //                             SizedBox(
// //                               child: Image.network(
// //                                   coffee['imageUrl']) ,height:300 ,width: 500,
// //                             ),
// //                             Text(coffee['name'],
// //                               style: TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 40,
// //                                   fontStyle: FontStyle.italic),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                             SizedBox(
// //                               height: 20,
// //                             ),
// //                             Text(
// //                               coffee['desc'],
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ));
// //                     },
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
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
// //
// //
// //
// //
// //
// //
// //
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // import 'fruit_data_model.dart';
// // // import 'fruit_detail.dart';
// // //
// // // class MyHomePage extends StatefulWidget {
// // //
// // //   final String title;
// // //
// // //   const MyHomePage({Key key, this.title}) : super(key: key);
// // //   @override
// // //   State<MyHomePage> createState() => _MyHomePageState();
// // // }
// // //
// // // class _MyHomePageState extends State<MyHomePage> {
// // //   static List<String> name = [
// // //     'Iced Brew',
// // //     'Flat White',
// // //     'Espresso',
// // //     'Macchiato',
// // //     'Americano',
// // //     'Caffe Mocha',
// // //     'Chai Latte',
// // //     'cappuccino',
// // //     'Spice Latte',
// // //     'Hot Cocoa',
// // //     'Caramel Latte',
// // //   ];
// // //   static List Imageurl = [
// // //     'https://foreignfork.com/wp-content/uploads/2019/11/iced-coffee.jpg',
// // //     'https://live.staticflickr.com/7788/27642784765_965b911055_b.jpg',
// // //     'https://www.archanaskitchen.com/images/archanaskitchen/1-Author/happytrioexplains-gmail.com/Espresso_Coffee__Homemade_No_machine_Espresso_Coffee.jpg',
// // //     'https://www.coffeesurfco.com/wp-content/uploads/2020/08/117169445_572817326730822_1667163683892518137_n.png',
// // //     'https://image.kpopmap.com/2020/07/78c6057ca0e140e2a8de4a5e3d37f46b.jpg',
// // //     'https://th.bing.com/th/id/OIP.zcTgbFx5pJS--cdMAE-c0gHaFj?pid=ImgDet&rs=1',
// // //     'https://th.bing.com/th/id/R.ed7198b75d38a7824a2c12f1821eb3f6?rik=uFS9KzIYqB2yVQ&riu=http%3a%2f%2fjeanetteshealthyliving.com%2fwp-content%2fuploads%2f2015%2f10%2fSkinny-Pumpkin-Chai-Latte-3.jpg&ehk=iyz%2fhY0ehy6vE2a3uV0nCTFKbkWXDpsSlHU2mfqpSkY%3d&risl=&pid=ImgRaw&r=0',
// // //     'https://th.bing.com/th/id/R.f1664c920eee6211c04100fefadb95e4?rik=%2foIUELkyzpC%2bZQ&riu=http%3a%2f%2frecipes.lactaid.com%2fsites%2flactaid_us%2ffiles%2frecipe-images%2fcappuccino.jpg&ehk=b3g9EujTK6ohBgrvPexLf6BMZ1eJD7XVWMLq7SK58IY%3d&risl=&pid=ImgRaw&r=0',
// // //     'https://i.pinimg.com/originals/6f/7c/60/6f7c60f9cef886031f613bce3888f29c.jpg',
// // //     'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/10/18/0/FNK_Peppermint-Hot-Cocoa_s4x3.jpg.rend.hgtvcom.826.620.suffix/1383787064560.jpeg',
// // //     'https://th.bing.com/th/id/OIP.AciocP1QQk8VpH5f5Z_L6wHaLH?pid=ImgDet&rs=1'
// // //   ];
// // //
// // //   static List<String> desc = [
// // //     'A',
// // //     'C',
// // //     'n',
// // //     'v',
// // //     'F',
// // //     'g',
// // //     'J',
// // //     'K',
// // //     'R',
// // //     'O',
// // //     'U',
// // //   ];
// // //
// // //   final List<FruitDataModel> Fruitdata = List.generate(
// // //     name.length,
// // //         (index) => FruitDataModel(
// // //         '${name[index]}', '${Imageurl[index]}', '${desc[index]}'),
// // //   );
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.brown[100],
// // //       appBar: AppBar(
// // //         title: Text('Know Your Coffee'),
// // //       ),
// // //       body: ListView.builder(
// // //           itemCount: Fruitdata.length,
// // //           itemBuilder: (context, Index) {
// // //             return Align(
// // //               alignment: Alignment.centerRight, //or choose another Alignment
// // //               child: SizedBox(
// // //                 width: MediaQuery.of(context).size.width *
// // //                     50, //you sure it should be 0.001?
// // //                 height: MediaQuery.of(context).size.height * 0.12,
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(8.0),
// // //
// // //                   child: Card(
// // //                     shape: RoundedRectangleBorder(
// // //                       side: BorderSide(
// // //                         color: Colors.brown,
// // //                         width: 1.0,
// // //                       ),
// // //                       borderRadius: BorderRadius.only(
// // //                           bottomLeft: Radius.circular(20.0),
// // //                           topRight: Radius.circular(20.0)),
// // //                     ),
// // //                     shadowColor: Colors.black,
// // //                     elevation: 80,
// // //                     color: Colors.white,
// // //                     child: ListTile(
// // //                       title: Text(Fruitdata[Index].name),
// // //                       leading: SizedBox(
// // //                         width: 70,
// // //                         height: 70,
// // //                         child: Image.network(Fruitdata[Index].ImageUrl),
// // //                       ),
// // //                       onTap: () {
// // //                         Navigator.of(context).push(MaterialPageRoute(
// // //                           builder: (context) => FruitDetail(
// // //                             fruitDataModel: Fruitdata[Index],
// // //                           ),
// // //                         ));
// // //                       },
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             );
// // //           }),
// // //     );
// // //   }
// // // }
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // // // import 'dart:core';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/cupertino.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/widgets.dart';class MyHomePage extends StatefulWidget {
// // // //   final String? title;
// // // //   const MyHomePage({Key? key, this.title}) : super(key: key);
// // // //   @override
// // // //   State<MyHomePage> createState() => _MyHomePageState();
// // // // }
// // // // class _MyHomePageState extends State<MyHomePage> {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //         backgroundColor: Colors.brown[100],
// // // //         appBar: AppBar(
// // // //           backgroundColor: Colors.brown[700],
// // // //           title: Center(child: Text('Know Your Coffee',style: const TextStyle(letterSpacing: 4))),),
// // // //         body: StreamBuilder(
// // // //         stream: FirebaseFirestore.instance
// // // //             .collection('products')
// // // //         .snapshots(),
// // // //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
// // // //     if (!snapshot.hasData){
// // // //     return CircularProgressIndicator();}return  ListView.builder(
// // // //     physics: ScrollPhysics(),
// // // //     itemCount: snapshot.data?.docs.length,              itemBuilder: (BuildContext context, int index) {
// // // //     DocumentSnapshot coffee = snapshot.data!.docs[index];
// // // //     return Padding(
// // // //     return Padding(
// // // //     padding: const EdgeInsets.all(8.0),
// // // //       child: Card(
// // // //       borderOnForeground: true,
// // // //       elevation: 20,
// // // //       shape: const RoundedRectangleBorder(
// // // //       side: BorderSide(
// // // //       color: Colors.brown,
// // // //       width: 1.0,
// // // //       ),
// // // //       borderRadius: BorderRadius.only(
// // // //       bottomLeft: Radius.circular(20.0),
// // // //       topRight: Radius.circular(20.0)),
// // // //       ),
// // // //       shadowColor: Colors.black,
// // // //       child: ListTile(
// // // //       leading: SizedBox(child: Image.network(coffee['imageUrl']),height: 70,width: 70),
// // // //       title: Text(coffee['name']),
// // // //       trailing: Text('desc'),
// // // //       onTap: () {
// // // //
// // // //       showDialog(context: context, builder: (context) => AlertDialog(
// // // //       backgroundColor: Colors.brown[100],
// // // //       contentPadding: EdgeInsets.all(40) ,
// // // //       content: Column(
// // // //       children: [
// // // //       SizedBox(child: Image.network(coffee['imageUrl']) ,height:300 ,width: 500),
// // // //       Text(coffee['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
// // // //       SizedBox(height: 20,),
// // // //       Text(coffee['desc'], style: TextStyle(fontWeight: FontWeight.w600)),
// // // //       ],
// // // //       ),
// // // //       ));
// // // //       },
// // // //       ),
// // // //       ),
// // // //       );
// // // //     },
// // // //     );
// // // //     },
// // // //         ),
// // // //     );
// // // //   }
// // // // }