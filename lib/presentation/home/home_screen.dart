import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';
import 'package:sqlitedemo/data/db/db_helper.dart';
import 'package:sqlitedemo/data/model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NoteModel>> noteList;
  DBHelper? dbHelper;

  @override
  void initState() {
    dbHelper = DBHelper();
    getNotes();
    super.initState();
  }

  getNotes() {
    noteList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
      ),
      body: _renderNotesHomeScreenUI(),
      floatingActionButton: _showAddButton(),
    );
  }

  Widget _renderNotesHomeScreenUI() {
    return FutureBuilder(
      future: noteList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else {
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text(
                    "Nothing here...",
                    style: TextStyle(fontSize: 15.0),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, noteIndex) {
                    return ListTile(
                      onTap: () {},
                      leading: const CircleAvatar(
                        child: Center(
                            child: Icon(
                          Icons.stars,
                          color: Colors.white,
                        )),
                      ),
                      title: Text(snapshot.data![noteIndex].title),
                      subtitle: Text(snapshot.data![noteIndex].createdAt),
                      trailing: IconButton(
                          onPressed: () {
                            dbHelper?.deleteNote(snapshot.data![noteIndex].id!);
                            setState(() {
                              noteList = dbHelper!.getNotesList();
                              snapshot.data!.remove(snapshot.data![noteIndex]);
                            });
                          },
                          icon: const Icon(Icons.delete_outlined)),
                    );
                  },
                );
        }
      },
    );
  }

  FloatingActionButton _showAddButton() {
    return FloatingActionButton(
      elevation: 5.0,
      onPressed: () {
        Navigator.pushReplacementNamed(context, AppRoute.addNotes);
      },
      child: const Center(
        child: Icon(Icons.add),
      ),
    );
  }
}
