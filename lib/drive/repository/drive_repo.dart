import 'dart:async';
import 'dart:math';
import 'package:test_client_vtc/drive/bloc/drive_state.dart';
import 'package:test_client_vtc/drive/models/drive.dart';
import 'package:test_client_vtc/search/bloc/search_state.dart';


class DriveRepository {
  Drive? _drive;

  final _searchController = StreamController<SearchState>();
  final _driveControler = StreamController<DriveState>();

  Stream get search async* {
    yield* _searchController.stream;
  }
   Stream get drive async* {
    yield* _driveControler.stream;
  }


  Future<void> launchSerch() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      int nb = Random().nextInt(2);
      switch (nb % 2) {
        case 0:
          _searchController.add(DriverFounded());
          await Future.delayed(const Duration(seconds: 3), () {
            launchDrive();
          });

          break;
        case 1:
          _searchController.add(DriverNotFound());

          break;
      }
    });
  }

  Future<void> launchDrive() async {
  

    _driveControler.add(OnRoad());
    await Future.delayed(const Duration(seconds: 3), () {

    _driveControler.add(Arrived());

    });
  }

  void dispose() {
    _driveControler.close();
    _searchController.close();
  }
}
