import 'package:flutter/material.dart';
import 'package:flutter_postit/models/notes_model.dart';
import 'package:flutter_postit/db/database_provider.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Anotação"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DatabaseProvider.db.deleteNote(note.id);                
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              note.body,
              style: TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
