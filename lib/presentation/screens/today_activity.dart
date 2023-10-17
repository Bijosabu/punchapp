import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class TodayActivity extends StatefulWidget {
  final ZoomDrawerController zoomDrawerController;
  const TodayActivity({super.key, required this.zoomDrawerController});

  @override
  State<TodayActivity> createState() => _TodayActivityState();
}

class _TodayActivityState extends State<TodayActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            widget.zoomDrawerController.toggle!();
          },
          child: Center(child: const Text("Today Activity"))),
    );
  }
}
