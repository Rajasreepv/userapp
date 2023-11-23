import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/mainscreens/dropoff.dart';
import 'package:user_app/widgets/divider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String adress = "";
  String adress2 = "";
  String adress3 = "";
  String adress4 = "";
  String adress5 = "";

  Completer<GoogleMapController> _controllergooglemap = Completer();
  GoogleMapController? newgooglemapcontroller;
  double bottompadding = 0;
  locateposition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Unable to fetch access");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error("location permsn denied");
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("denied forevr");
    }
    if (permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Position currentPosition = position;
      LatLng latLatPosition = LatLng(position.latitude, position.longitude);

      CameraPosition cameraPosition =
          new CameraPosition(target: latLatPosition, zoom: 14);
      newgooglemapcontroller!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        adress = placemarks.reversed.last.name.toString();
        adress2 = placemarks.reversed.last.locality.toString();
        adress3 = placemarks.reversed.last.street.toString();
        adress4 = placemarks.reversed.last.country.toString();
        adress5 = placemarks.reversed.last.postalCode.toString();
      });
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: bottompadding),
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controllergooglemap.complete(controller);
            newgooglemapcontroller = controller;
            setState(() {
              bottompadding = 300;
            });
            locateposition();
          },
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 300.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 6.0,
                  ),
                  const Text(
                    "Hey There!! ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.purple,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => dropoff()));
                              },
                              child: Text("Search Destination"))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$adress "
                              " $adress2 "
                              " $adress4 "
                              " $adress5"),
                          SizedBox(height: 4.0),
                          const Text(
                            "Your living home address",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const divider(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add work"),
                          SizedBox(height: 4.0),
                          Text(
                            "Your office address",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
    ;
  }
}
