import 'package:flutter/material.dart';

class Info extends StatelessWidget {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('AuthorizeIT'),),
      body: Column(
        children: <Widget>[
          Text('DATA : ${data['mkeddemCin']}, ${data['qrContent']}'),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loading', arguments: {
                "mkeddemCin": data['mkeddemCin'],
                "qrContent": data['qrContent']
              });
            },
            child: Text('Valider'),
          )
        ],
      ),
    );
  }
}
