import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add notes")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                    width: 3.0, style: BorderStyle.solid, color: Colors.brown)),
            child: Column(
              children: [
                TextFormField(
                  controller: _noteTitleController,
                  maxLength: 20,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "Note title",
                      hintStyle: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold)),
                ),
                TextFormField(
                  controller: _noteDescriptionController,
                  style: const TextStyle(fontSize: 13.0),
                  maxLength: 100,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "Note description",
                      hintStyle: TextStyle(fontSize: 13.0)),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
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
