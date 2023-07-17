import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.qr_code_scanner_rounded,
        size: 30,
      ),
      onPressed: () async {
        String qrcodeResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff0000',
          'Cancelar',
          false,
          ScanMode.QR,
        );
        //final qrcodeResult = 'https://fernando-herrera.com';
        //final qrcodeResult = 'geo:-31.407275827446355, -64.15274477964313';

        if (qrcodeResult == '-1') {
          return;
        }

        final results = Provider.of<ScanProvider>(context, listen: false);
        final scan = await results.newScan(qrcodeResult);

        launchURL(context, scan!);
      },
    );
  }
}
