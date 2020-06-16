import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/Service/notes_service.dart';
import 'package:note_app/models/api_response.dart';
import 'package:note_app/models/note_for_listing.dart';
import 'package:note_app/views/note_delete.dart';
import 'package:note_app/views/note_modify.dart';


class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  NotesService get service => GetIt.instance<NotesService>();
  ApiResponse<List<NoteForListing>> apiResponse ;
  bool isLoading ;

  @override
  void initState(){
    _fetchNote();
    super.initState();
  }

  Future _fetchNote()  async{
    setState(() {
      isLoading = true ;
    });
    apiResponse = await service.getNoteList();
    setState(() {
      isLoading = false ;
    });
  }

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("List of Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify()))
              .then((_){
            _fetchNote();
          });
        },
        child: Icon(Icons.add),
      ),

      body:Builder(
        builder:(_){

          if(isLoading){
            return Center(child: CircularProgressIndicator(),);
          }

          if(apiResponse.error){
            return Center(child: Text(apiResponse.errorMessage),);
          }

          return ListView.separated(
              itemCount: apiResponse.data.length,
              itemBuilder: (_,index){
                return Dismissible(
                  key: ValueKey(apiResponse.data[index].noteID),
                  direction: DismissDirection.startToEnd,

                  confirmDismiss: (direction) async{
                    final result = await showDialog(
                        context: context,
                        builder: (_) => NoteDelete());


                    if (result){
                      final deleteReuslt = await service.deleteNote(apiResponse.data[index].noteID);
                      var message ;
                      if(deleteReuslt != null && deleteReuslt.data == true){
                        message = "note was sucessfully deleted" ;
                      }
                      else{
                        message =deleteReuslt?.errorMessage ?? 'An error Ouccerd';
                      }
                      showDialog (
                          context: context,
                          builder: (_) => AlertDialog (
                            title: Text('Done'),
                            content:Text(message),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK!"),
                                onPressed:(){
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          )
                      );
                      return deleteReuslt ?.data ?? false ;
                    }
                     return result;

                  },
                  onDismissed:(direction){
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(child: Icon(Icons.delete,color: Colors.white,),alignment: Alignment.centerLeft,),
                  ),

                  child: ListTile(
                    title: Text(
                      apiResponse.data[index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                    subtitle: Text('Last edited on ${formatDateTime(apiResponse.data[index].latestEditedDateTime ??
                        apiResponse.data[index].createDateTime)}'),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteModify(
                        noteID: apiResponse.data[index].noteID,)
                      )).then((_) => _fetchNote());
                    },
                  ),
                );
              },
              separatorBuilder: (_,__) => Divider(height: 2,color: Colors.blue,),
          );
        } ,
      )
    );
  }


}
