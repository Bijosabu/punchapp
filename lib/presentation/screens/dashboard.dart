import 'package:docmehr/application/blocs/punch/punch_bloc.dart';
import 'package:docmehr/application/blocs/punch/punch_event.dart';
import 'package:docmehr/application/blocs/userData/user_bloc.dart';
import 'package:docmehr/application/blocs/userData/user_event.dart';
import 'package:docmehr/presentation/screens/menu_page.dart';
import 'package:docmehr/presentation/screens/profile.dart';
import 'package:docmehr/presentation/screens/punching.dart';
import 'package:docmehr/presentation/screens/today_activity.dart';
import 'package:docmehr/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../services/drawer_model.dart';
import '../../core/enums.dart';
import 'help.dart';
import 'package:lottie/lottie.dart' as lot;

class DashBoard extends StatefulWidget {
  static const routeName = 'dashboard';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final drawcontroller = ZoomDrawerController();
  DrawerItem currentitem = DrawerItems.home;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc()..add(LoadUser())),
          BlocProvider(create: (_) => PunchBloc()..add(UserPunchIn())),
          // BlocProvider(create: (_) => PunchBloc()..add(const UserPunchRunning())),
        ],
        child: Scaffold(
          body: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: animText(),
            child: SafeArea(
              child: ZoomDrawer(
                controller: drawcontroller,
                style: DrawerStyle.style1,
                mainScreen: getDrawerItems(),
                menuScreen: Builder(builder: (context) {
                  return MenuPage(
                      currentitem: currentitem,
                      onSelected: (item) {
                        setState(() {
                          currentitem = item;
                        });
                        ZoomDrawer.of(context)!.close();
                      });
                }),
                borderRadius: 0,
                showShadow: false,
                // boxShadow: const [
                //   BoxShadow(
                //       color: Colors.black, offset: Offset(8, 8), blurRadius: 24),
                // ],
                //disableGesture: true,
                //duration: Duration(milliseconds: 400),
                mainScreenTapClose: true,
                dragOffset: 6.0,
                // swipeOffset: 6.0,
                angle: 0.0,
                menuBackgroundColor: Colors.grey,
                // backgroundColor: Colors.grey,
                slideWidth: MediaQuery.of(context).size.width * .65, //3.18
                // mainScreenScale: 10,
                openCurve: Curves.fastOutSlowIn,
                closeCurve: Curves.bounceIn,
                menuScreenWidth: MediaQuery.of(context).size.width * .65,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerItems() {
    switch (currentitem) {
      case DrawerItems.home:
        print("home");
        return Punching(
          zoomDrawerController: drawcontroller,
        );
      case DrawerItems.Profile:
        print("pro");
        return Profile(
          zoomDrawerController: drawcontroller,
        );
      case DrawerItems.activities:
        print("activi");
        return TodayActivity(
          zoomDrawerController: drawcontroller,
        );
      case DrawerItems.help:
        print("help");
        return Help(
          zoomDrawerController: drawcontroller,
        );
      // case DrawerItems.leave:
      //   print("leave");
      //   return leave(
      //     zoomDrawerController: drawcontroller,
      //   );
      default:
        return Punching(
          zoomDrawerController: drawcontroller,
        );
    }
  }

  Widget animText() => Center(
        child: Container(
          //width: 1.sw,
          //height: 1.sh,
          width: 350,
          height: 350,
          margin: EdgeInsets.only(top: 40),
          //color: Colors.white,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  // 'assets/images/benchmark_wfm.png',
                  'assets/images/loyaltri_name.png',
                  width: 150,
                  height: 100,
                ),
                lot.Lottie.asset('assets/blue_loading.json',
                    width: 150, height: 150),
                Text(
                  'Please Hold On...\nApplication is checking your permission.',
                  style: desigFont,
                ),
              ],
            ),
          ),
        ),
      );

  var desigFont = GoogleFonts.poppins(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400);
}
