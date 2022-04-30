import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/drive/bloc/drive_state.dart';
import 'package:test_client_vtc/drive/models/drive.dart';
import 'package:test_client_vtc/drive/repository/drive_repo.dart';


import 'drive_event.dart';


class DriveBloc  extends Bloc <DriveEvent,DriveState>{

  final DriveRepository driveRepository ;

 late StreamSubscription
      _driveSubscribtion;
  DriveBloc({required DriveState driveState,required this.driveRepository}) : super(DriveInitial()){
    
    on<DriveStarted>(_onStarted);
    on<DriveEnded>(_onEnd);

    _driveSubscribtion = driveRepository.drive.listen((event) {
         
            super.add(event);
          
    });


    
  }


  void _onStarted(DriveStarted event, Emitter<DriveState> emit) {
    emit(OnRoad());

    Future.delayed(Duration(seconds: 2),(){
      this.add(DriveEnded());

    });
  }
  
  FutureOr<void> _onEnd(DriveEnded event, Emitter<DriveState> emit) {
    
    emit(Arrived());
  }



  

}