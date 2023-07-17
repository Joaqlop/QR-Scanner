import 'package:flutter/material.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.value);

  if (scan.type == 'https') {
    //abrir sitio web
    if (!await canLaunchUrl(url)) {
      !await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se puede abrir $url';
    }
  } else {
    Navigator.pushNamed(context, 'maps', arguments: scan);
  }
}
