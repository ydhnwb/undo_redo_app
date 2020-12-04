import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class HomeState extends Equatable{}

class HomeInitState implements HomeState{
  @override
  List<Object> get props => [];
  @override
  bool get stringify => false;
}

class HomeValueReturnState implements HomeState {
  final String value;
  
  HomeValueReturnState({@required this.value});

  @override
  List<Object> get props => [value];
  @override
  bool get stringify => false;
}

class HomeShowMessageState implements HomeState {
  final String message;

  HomeShowMessageState({@required this.message});

  @override
  List<Object> get props => [message];
  @override
  bool get stringify => false;  
}