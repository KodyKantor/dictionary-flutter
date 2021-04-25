import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DictModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DictHome(title: 'Dictionary Home'),
    );
  }
}

class DictHome extends StatefulWidget {
  DictHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DictHomeState createState() => _DictHomeState();
}

class _DictHomeState extends State<DictHome> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget textBox = Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search for a definition',
              ),
              onSubmitted: (String word) {
                // Get this context's DictModel and retrieve the definition.
                Provider.of<DictModel>(context, listen: false).retrieve(word);
              },
            ),
            Container(
                padding: const EdgeInsets.only(top: 32),
                child: Consumer<DictModel>(builder: (context, dict, child) {
                  return Column(children: [
                    Text(dict.getWord()),
                    Text(dict.getDefinition())
                  ]);
                }))
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [textBox]),
    );
  }
}

class DictModel extends ChangeNotifier {
  // TODO: Refactor to map of word:definition.
  List<String> _words = ['prometheus'];

  // TODO: Refactor to a single structure.
  String word = 'prometheus';
  String definition = 'the beginning';

  UnmodifiableListView<String> get words => UnmodifiableListView(_words);

  String getWord() {
    return this.word;
  }

  String getDefinition() {
    return this.definition;
  }

  void retrieve(String word) {
    // TODO: Set the model's current word:definition pair so it can be retrieved
    // in the view.

    notifyListeners();
  }
}
