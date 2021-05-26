import 'package:flutter/material.dart';
import 'package:flutter_postit/db/database_provider.dart';
import 'package:flutter_postit/pages/add_note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/AddNote": (context) => AddNote(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //getting all notes
  getNotes() async {
    print('aq');
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My notes")),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (noteData.data == Null) {
                  return Center(
                    child: Text("You don't have any notes yet"),
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: noteData.data.length,
                          itemBuilder: (context, index) {

                            String title = noteData.data[index]['title'];
                            String body = noteData.data[index]['body'];
                            // String creation_date =
                            //     noteData.data[index]['creation_date'];
                            // int id = noteData.data[index]['id'];
                            return Card(
                              child: ListTile(
                                  title: Text(title), 
                                  subtitle: Text(body),
                                ),
                            );
                          },
                        ),
                      );
                }
                break;
              }
            default:
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Let's navigate to the note creation
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
