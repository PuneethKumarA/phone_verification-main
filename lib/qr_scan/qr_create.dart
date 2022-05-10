import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class QRCreatePage extends StatefulWidget {
  @override
  _QRCreatePageState createState() => _QRCreatePageState();
}

class _QRCreatePageState extends State<QRCreatePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text('QR Scanner'),
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              color: Colors.black,
              data: controller.text,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: buildTextField(context)),
                const SizedBox(width: 12),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.done, size: 30),
                  onPressed: () => setState(() {}),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
  Widget buildTextField(BuildContext context) => TextField(
    controller: controller,
    style: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    decoration: textInputDecoration.copyWith(
      hintText: 'Enter the Data',
    ),

    /* InputDecoration(
      hintText: 'Enter the data',
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),*/
  );
}
















// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
// class QRCreatePage extends StatefulWidget {
//   @override
//   _QRCreatePageState createState() => _QRCreatePageState();
// }
//
// class _QRCreatePageState extends State<QRCreatePage> {
//   final controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.brown,
//       title: Text('QR Scanner'),
//     ),
//     body: Center(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BarcodeWidget(
//               barcode: Barcode.qrCode(),
//               color: Colors.brown.shade900,
//               data: controller.text,
//               width: 200,
//               height: 200,
//             ),
//             SizedBox(height: 40),
//             Row(
//               children: [
//                 Expanded(child: buildTextField(context)),
//                 const SizedBox(width: 12),
//                 FloatingActionButton(
//                   backgroundColor: Theme.of(context).primaryColor,
//                   child: Icon(Icons.done, size: 30),
//                   onPressed: () => setState(() {}),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
//   Widget buildTextField(BuildContext context) => TextField(
//     controller: controller,
//     style: TextStyle(
//       color: Colors.brown,
//       fontWeight: FontWeight.bold,
//       fontSize: 20,
//     ),
//     decoration: InputDecoration(
//       hintText: 'Enter the data',
//       hintStyle: TextStyle(color: Colors.brown),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.brown),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     ),
//   );
// }