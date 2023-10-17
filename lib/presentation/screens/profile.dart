import 'package:docmehr/application/blocs/userInfo/user_info_bloc.dart';
import 'package:docmehr/core/constants.dart';
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

  String? _deviceId;

  _getDeviceId() async => _deviceId = await PlatformDeviceId.getDeviceId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getDeviceId();
      // ignore: use_build_context_synchronously
      BlocProvider.of<UserInfoBloc>(context).add(UserInfoEvent.getUserInfo(
          userToken: '3884F0E5-FDAA-46CD-9ADD-82BEFCDCBA58',
          deviceId: _deviceId!,
          OTPNo: '12345'));
    });
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
        // drawer: const Drawer(),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.isError) {
                  return const Center(
                    child: Text('Unable to load Profile Data'),
                  );
                } else {
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
                            backgroundImage: NetworkImage(state
                                    .userInfo?.empImage ??
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                          )),
                      kH10,
                      Text(
                        state.userInfo?.empName ?? 'Name',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      kH10,
                      Text(
                        state.userInfo?.desigName ?? 'App Developer',
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
                                  userdetail:
                                      state.userInfo?.deptName ?? 'No data'),
                              kH20,
                              Details(
                                  title: 'Department',
                                  userdetail:
                                      state.userInfo?.deptName ?? 'No data'),
                              kH20,
                              Details(
                                  title: 'Designation',
                                  userdetail:
                                      state.userInfo?.desigName ?? 'No data'),
                              kH20,
                              Details(
                                  title: 'Address',
                                  userdetail:
                                      state.userInfo?.instAddress ?? 'No data'),
                            ],
                          ),
                        ),
                      )
                    ],
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
      // child: Column(
      //   children: [
      //     kH10,
      //     Text(
      //       title,
      //       style: const TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.w300,
      //         color: Colors.black,
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 5,
      //     ),
      //     Text(
      //       userdetail,
      //       style: TextStyle(
      //         color: Colors.grey[600],
      //         fontSize: 14,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
