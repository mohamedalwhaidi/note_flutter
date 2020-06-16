import 'package:flutter/foundation.dart';

class Note{
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditedDateTime;

  Note({
    this.noteID,
    this.noteTitle,
    this.noteContent,
    this.createDateTime,
    this.latestEditedDateTime});

  factory Note.fromJson(Map<String ,dynamic> item){
    return Note(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        noteContent: item['noteContent'],
        createDateTime: DateTime.parse(item['createDateTime']),
        latestEditedDateTime: item['latestEditDateTime'] != null
            ? DateTime.parse(item['latestEditDateTime'])
            : null);
  }

}