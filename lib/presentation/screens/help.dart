import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Help extends StatefulWidget {
  final ZoomDrawerController zoomDrawerController;
  const Help({super.key, required this.zoomDrawerController});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () {
                widget.zoomDrawerController.toggle!();
              },
              child: Text("Help"))),
    );
  }
}
