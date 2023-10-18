import 'package:docmehr/application/blocs/userData/user_bloc.dart';
import 'package:docmehr/application/blocs/userData/user_state.dart';
import 'package:docmehr/application/blocs/userInfo/user_info_bloc.dart';
import 'package:docmehr/core/constants.dart';
import 'package:docmehr/domain/models/userModel.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Profile extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;

  Profile({
    super.key,
    required this.zoomDrawerController,
  });
  // User? user;
  // String? _deviceId;
  // _getUser() async {
  //   user = await UserDatabase.instance.readData(1);
  // }

  // _getDeviceId() async => _deviceId = await PlatformDeviceId.getDeviceId;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   // await _getUser();
    //   // print(user!.deptName);
    //   // await _getDeviceId();
    //   // // ignore: use_build_context_synchronously
    //   // BlocProvider.of<UserInfoBloc>(context).add(UserInfoEvent.getUserInfo(
    //   //     userToken: '3884F0E5-FDAA-46CD-9ADD-82BEFCDCBA58',
    //   //     deviceId: _deviceId!,
    //   //     OTPNo: '12345'));
    // });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              zoomDrawerController.toggle!();
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                } else if (state is UserLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      kH40,
                      Container(
                          width: 60.0 * 2,
                          height: 60.0 * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(state.user.empImage),
                          )),
                      kH10,
                      Text(
                        state.user.empName,
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      kH10,
                      Text(
                        state.user.desigName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      kH20,
                      Container(
                        height: size.height * 0.5,
                        width: size.width - 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey[100],
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                                blurRadius: 4,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Details(
                                  title: 'Company details',
                                  userdetail: state.user.instName),
                              kH20,
                              Details(
                                  title: 'Department',
                                  userdetail: state.user.deptName),
                              kH20,
                              Details(
                                  title: 'Designation',
                                  userdetail: state.user.desigName),
                              kH20,
                              Details(
                                  title: 'Address',
                                  userdetail: state.user.instAddress),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
          ),
        ));
  }
}

class Details extends StatelessWidget {
  final String title;
  final String userdetail;
  const Details({super.key, required this.title, required this.userdetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(userdetail),
      ),
    );
  }
}
