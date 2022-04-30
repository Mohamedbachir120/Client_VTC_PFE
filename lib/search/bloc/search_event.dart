import 'package:equatable/equatable.dart';


abstract class SearchEvent extends Equatable {

  const SearchEvent();

  @override
  List<Object> get props => [];


}

class SearchStarted extends SearchEvent{}


class SearchTimedOut extends SearchEvent{}

class SearchAccepted extends SearchEvent{}


class SearchRejected extends SearchEvent{}

class SearchCanceled extends SearchEvent{}

class SearchEnded extends SearchEvent{
}