import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng customLocation = LatLng(14.852885352588201, 120.81614049713285);

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};
  final _customInfoWindowController = CustomInfoWindowController();

  //late String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                const CameraPosition(target: customLocation, zoom: 12),
            onMapCreated: (controller) {
              _mapController = controller;
              _customInfoWindowController.googleMapController = controller;
              addMarker('test', customLocation);
              addMarker(
                'test1',
                const LatLng(14.842100727754945, 120.83743481184958),
              );
              addMarker(
                'test2',
                const LatLng(14.858096320640007, 120.74220251284042),
              );
            },
            onTap: (location) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: _markers.values.toSet(),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 150,
            width: 200,
            offset: 50,
          )
        ],
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/foodpark1.png');
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        //infoWindow: const InfoWindow(
        //  title: 'Title of Place',
        // snippet: 'Description',
        //),
        icon: markerIcon,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/Crossroads.jpg',
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'Crossroads Food Park',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            location,
          );
        });

    _markers[id] = marker;
    setState(() {});
  }
}
