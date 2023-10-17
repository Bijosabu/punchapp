// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:docmehr/application/blocs/userData/user_state.dart';
import 'package:docmehr/application/blocs/userInfo/user_info_bloc.dart';
import 'package:docmehr/presentation/widgets/button_punch_in.dart';
import 'package:docmehr/presentation/widgets/punch_running.dart';
import 'package:docmehr/core/enums.dart';
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
  getDeviceId() async {
    deviceId = await PlatformDeviceId.getDeviceId;
    // print(deviceIds);
    // deviceId = deviceIds;
  }

  @override
  void initState() {
    _initialize();

    super.initState();
  }

  @override
  void dispose() {
    // _timer!.cancel();
    super.dispose();
  }

  _initialize() {
    _showLoader();
    // await _createMap();
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

  bool _hasFetchedUserInfo = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!_hasFetchedUserInfo) {
        await getDeviceId();
        // ignore: use_build_context_synchronously
        BlocProvider.of<UserInfoBloc>(context).add(
          UserInfoEvent.getUserInfo(
            userToken: '3884F0E5-FDAA-46CD-9ADD-82BEFCDCBA58',
            deviceId: deviceId!,
            OTPNo: '12345',
          ),
        );
        _hasFetchedUserInfo = true;
      }
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // drawer: Drawer(),
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state.isError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.userInfo != null) {
            final lat = double.tryParse(state.userInfo!.northLat) ?? 0.0;
            final long = double.tryParse(state.userInfo!.westLong) ?? 0.0;
            final latLng = state.userInfo != null
                ? LatLng(
                    double.parse(state.userInfo!.northLat),
                    double.parse(state.userInfo!.westLong),
                  )
                : const LatLng(0.0, 0.0);
            return Stack(
              alignment: Alignment.topLeft,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, long),
                          zoom: 15,
                        ),
                        mapType: MapType.normal,
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId(
                                'your_marker_id'), // Provide a unique ID for the marker
                            position:
                                LatLng(lat, long), // Same lat/lng as above
                            infoWindow: const InfoWindow(
                              title: 'Location Title',
                              snippet: 'Location Description',
                            ),
                          ),
                        },
                        onMapCreated: (GoogleMapController controller) {
                          // You can interact with the map controller here if needed.
                        },
                      ),
                      // child: GoogleMap(
                      //   zoomGesturesEnabled: true,
                      //   markers: <Marker>{
                      //     Marker(
                      //         markerId: const MarkerId("location"),
                      //         position: latLng),
                      //   },
                      //   initialCameraPosition:
                      //       CameraPosition(target: latLng, zoom: 17),
                      //   // myLocationEnabled: true,
                      //   onMapCreated: (GoogleMapController controller) {
                      //     _locController.complete(controller);
                      //   },
                      // ),
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
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
