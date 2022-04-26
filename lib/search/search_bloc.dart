import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_client_vtc/search/search_event.dart';
import 'package:test_client_vtc/search/search_state.dart';
import 'dart:math';

class SearchBloc  extends Bloc <SearchEvent,SearchState>{

  SearchBloc(SearchState searchState) : super(SearchIntial()){
    
    on<SearchStarted>(_onStarted);
    on<SearchTimedOut>(_onTimedOut);
    on<SearchAcceptedAsFirstClient>(_onAcceptedAsFirstClient);
    on<SearchAcceptedAsNthClient>(_onAcceptedAsNthClient);
    on<SearchRejected>(_onRejected);
    on<SearchCanceled>(_onCanceled);

    
  }

  



  void _onStarted(SearchStarted event, Emitter<SearchState> emit) async{

    
    emit(Pending());

    await  Future.delayed(const Duration(seconds: 3), () {   
        int nb = Random().nextInt(3);
            switch(nb % 3){
              case 0:add(SearchAcceptedAsFirstClient());break;
              case 1:add(SearchTimedOut());break;
              case 2:add(SearchAcceptedAsNthClient(rank: 3));break;
            }

        



        });
  }

  FutureOr<void> _onTimedOut(SearchTimedOut event, Emitter<SearchState> emit) {
    emit(DriverNotFound());

  }

  FutureOr<void> _onAcceptedAsNthClient(SearchAcceptedAsNthClient event, Emitter<SearchState> emit) {
    emit(NthClient());
    
  }

  FutureOr<void> _onAcceptedAsFirstClient(SearchAcceptedAsFirstClient event, Emitter<SearchState> emit) {
    emit(FirstClient());

  }

  FutureOr<void> _onRejected(SearchRejected event, Emitter<SearchState> emit) {
    emit(DriverNotFound());
  }

  FutureOr<void> _onCanceled(SearchCanceled event, Emitter<SearchState> emit) {

    emit(SearchIntial());
  }
}