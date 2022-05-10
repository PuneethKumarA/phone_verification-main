import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:phone_verification/qr_scan/button.dart';
import '../main.dart';
class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor:Colors.deepPurple ,
      title: const Text('QR Scanner'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Scan Result',
            style: TextStyle(
              fontSize: 16,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$qrCode',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 72),
          ButtonWidget(
            text: 'Start QR scan',
            onClicked: () => scanQRCode(),
          ),
        ],
      ),
    ),
  );
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:phone_verification/qr_scan/button.dart';
// import '../main.dart';
// class QRScanPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _QRScanPageState();
// }
//
// class _QRScanPageState extends State<QRScanPage> {
//   String qrCode = 'Unknown';
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor:Colors.brown ,
//       title: Text(MyApp.title),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Scan Result',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.brown,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             '$qrCode',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.brown,
//             ),
//           ),
//           SizedBox(height: 72),
//           ButtonWidget(
//             text: 'Start QR scan',
//             onClicked: () => scanQRCode(),
//           ),
//         ],
//       ),
//     ),
//   );
//   Future<void> scanQRCode() async {
//     try {
//       final qrCode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );
//       if (!mounted) return;
//       setState(() {
//         this.qrCode = qrCode;
//       });
//     } on PlatformException {
//       qrCode = 'Failed to get platform version.';
//     }
//   }
// }