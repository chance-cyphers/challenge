import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CameraPageState();

}

class _CameraPageState extends State<CameraPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("the new page"),
      ),
      body: const Text("placeholder body"),
    );
  }

}