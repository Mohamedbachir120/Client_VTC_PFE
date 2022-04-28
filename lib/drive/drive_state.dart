
import 'package:equatable/equatable.dart';

abstract class DriveState extends Equatable{

   const DriveState();

  @override
  List<Object> get props => [];
}

class DriveInitial extends DriveState{}
class onRoad extends DriveState{}

class Arrived extends DriveState{}




