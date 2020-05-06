import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  String _enteredValue;

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
            RaisedButton(
              child: Text('Click Me'),
              onPressed: () async {
                final result = await showDialog<String>(
                    context: context, builder: (context) => InputDialog());
                setState(() {
                  _enteredValue = result;
                });
              },
            ),
            ...?_enteredValue == null
                ? null
                : [
                    Text('You entered: '),
                    Text(
                      _enteredValue,
                      key: Key('result'),
                    ),
                  ],
          ],
        ),
      ),
    );
  }
}

class InputDialog extends StatefulWidget {
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _formKey = GlobalKey<FormState>();
  String _result;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Example Dialog'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          onSaved: (value) => _result = value,
          decoration: InputDecoration(
            icon: Icon(Icons.cloud_download),
            labelText: 'Enter some text',
          ),
          keyboardType: TextInputType.url,
          autofocus: true,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Navigator.of(context).pop(_result);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Ok'),
        )
      ],
    );
  }
}
