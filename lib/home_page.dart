import 'dart:io';

import 'package:challenge_app/camera_page.dart';
import 'package:challenge_app/device_storage.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<File> writeCounter(int counter) async {
    final file = await deviceStorage.getLocalFile("counter.txt");
    return file.writeAsString('$counter');
  }

  void _onPress() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext buildContext) => CameraPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
