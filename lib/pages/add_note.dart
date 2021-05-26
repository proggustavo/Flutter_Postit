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
  DateTime date;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print('note added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: bodyController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Your note"),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              date = DateTime.now();
            });                    
            NoteModel note =
                NoteModel(title: title, body: body, creation_date: date);
            addNote(note);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          label: Text('Save Note'),
          icon: Icon(Icons.save)),
    );
  }
}
