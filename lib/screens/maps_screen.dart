import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 20,
      tilt: 50,
    );

    //Markers
    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              if (mapType == MapType.normal) {
                setState(() {
                  mapType = MapType.hybrid;
                });
              } else {
                setState(() {
                  mapType = MapType.normal;
                });
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        buildingsEnabled: true,
        compassEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade100,
        child: const Icon(Icons.my_location_outlined,
            color: Colors.redAccent, size: 25),
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: scan.getLatLng(), tilt: 15, zoom: 25),
            ),
          );
        },
      ),
    );
  }
}
