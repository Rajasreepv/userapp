import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/global/mapkey.dart';
import 'package:http/http.dart' as http;

String adress = "";
String adress2 = "";
String adress3 = "";
String adress4 = "";
String adress5 = "";

class dropoff extends StatefulWidget {
  const dropoff({super.key});

  @override
  State<dropoff> createState() => _dropoffState();
}

class _dropoffState extends State<dropoff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Set Drop Off",
                style: TextStyle(color: Colors.purple, fontSize: 22),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Color.fromARGB(255, 184, 47, 37),
                  ),
                  const SizedBox(
                    height: 100,
                    width: 15,
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                            ),
                          ) // Change the color as needed
                          ),
                      onPressed: () {},
                      child: Text(
                        adress + " " + adress2 + " " + adress4 + " " + adress5,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        currentlocation() async {
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          Position currentPosition = position;
                          LatLng latLatPosition =
                              LatLng(position.latitude, position.longitude);
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  position.latitude, position.longitude);
                          setState(() {
                            adress = placemarks.reversed.last.name.toString();
                            adress2 =
                                placemarks.reversed.last.locality.toString();
                            adress3 =
                                placemarks.reversed.last.street.toString();
                            adress4 =
                                placemarks.reversed.last.country.toString();
                            adress5 =
                                placemarks.reversed.last.postalCode.toString();
                          });
                        }

                        currentlocation();
                      },
                      child: Icon(Icons.refresh))
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Color.fromARGB(255, 184, 47, 37),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 15,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ), // Change the color as needed
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(300, 35)),
                      ),
                      onPressed: () {},
                      child: TextField(
                        onChanged: (val) {
                          findplace(val);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Where to ?",
                            contentPadding: EdgeInsets.only(
                                left: 11.0, top: 8.0, bottom: 8.0)),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void findplace(String placename) async {
  if (placename.length > 2) {
    final autoCompleteurl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=AIzaSyCHISNMUI99yENpo0LfJvFKO9WmSM-KKQQ');

    final response = await http.get(autoCompleteurl);
    if (response.statusCode == 200) {
      print('Response: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
