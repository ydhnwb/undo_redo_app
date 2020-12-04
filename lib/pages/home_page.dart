import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:undo_redo_app/bloc/home_bloc/home_bloc.dart';
import 'package:undo_redo_app/bloc/home_bloc/home_event.dart';
import 'package:undo_redo_app/bloc/home_bloc/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  HomeBloc _homeBloc;
  String _reversedStr = "-";

  _showToast(message) => Toast.show(message, context);

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Undo redo app"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        cubit: _homeBloc,
        listener: (context, state) => {
          if(state is HomeShowMessageState) {
            _showToast(state.message)
          }else if(state is HomeValueReturnState){
            _reversedStr = state.value.split('').reversed.join(''),
            _textEditingController.text = state.value
          }
        },
        builder: (context, state) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type something..."
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_reversedStr, style: TextStyle(fontSize: 24)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text("Reverse"),
                        onPressed: () => {
                          if(_textEditingController.text.toString().trim().isEmpty){
                            _showToast("Please type first....")
                          }else{
                            _homeBloc.add(HomeSaveValueEvent(value: _textEditingController.text.toString()))
                          }
                        }
                      ),
                      GestureDetector(
                        onDoubleTap: () => _homeBloc.add(HomeRedoEvent()),
                        child: RaisedButton(child: Text("Undo/Redo"),onPressed: () => _homeBloc.add(HomeUndoEvent())),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}