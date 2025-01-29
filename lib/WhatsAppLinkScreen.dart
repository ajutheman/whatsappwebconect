// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class WhatsAppLinkScreen extends StatelessWidget {
//   final String qrCodeData =
//       'https://web.whatsapp.com'; // WhatsApp Web link for linking

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('WhatsApp Link Setup')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Scan this QR code with your WhatsApp to link your device:',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             QrImage(
//               data: qrCodeData,
//               size: 200,
//               version: QrVersions.auto,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
