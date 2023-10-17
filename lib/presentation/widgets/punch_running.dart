import 'package:docmehr/application/blocs/punch/punch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/blocs/punch/punch_bloc.dart';

class PunchRunning extends StatefulWidget {
  const PunchRunning({super.key});

  @override
  State<PunchRunning> createState() => _PunchRunningState();
}

class _PunchRunningState extends State<PunchRunning> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height > 700 ? _height * 0.6 : _height * 0.7,
      padding: const EdgeInsets.only(left: 50, right: 50, top: 8, bottom: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: BlocBuilder<PunchBloc, PunchState>(
        builder: (context, state) {
          if (state is PunchInRunning) {
            return Text(state.time.toString());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
