import 'package:flutter/material.dart';


class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want delete this note?'),
      actions: <Widget>[
          FlatButton(
            child: Text('YES'),
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text('NO'),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
      ],
    );


  }
}
