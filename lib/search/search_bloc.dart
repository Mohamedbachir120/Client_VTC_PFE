import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/search/search_event.dart';
import 'package:test_client_vtc/search/search_state.dart';

class SearchBloc  extends Bloc <SearchEvent,SearchState>{

  SearchBloc(SearchState searchState) : super(SearchIntial()){
    
    on<SearchStarted>(_onStarted);
    on<SearchTimedOut>(_onTimedOut);
    on<SearchAcceptedAsFirstClient>(_onAcceptedAsFirstClient);
    on<SearchAcceptedAsNthClient>(_onAcceptedAsNthClient);
    on<SearchRejected>(_onRejected);

    
  }

  



  void _onStarted(SearchStarted event, Emitter<SearchState> emit) {

    emit(Pending());
  }

  FutureOr<void> _onTimedOut(SearchTimedOut event, Emitter<SearchState> emit) {
    emit(DriverNotFound());

  }

  FutureOr<void> _onAcceptedAsNthClient(SearchAcceptedAsNthClient event, Emitter<SearchState> emit) {
    emit(FirstClient());
  }

  FutureOr<void> _onAcceptedAsFirstClient(SearchAcceptedAsFirstClient event, Emitter<SearchState> emit) {
    emit(NthClient());
  }

  FutureOr<void> _onRejected(SearchRejected event, Emitter<SearchState> emit) {
    emit(DriverNotFound());
  }
}