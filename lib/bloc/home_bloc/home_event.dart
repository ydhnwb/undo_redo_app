import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable{}

class HomeSaveValueEvent implements HomeEvent{
  final String value;

  HomeSaveValueEvent({@required this.value});

  @override
  List<Object> get props => [false];
  @override
  bool get stringify => false;  
}

class HomeRedoEvent implements HomeEvent {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => false;  
}

class HomeUndoEvent implements HomeEvent {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => false;
}