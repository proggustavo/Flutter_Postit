import 'package:flutter/material.dart';
import 'package:flutter_postit/models/notes_model.dart';
import 'package:flutter_postit/db/database_provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String body;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print('Anotação adicionada');
  }

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar nova anotação"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Título",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: bodyController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Sua anotação"),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
            });                    
            NoteModel note =
                NoteModel(title: title, body: body);
            addNote(note);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          label: Text('Anotação salva'),
          icon: Icon(Icons.save)),
    );
  }
}
