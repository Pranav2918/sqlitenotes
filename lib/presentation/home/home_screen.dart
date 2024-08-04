import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchEnable = false;
  final TextEditingController _searchController = TextEditingController();
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
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, noteIndex) {
        return ListTile(
          leading: CircleAvatar(
            child: Center(
              child: Text(noteIndex.toString()),
            ),
          ),
          title: const Text("Title here"),
          subtitle: const Text("Subtitle here"),
          trailing: PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                  child: ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                title: Text("Edit"),
              )),
              PopupMenuItem(
                  child: ListTile(
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
