
import 'dart:convert';

import 'package:note_app/models/api_response.dart';
import 'package:note_app/models/manipultation_note.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService{

  static const API  ='http://api.notes.programmingaddict.com';
  static const Headers = {
    "apiKey": "08d7b098-cf67-a54e-c529-7018f7bf40d1",
    "Content-Type" :"application/json"
  };

  // status code
  // 200 get from api
  // 201 insert new things to api (add)
  // 204 update on things that had already created in api

  // for list of items
  Future<ApiResponse<List<NoteForListing>>> getNoteList() async{
    return http.get(API+'/notes',headers: Headers).
    then((data){
          if (data.statusCode == 200){
              final jsonData  =json.decode(data.body);
              final notes = <NoteForListing>[];
                for(var item in jsonData){
                  notes.add(NoteForListing.fromJson(item));
                }
                return ApiResponse<List<NoteForListing>>(data: notes);
            }
          return ApiResponse<List<NoteForListing>>(error: true , errorMessage: "An Error Is Occured");
    }).catchError((_){
      return ApiResponse<List<NoteForListing>>(error: true , errorMessage: "An Error Is Occured");
    });
  }


  // for one item only
  Future<ApiResponse<Note>> getNote(String noteID) async {
    return http.get(API + '/notes/' + noteID, headers: Headers).
    then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return ApiResponse<Note>(data: Note.fromJson(jsonData));
      }
      return ApiResponse<Note>(
          error: true, errorMessage: "An Error Is Occured");
    }).catchError((_) {
      return ApiResponse<Note>(
          error: true, errorMessage: "An Error Is Occured");
    });
  }

 // create new note
  Future<ApiResponse<bool>> createNote(ManipulationNote note) async {
    return http.post(API + '/notes', headers: Headers,body: json.encode(note.toJson())).
    then((data) {
      if (data.statusCode == 201) {
        return ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    });
  }

 // update on note
  Future<ApiResponse<bool>> updateNote(ManipulationNote note ,String noteID) async {
    return http.put(API + '/notes/'+ noteID, headers: Headers,body: json.encode(note.toJson())).
    then((data) {
      if (data.statusCode == 204) {
        return ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    });
  }

  // delete from api
  Future<ApiResponse<bool>> deleteNote(String noteID) async {
    return http.delete(API + '/notes/'+ noteID, headers: Headers).
    then((data) {
      if (data.statusCode == 204) {
        return ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true, errorMessage: "An Error Is Occured");
    });
  }

}