import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startup Name Generator",
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords());
  }
}
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);
  void _pushedSaved(){
    Navigator.of(context).push(
      MaterialPageRoute <void>(
          builder:(BuildContext context){
            final tiles = _saved.map(
                (WordPair pair) {
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                }
            );
            final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),
              body: ListView(children: divided,),
            );
          })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushedSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context,i) {
          if(i.isOdd) return Divider();

          final index = i ~/ 2;
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alredySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ), trailing:  Icon(
      alredySaved ? Icons.favorite :Icons.favorite_border,
      color: alredySaved? Colors.red : null,
    ), onTap: () {
        setState(() {
          if(alredySaved){
            _saved.remove(pair);
          } else _saved.add(pair);
        });
        },
    );
  }
}