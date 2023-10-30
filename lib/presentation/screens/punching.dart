// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:docmehr/application/blocs/userData/user_bloc.dart';
import 'package:docmehr/application/blocs/userData/user_state.dart';
import 'package:docmehr/application/blocs/userInfo/user_info_bloc.dart';
import 'package:docmehr/application/stateController/getXController.dart';
import 'package:docmehr/domain/models/userModel.dart';

import 'package:docmehr/presentation/widgets/button_punch_in.dart';
import 'package:docmehr/presentation/widgets/punch_running.dart';
import 'package:docmehr/core/enums.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:platform_device_id/platform_device_id.dart';
import '../../application/blocs/punch/punch_bloc.dart';
import '../../application/blocs/punch/punch_state.dart' as punch;
import '../../application/blocs/punch/punch_state.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:get/get.dart';

class Punching extends StatefulWidget {
  final ZoomDrawerController zoomDrawerController;
  const Punching({super.key, required this.zoomDrawerController});

  @override
  State<Punching> createState() => _PunchingState();
}

class _PunchingState extends State<Punching> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _locController = Completer();
  LatLng? latLng;
  Timer? _timer;
  String? deviceId;
  User? user;
  double? lat;
  double? long;
  LatLng? latlng;
  // getDeviceId() async {
  //   deviceId = await PlatformDeviceId.getDeviceId;
  //   // print(deviceIds);
  //   // deviceId = deviceIds;
  // }

  @override
  void initState() {
    super.initState();
    _initialize();
    // _createMap();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  _initialize() async {
    _showLoader();
    await _createMap();
    _hideLoader();
  }

  Future _createMap() async {
    Position? position = await _getCurrentPosition();
    setState(() => latLng = LatLng(position!.latitude, position.longitude));

    GoogleMapController googleMapController = await _locController.future;

    getJsonFile("assets/darkmode.json").then((String mapStyle) async {
      await googleMapController.setMapStyle(mapStyle);
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _getCurrentPosition().then((newPosition) {
        setState(() {
          latLng = LatLng(newPosition!.latitude, newPosition.longitude);
        });

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 17,
              target: LatLng(
                newPosition!.latitude,
                newPosition.longitude,
              ),
            ),
          ),
        );
      });
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  _showLoader() {
    context.loaderOverlay.show();
  }

  _hideLoader() {
    context.loaderOverlay.hide();
  }

  Future<Position?> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission Denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Please enable location to continue');
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
  // _getUser() async {
  //   user = await UserDatabase.instance.readData(1);
  // }

  // final user = UserDatabase.instance.readData(1);

  // bool _hasFetchedUserInfo = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            LatLng? latLng;
            double zoomLevel = 15;
            if (user != null) {
              lat = double.tryParse(user!.northLat);
              long = double.tryParse(user!.westLong);
              latlng = LatLng(lat!, long!);
            }

            return Stack(
              alignment: Alignment.topLeft,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      // child: GoogleMap(
                      //   initialCameraPosition: CameraPosition(
                      //     target: latlng ?? const LatLng(70.8, 76.9),
                      //     zoom: zoomLevel,
                      //   ),
                      //   mapType: MapType.normal,
                      //   markers: <Marker>{
                      //     Marker(
                      //       markerId: const MarkerId('your_marker_id'),
                      //       position: latlng ?? const LatLng(70.8, 76.9),
                      //       infoWindow: const InfoWindow(
                      //         title: 'Location Title',
                      //         snippet: 'Location Description',
                      //       ),
                      //     ),
                      //   },
                      //   onMapCreated: (GoogleMapController controller) {},
                      // ),
                      child: GoogleMap(
                        zoomGesturesEnabled: true,
                        markers: <Marker>{
                          Marker(
                              markerId: const MarkerId("location"),
                              position:latlng?? const LatLng(70.8, 76.9)),
                        },
                        initialCameraPosition: CameraPosition(
                            target:latlng?? const LatLng(70.8, 76.9), zoom: 17),
                        // myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _locController.complete(controller);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.zoomDrawerController.toggle!();
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.replay_outlined,
                        //     color: Colors.red,
                        //   ),
                        //   onPressed: () => _initialize(),
                        // ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder<PunchBloc, PunchState>(
                    builder: (context, state) {
                      if (state is PunchInLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PunchInStart) {
                        return const ButtonPunchIn();
                      } else if (state is PunchInRunning) {
                        return const PunchRunning();
                      } else {
                        return const Center(
                            child: Text('Punch in not available'));
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Unable to load data'),
            );
          }
        },
      ),
    );
  }
}
