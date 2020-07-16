import 'package:flutter/material.dart';
import 'package:authorizeit/Shared/constants.dart';

class Authorized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: themePrimaryColor,
      appBar: AppBar(
        title: Text(
          'AuthorizeIT',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: themePrimaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/checkmark.png',
                height: 100,
                width: 100,
              ),
              SizedBox(height: 50,),
              Text(
                data['nom'],
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white
                ),
              ),
              Text(
                data['prenom'],
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 25,),
              Text(
                'est bien autorisé(e)',
                style: TextStyle(
                  fontSize: 24.0,
                  color: themeSecondaryColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
