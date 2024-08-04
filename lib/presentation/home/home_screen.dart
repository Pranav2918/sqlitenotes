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
  bool _isSearchEnable = false;
  final TextEditingController _searchController = TextEditingController();
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
      appBar: _isSearchEnable
          ? AppBar(
              title: TextFormField(
                controller: _searchController,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.normal)),
              ),
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.text = "";
                      _isSearchEnable = false;
                    });
                  },
                  icon: const Icon(Icons.close)),
            )
          : AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Home"),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearchEnable = true;
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
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
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, noteIndex) {
              return ListTile(
                leading: CircleAvatar(
                  child: Center(
                    child: Text(snapshot.data![noteIndex].id.toString()),
                  ),
                ),
                title: Text(snapshot.data![noteIndex].title),
                subtitle: Text(snapshot.data![noteIndex].description),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        child: ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      title: Text("Edit"),
                    )),
                    PopupMenuItem(
                        onTap: () {
                          dbHelper?.deleteNote(snapshot.data![noteIndex].id!);
                          setState(() {
                            noteList = dbHelper!.getNotesList();
                            snapshot.data!.remove(snapshot.data![noteIndex]);
                          });
                        },
                        child: const ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          title: Text("Delete"),
                        ))
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  FloatingActionButton _showAddButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.addNotes);
      },
      child: const Center(
        child: Icon(Icons.add),
      ),
    );
  }
}
