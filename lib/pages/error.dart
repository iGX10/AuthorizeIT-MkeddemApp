import 'package:flutter/material.dart';
import 'package:authorizeit/Shared/constants.dart';

class Error extends StatelessWidget {

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
            children: <Widget>[
              Image.asset(
                'assets/close.png',
                height: 100,
                width: 100,
              ),
              SizedBox(height: 50,),
              Text(
                "Message d'erreur",
                style: TextStyle(
                  fontSize: 30,
                  color: themeSecondaryColor
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  data['error'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

