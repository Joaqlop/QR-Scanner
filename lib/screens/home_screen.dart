import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/providers.dart';

import 'package:qr_scanner/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final results = Provider.of<ScanProvider>(context);
    final index = uiProvider.selectedMenuOpt;
    final String type;
    uiProvider.selectedMenuOpt == 0 ? type = 'geo' : type = 'https';

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              results.deleteScansByType(type);
            },
          )
        ],
      ),
      body: _HomeBody(index: index, results: results),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  final int index;
  final ScanProvider results;

  const _HomeBody({required this.index, required this.results});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        results.loadScansByType('geo');
        return const ScanList(type: 'geo');

      case 1:
        results.loadScansByType('https');
        return const ScanList(type: 'https');
      default:
        return Container(
          color: Colors.grey.shade100,
        );
    }
  }
}
