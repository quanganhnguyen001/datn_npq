import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
  ];

  List<String> _filteredItems = [];

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = [];
      });
    } else {
      setState(() {
        _filteredItems = _allItems.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Example'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => _filterItems(query),
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(child: Text('No items to display'))
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredItems[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
