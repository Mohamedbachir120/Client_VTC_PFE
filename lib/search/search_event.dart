import 'package:equatable/equatable.dart';


abstract class SearchEvent extends Equatable {

  const SearchEvent();

  @override
  List<Object> get props => [];


}

class SearchStarted extends SearchEvent{

}


class SearchTimedOut extends SearchEvent{

}

class SearchAcceptedAsFirstClient extends SearchEvent{

 final int rank = 1;

}
class SearchAcceptedAsNthClient extends SearchEvent{
  int rank;
  SearchAcceptedAsNthClient({required this.rank});

}

class SearchRejected extends SearchEvent{

}