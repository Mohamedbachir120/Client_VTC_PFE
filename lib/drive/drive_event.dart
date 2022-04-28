import 'package:equatable/equatable.dart';


abstract class DriveEvent extends Equatable {

  const DriveEvent();

  @override
  List<Object> get props => [];


}

class DriveStarted extends DriveEvent{

}


class DriveEnded extends DriveEvent{

}


