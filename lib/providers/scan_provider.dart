import 'package:flutter/material.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:qr_scanner/providers/providers.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'https';

  Future<ScanModel?> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newDBScan(newScan);

    /// Asignar el ID de la base de datos al modelo
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllDBScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  loadScansByType(String type) async {
    var scans = await DBProvider.db.getDBScansByType(type);
    this.scans = [...scans!];
    selectedType = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllDBScans();
    scans = [];
    notifyListeners();
  }

  deleteScansByID(int id) async {
    await DBProvider.db.deleteDBScanByID(id);
  }

  deleteScansByType(String type) async {
    await DBProvider.db.deleteDBScanByType(type);
    loadScansByType(selectedType);
  }
}
