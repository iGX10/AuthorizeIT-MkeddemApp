import 'package:flutter/material.dart';

class Error extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Erreur'),
        backgroundColor: Colors.red[800],
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.red[800],
                radius: 35,
                child: Text(
                  'X',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Text(
                data['error'],
                style: TextStyle(
                    fontSize: 22.0
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

