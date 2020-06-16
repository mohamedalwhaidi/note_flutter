
import 'package:flutter/cupertino.dart';

class ManipulationNote{

 String  noteTitle;
 String  noteContent;

 ManipulationNote({
   @required this.noteTitle ,
   @required this.noteContent});

  Map<String ,dynamic> toJson() {
    return {
      "noteTitle" : noteTitle ,
      "noteContent" :noteContent
    };
  }

}