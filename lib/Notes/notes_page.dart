// ignore_for_file: non_constant_identifier_names

import 'package:cmp/Notes/db/notes_database.dart';
import 'package:cmp/Notes/edit_note_page.dart';
import 'package:cmp/Notes/model/note.dart';
import 'package:cmp/Notes/note_detail_page.dart';
import 'package:cmp/Notes/widget/note_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController? _textEditingController = TextEditingController();
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;
  late List<Note> searchnotes;
  late List<Note> notes;
  bool isLoading = false;
  late String Keyword;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  void _filterCountries(value) {
    setState(() {
      notes = notes.where((NoteFields) => NoteFields.contains(value)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
        // final value = await showDialog<bool>(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text("Alert"),
        //         content: const Text("Do you Want to Exit"),
        //         actions: [
        //           ElevatedButton(
        //             onPressed: () => Navigator.of(context).pop(true),
        //             child: Text("Yes"),
        //           ),
        //           ElevatedButton(
        //             onPressed: () => Navigator.of(context).pop(false),
        //             child: Text("No"),
        //           ),
        //         ],
        //       );
        //     });
        // if (value != null) {
        //   return Future.value(value);
        // } else {
        //   return Future.value(value);
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? Text('Notes')
              : TextField(
                  onChanged: (value) {
                    setState(() {
                      notes = notes
                          .where((NoteFields) => NoteFields.contains(value))
                          .toList();
                    });
                  },
                  controller: _textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 16),
                      hintText: "Title and description",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
          actions: <Widget>[
            isSearching
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        this.isSearching = false;
                        // filteredCountries = countries;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    },
                  )
          ],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
