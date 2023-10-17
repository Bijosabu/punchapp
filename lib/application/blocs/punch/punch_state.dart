import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PunchState extends Equatable {
  const PunchState();

  @override
  List<Object> get props => [];
}

class PunchInLoading extends PunchState {}

class PunchInStart extends PunchState {
  // final PunchingState punch;
  // const PunchIn({required this.punch});

  @override
  List<Object> get props => [];
}

class PunchInRunning extends PunchState {
  final String? time;
  const PunchInRunning({this.time});

  @override
  List<Object> get props => [time!];
}

class PunchInError extends PunchState {

  @override
  List<Object> get props => [];
}