import 'package:flutter/material.dart';

class Authorized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent[400],
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.lightGreenAccent[400],
                radius: 35,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40
                ),
              ),
              SizedBox(height: 50,),
              Text(
                '${data['nom']} ${data['prenom']}',
                style: TextStyle(
                    fontSize: 35.0
                ),
              ),
              SizedBox(height: 25,),
              Text(
                'est bien autorisé(e)',
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
