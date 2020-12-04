import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:undo_redo_app/bloc/home_bloc/home_event.dart';
import 'package:undo_redo_app/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitState());
  
  List _values = List<String>();
  int _currentPosition = 0;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is HomeSaveValueEvent){
      yield* _saveCurrentValue(event.value);
    }else if(event is HomeRedoEvent){
      yield* _redoValue();
    }else if(event is HomeUndoEvent){
      yield* _undoValue();
    }
  }

  Stream<HomeState> _saveCurrentValue(String v) async* {
    try{
      if(_values.length > 1){
        // _currentPosition = _values.length - 1;
        _values.removeRange(_currentPosition+1, _values.length);
      }
      _values.add(v);
      _currentPosition = _values.length - 1;
      yield HomeValueReturnState(value: _values[_currentPosition]);
    }catch(exception){
      print(exception);
      yield HomeShowMessageState(message: "An error occured $exception");
    }
  }

  Stream<HomeState> _redoValue() async* {
    try{
      int temp = _currentPosition + 1;
      if(temp >= _values.length){
        yield HomeShowMessageState(message: "You cannot redo anymore.");
      }else{
        _currentPosition += 1;
        yield HomeValueReturnState(value: _values[_currentPosition]);
      }
    }catch(exception){
      print(exception);
      yield HomeShowMessageState(message: "An error occured $exception");
    }
  }


  Stream<HomeState> _undoValue() async* {
    try{
      if(_currentPosition <= 0){
        yield HomeShowMessageState(message: "You cannot undo anymore.");
      }else{
        _currentPosition -= 1;
        yield HomeValueReturnState(value: _values[_currentPosition]);
      }
    }catch(exception){
      print(exception);
      yield HomeShowMessageState(message: "An error occured $exception");
    }
  }
}