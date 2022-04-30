import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable{

   const SearchState();

  @override
  List<Object> get props => [];
}

class SearchIntial extends SearchState{}

class Pending extends SearchState{}

class DriverFounded extends SearchState{}


class DriverNotFound extends SearchState{}





