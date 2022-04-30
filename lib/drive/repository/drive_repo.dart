import 'dart:async';
import 'dart:math';
import 'package:test_client_vtc/drive/bloc/drive_event.dart';
import 'package:test_client_vtc/drive/models/drive.dart';

import '../../search/bloc/search_event.dart';

class DriveRepository {
  Drive? _drive;

  final _searchController = StreamController();
  final _driveControler = StreamController<DriveEvent>();

  Stream get search async* {
    yield* _searchController.stream;
  }
   Stream get drive async* {
    yield* _driveControler.stream;
  }


  Future<void> launchSerch() async {
    _searchController.add(SearchStarted());
    await Future.delayed(const Duration(seconds: 3), () async {
      int nb = Random().nextInt(2);
      switch (nb % 2) {
        case 0:
          _searchController.add(SearchAccepted());
          await Future.delayed(const Duration(seconds: 3), () {
            launchDrive();
          });

          break;
        case 1:
          _searchController.add(SearchTimedOut());

          break;
      }
    });
  }

  Future<void> launchDrive() async {
  

    _driveControler.add(DriveStarted());
    await Future.delayed(const Duration(seconds: 3), () {

    _driveControler.add(DriveEnded());

    });
  }

  void dispose() {
    _driveControler.close();
    _searchController.close();
  }
}
