import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:excel/excel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: SearchFieldSample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchFieldSample extends StatefulWidget {
  const SearchFieldSample({Key? key}) : super(key: key);

  @override
  State<SearchFieldSample> createState() => _SearchFieldSampleState();
}

class _SearchFieldSampleState extends State<SearchFieldSample> {
  int suggestionsCount = 2;
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final suggestions = ['ABC', 'ACD', 'DEF', 'GHI', 'JKL'];
    final TextEditingController _controller = new TextEditingController();
    var items = [
      'Working a lot harder',
      'Being a lot smarter',
      'Being a self-starter',
      'Placed in charge of trading charter'
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('Dynamic sample Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              suggestionsCount++;
              suggestions.add('suggestion $suggestionsCount');
            });
          },
          child: Icon(Icons.add),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'serial number',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'bilty number',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'date',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Freight',
              ),
            ),
            SearchField(
              onSearchTextChanged: (query) {
                final filter = suggestions
                    .where((element) =>
                        element.toLowerCase().contains(query.toLowerCase()))
                    .toList();
                return filter
                    .map((e) => SearchFieldListItem<String>(e))
                    .toList();
              },
              key: const Key('searchfield'),
              hint: 'Search by country name',
              suggestions: suggestions
                  .map((e) => SearchFieldListItem<String>(e))
                  .toList(),
              focusNode: focus,
              suggestionState: Suggestion.expand,
              onSuggestionTap: (SearchFieldListItem<String> x) {
                focus.unfocus();
              },
            ),
            //text field with only two inputes consignee and consigner
            Row(
              children: <Widget>[
                new Expanded(child: new TextField(controller: _controller)),
                new PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      _controller.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    })
              ],
            )
          ]),
        ));
  }
}
