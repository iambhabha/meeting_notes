import 'package:cmp/Notes/model/note.dart';
import 'package:cmp/Notes/note_detail_page.dart';
import 'package:cmp/Notes/widget/note_card_widget.dart';
import 'package:cmp/Notes/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String query = '';

  late List<Note> notes;
  @override
  void initState() {
    super.initState();
    notes = [];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("search"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: StaggeredGridView.countBuilder(
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
                    },
                    child: NoteCardWidget(note: note, index: index),
                  );
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'note or description',
        onChanged: searchnote,
      );

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
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );

  void searchnote(String query) {
    final note = notes.where((Note) {
      final titleLower = Note.title.toLowerCase();
      final descriptionLower = Note.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.notes = notes;
    });
  }
}



// // class Search extends SearchDelegate {
// //   List<String> data = [
// //     "android",
// //     "windows",
// //     "mac",
// //     "linux",
// //     "parrotOS",
// //     "mint"
// //   ];

// //   List<String> recentSearch = [
// //     "Android",
// //     "Windows",
// //     "Mac",
// //   ];

// //   @override
// //   List<Widget> buildActions(BuildContext context) {
// //     return <Widget>[
// //       IconButton(
// //           icon: Icon(Icons.clear),
// //           onPressed: () {
// //             query = "";
// //           })
// //     ];
// //   }

// //   @override
// //   Widget buildLeading(BuildContext context) {
// //     return IconButton(
// //         icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
// //   }







// //   @override
// //   Widget buildResults(BuildContext context) {
// //     if (query != null && data.contains(query.toLowerCase())) {
// //       return ListTile(
// //         title: Text(query),
// //         onTap: () {},
// //       );
// //     } else if (query == "") {
// //       return Text("");
// //     } else {
// //       return ListTile(
// //         title: Text("No results found"),
// //         onTap: () {},
// //       );
// //     }
// //   }

// //   @override
// //   Widget buildSuggestions(BuildContext context) {
// //     return StaggeredGridView.countBuilder(
// //         itemCount: recentSearch.length,
// //         itemBuilder: (context, index) {
// //           return ListTile(
// //             title: Text(recentSearch[index]),
// //             trailing: Icon(
// //               Icons.arrow_forward_ios,
// //             ),
// //             onTap: () {},
// //           );
// //         }, staggeredTileBuilder: (int index) {  }, crossAxisCount: 4,);
// //   }
// // }