import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/drive/models/drive.dart';
import 'package:test_client_vtc/drive/repository/drive_repo.dart';
import 'package:test_client_vtc/search/bloc/search_event.dart';
import 'package:test_client_vtc/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DriveRepository _driveRepository;
  late StreamSubscription _searchSubscribtion;
  SearchBloc(
      {required SearchState searchState,
      required DriveRepository driveRepository})
      : _driveRepository = driveRepository,
        super(SearchIntial()) {
    on<SearchStarted>(_onStarted);
    on<SearchTimedOut>(_onTimedOut);
    on<SearchAccepted>(_onAccepted);
    on<SearchRejected>(_onRejected);
    on<SearchCanceled>(_onCanceled);
    _searchSubscribtion = driveRepository.search.listen((event) {

      if (state != event) {
        if (event is Pending) {
          super.add(SearchStarted());
          
        } else if (event is DriverFounded) {
          super.add(SearchAccepted());
        } else if (event is DriverNotFound) {
          super.add(SearchRejected());
        }

      }
    });
  }

  void _onStarted(SearchStarted event, Emitter<SearchState> emit) async {
    emit(Pending());
    _driveRepository.launchSerch();
  }

  FutureOr<void> _onTimedOut(SearchTimedOut event, Emitter<SearchState> emit) {
    emit(DriverNotFound());
  }

  FutureOr<void> _onAccepted(SearchAccepted event, Emitter<SearchState> emit) {
    emit(DriverFounded());
  }

  FutureOr<void> _onRejected(SearchRejected event, Emitter<SearchState> emit) {
    emit(DriverNotFound());
  }

  FutureOr<void> _onCanceled(SearchCanceled event, Emitter<SearchState> emit) {
    emit(SearchIntial());
  }
}
