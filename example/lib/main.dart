import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_button/loading_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final loadingController = StreamController<bool>();

  @override
  void dispose() {
    loadingController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(decoration: InputDecoration(labelText: "User")),
              TextFormField(decoration: InputDecoration(labelText: "Password")),
              SizedBox(height: 15),
              StreamBuilder<bool>(
                stream: loadingController.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return LoadingButton(
                    isLoading: snapshot.data,
                    onPressed: () {
                      loadingController.add(true);
                      Future.delayed(
                        Duration(seconds: 2),
                        () => loadingController.add(false),
                      );
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
