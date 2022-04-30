import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Drive extends Equatable {
  Point pointDepart;
  Point pointArrive;
  String nomDepart;
  String nomArrive;
  String distance;
  int duration;
  int waitingDuration;
  String polyline;
  int etat;
  bool isMultiple;

  Drive(
      {required this.pointDepart,
      required this.pointArrive,
      required this.distance,
      required this.duration,
      required this.etat,
      required this.nomArrive,
      required this.nomDepart,
      required this.polyline,
      required this.waitingDuration,
      required this.isMultiple});

  @override
  List get props => [];
}

// ignore: must_be_immutable
class DriveMultiple extends Drive {
  DriveMultiple(
      {required Point pointDepart,
      required Point pointArrive,
      required String distance,
      required int duration,
      required int etat,
      required String nomArrive,
      required String nomDepart,
      required String polyline,
      required int waitingDuration})
      : super(
            pointDepart: pointDepart,
            pointArrive: pointArrive,
            distance: distance,
            duration: duration,
            etat: etat,
            nomArrive: nomArrive,
            nomDepart: nomDepart,
            polyline: polyline,
            waitingDuration: waitingDuration,
            isMultiple: true);

  @override
  List get props => [];
}

// ignore: must_be_immutable
class DriveSolo extends Drive {
  DriveSolo(
      {required Point pointDepart,
      required Point pointArrive,
      required String distance,
      required int duration,
      required int etat,
      required String nomArrive,
      required String nomDepart,
      required String polyline,
      required int waitingDuration})
      : super(
            pointDepart: pointDepart,
            pointArrive: pointArrive,
            distance: distance,
            duration: duration,
            etat: etat,
            nomArrive: nomArrive,
            nomDepart: nomDepart,
            polyline: polyline,
            waitingDuration: waitingDuration,
            isMultiple: false);

  @override
  List get props => [];
}

class Point {
  double x;
  double y;
  Point({required this.x, required this.y});
}
