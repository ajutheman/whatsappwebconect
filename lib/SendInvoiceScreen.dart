import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendInvoiceScreen extends StatelessWidget {
  final String phoneNumber = '1234567890'; // Replace with customer number
  final String invoiceMessage =
      'Hello! Here is your invoice: https://example.com/invoice/123';

  void sendWhatsAppMessage() async {
    final Uri whatsappUrl = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(invoiceMessage)}');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Invoice via WhatsApp')),
      body: Center(
        child: ElevatedButton(
          onPressed: sendWhatsAppMessage,
          child: Text('Send Invoice'),
        ),
      ),
    );
  }
}
