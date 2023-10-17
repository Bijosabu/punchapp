import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../services/shared_preference.dart';

@immutable
abstract class PunchEvent extends Equatable {
  const PunchEvent();

  @override
  List<Object> get props => [];
}

class UserPunchIn extends PunchEvent {
  final String? loc;
  final String? remark;
  const UserPunchIn({this.loc, this.remark}) : super();

  Future<dynamic> punchIn() async {
    if (loc != null && remark != null) {
      print("---loc-----$loc");
      print("---remark-----$remark");
      final startTime = DateTime.now();
      await SharedPrefs().setTimer(startTime);
    }
  }

  Future<String> elapsedTime() async {
    String? startTime = await SharedPrefs().getTimer();
    DateTime time = DateTime.parse(startTime.toString());
    DateTime currentTime = DateTime.now();

    final timer = currentTime.difference(time);
    return timer.toString();
  }
}

// class PunchEventLoaded extends PunchEvent {}
//
// class UserPunchOut extends PunchEvent {}
//
//
class UserPunchRunning extends PunchEvent {
  // final String? loc;
  // final String? remark;
  // const UserPunchRunning({this.loc, this.remark}) : super();
  //
  // jhnivfg() {
  //   print("----------eventrunning");
  // }
  //
  // Future<dynamic> punchIn() async {
  //   if (loc != null && remark != null) {
  //     print("--------$loc");
  //     print("--------$remark");
  //     final startTime = DateTime.now().millisecondsSinceEpoch;
  //     await SharedPrefs().setTimer(startTime);
  //   }
  // }
  //
  // Future<int> elapsedTime() async {
  //   int? startTime = await SharedPrefs().getTimer();
  //   int? currentTime = DateTime.now().microsecondsSinceEpoch;
  //
  //   final elapsed = currentTime - startTime!;
  //   return elapsed;
  // }
}
