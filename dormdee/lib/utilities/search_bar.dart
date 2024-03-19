import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(builder: (context, controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: SearchBar(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 245, 245, 245)),
          elevation: MaterialStateProperty.all<double?>(0),
          controller: controller,
          leading: const Icon(Icons.search),
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 20, vertical: 0)),
          hintText: 'Search for dormitoriy...',
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
        ),
      );
    }, suggestionsBuilder: (context, controller) {
      return List<ListTile>.generate(5, (index) {
        return ListTile(
          title: Text('Suggestion $index'),
          onTap: () {
            controller.closeView("Suggestion $index");
          },
        );
      });
    });
  }
}
