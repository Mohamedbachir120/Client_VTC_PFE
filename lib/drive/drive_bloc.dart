import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/drive/drive_event.dart';
import 'package:test_client_vtc/drive/drive_state.dart';


class DriveBloc  extends Bloc <DriveEvent,DriveState>{

  DriveBloc(DriveState searchState) : super(DriveInitial()){
    
    on<DriveStarted>(_onStarted);
    on<DriveEnded>(_onEnd);

    
  }


  void _onStarted(DriveStarted event, Emitter<DriveState> emit) {
    emit(onRoad());

    Future.delayed(Duration(seconds: 2),(){
      this.add(DriveEnded());

    });
  }
  
  FutureOr<void> _onEnd(DriveEnded event, Emitter<DriveState> emit) {
    
    emit(Arrived());
  }



  

}