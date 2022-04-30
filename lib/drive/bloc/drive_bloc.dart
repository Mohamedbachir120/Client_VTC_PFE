import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/drive/bloc/drive_state.dart';
import 'package:test_client_vtc/drive/repository/drive_repo.dart';

import 'drive_event.dart';

class DriveBloc extends Bloc<DriveEvent, DriveState> {
  final DriveRepository _driveRepository;

  late StreamSubscription _driveSubscribtion;
  DriveBloc(
      {required DriveState driveState,
      required DriveRepository driveRepository})
      : _driveRepository = driveRepository,
        super(DriveInitial()) {
    on<DriveStarted>(_onStarted);
    on<DriveEnded>(_onEnd);

    _driveSubscribtion = driveRepository.drive.listen((event) {
        if (event is OnRoad) {
          super.add(DriveStarted());
        } else if (event is Arrived) {
          super.add(DriveEnded());
        }
      
    });
  }

  void _onStarted(DriveStarted event, Emitter<DriveState> emit) {
    emit(OnRoad());

    Future.delayed(Duration(seconds: 2), () {
      this.add(DriveEnded());
    });
  }

  FutureOr<void> _onEnd(DriveEnded event, Emitter<DriveState> emit) {
    emit(Arrived());
  }
}
