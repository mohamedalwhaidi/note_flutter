import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/Service/notes_service.dart';
import 'package:note_app/views/note_list.dart';

void setUpLocator(){
  GetIt.instance.registerLazySingleton( () => NotesService());
}

void main(){
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
