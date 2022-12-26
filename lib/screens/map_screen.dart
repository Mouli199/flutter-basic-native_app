import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 16.524, longitude: 80.603, address: ''),
      this.isSelecting = false});

  //const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: <Widget>[
            if (widget.isSelecting)
              //FloatingActionButton(onPressed: onPressed)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                  icon: Icon(Icons.check)),
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 16,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedLocation == null && !widget.isSelecting)
              ? <Marker>[].toSet()
              : [
                  Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          widget.initialLocation.latitude,
                          widget.initialLocation.longitude,
                        ),
                  ),
                ].toSet(),
          //onTap: widget.isSelecting ? _selectLocation : null,
          // markers: _pickedLocation! == null ? null : {
          //   Marker(markerId: MarkerId('m1'), position: _pickedLocation!),
          // },
        ));
  }
}
