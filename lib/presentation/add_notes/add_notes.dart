import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';
import 'package:sqlitedemo/data/db/db_helper.dart';
import 'package:sqlitedemo/data/model/note_model.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  DBHelper? dbHelper;
  final TextEditingController _noteTitleController = TextEditingController();

  late Future<List<NoteModel>> notesList;

  @override
  void initState() {
    dbHelper = DBHelper();
    super.initState();
  }

  final DateTime _createdAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add notes")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                    width: 3.0, style: BorderStyle.solid, color: Colors.brown)),
            child: Column(
              children: [
                TextFormField(
                  controller: _noteTitleController,
                  maxLength: 50,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "Note title",
                      hintStyle: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                String executionDate =
                    "${_createdAt.day}-${_createdAt.month}-${_createdAt.year} ${_createdAt.hour}:${_createdAt.minute}";
                if (_noteTitleController.text.isNotEmpty) {
                  dbHelper!
                      .insertNote(NoteModel(
                          title: _noteTitleController.text,
                          createdAt: executionDate))
                      .then(
                    (value) {
                      setState(() {
                        notesList = dbHelper!.getNotesList();
                        Navigator.pushReplacementNamed(
                            context, AppRoute.homeScreen);
                      });
                    },
                  ).onError(
                    (error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Failed to add note"),
                        backgroundColor: Colors.red,
                      ));
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Provide a title"),
                    duration: Duration(milliseconds: 800),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  minimumSize: const Size(150.0, 45.0)),
              child: const Text("Add note"),
            ),
          )
        ],
      ),
    );
  }
}
