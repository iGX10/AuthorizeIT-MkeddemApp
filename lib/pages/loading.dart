import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Map data = {};
  bool isInitialized = false;

  void authorizeCitizen(String cin, String qrContent) async {
    try {
      Response responseMkeddem = await get('https://my-json-server.typicode.com/iGX10/AuthorizeIT-MkeddemApp/mkeddems?cin=$cin');
      Map mkeddemData = jsonDecode(responseMkeddem.body)[0];

      Map citizenData = jsonDecode(qrContent);
      citizenData['mkeddem'] = mkeddemData['id'];

      Map<String, String> headers = {"Content-type": "application/json"};
      Response responsePostCitizen = await post('https://my-json-server.typicode.com/iGX10/AuthorizeIT-MkeddemApp/citoyens', headers: headers, body: jsonEncode(citizenData));
      Map postedCitizen = jsonDecode(responsePostCitizen.body);

      Navigator.pushReplacementNamed(context, '/authorized', arguments: {
        'nom': postedCitizen['nom'],
        'prenom': postedCitizen['prenom'],
      });
    }
    catch(e) {
      Navigator.pushReplacementNamed(context, '/error', arguments: {
        'error': e.toString()
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    authorizeCitizen(data['mkeddemCin'], data['qrContent']);

    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            )
        )
    );
  }
}
