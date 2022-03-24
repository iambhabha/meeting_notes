// import 'package:cmp/Notes/db/notes_database.dart';
// import 'package:cmp/Notes/model/note.dart';
// import 'package:cmp/Notes/note_detail_page.dart';
// import 'package:cmp/Notes/widget/note_card_widget.dart';
// import 'package:cmp/Notes/widget/search_widget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// class datasearch extends SearchDelegate<String> {
//   final search = ["call of duty", "clash of clan", "dfjskdfdnfjn"];
//   final recentsearch = [
//     "testing ",
//     "testing ",
//     "testing ",
//     "testing ",
//     "testing ",
//   ];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {},
//         icon: Icon(Icons.clear),
//       )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//       onPressed: () {},
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty ? recentsearch : search;

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         leading: Icon(Icons.pages_outlined),
//         title: Text(suggestionList[index]),
//       ),
//       itemCount: suggestionList.length,
//     );

//     // return StaggeredGridView.countBuilder(
//     //   crossAxisCount: 2,
//     //   staggeredTileBuilder: (index) => StaggeredTile.fit(2),
//     //   itemBuilder: (context, index) {
//     //     var notes;
//     //     final note = notes[index];

//     //     return GestureDetector(
//     //       onTap: () async {
//     //         await Navigator.of(context).push(MaterialPageRoute(
//     //           builder: (context) => NoteDetailPage(noteId: note.id!),
//     //         ));
//     //       },
//     //       child: NoteCardWidget(note: note, index: index),
//     //     );
//     //   },
//     // );
//   }
// }
