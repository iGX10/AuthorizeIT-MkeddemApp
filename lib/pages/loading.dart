import 'package:authorizeit/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:authorizeit/Shared/constants.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Map data = {};
  bool isInitialized = false;

  void authorizeCitizen(String id, String qrContent) async {
    try {
      Map citizenData = jsonDecode(qrContent);
      citizenData['mkeddem'] = id;

      Map<String, String> headers = {"Content-type": "application/json"};
      Response responsePostCitizen = await post(api_base_url+citizens_url, headers: headers, body: jsonEncode(citizenData));
      if(responsePostCitizen.statusCode == 201) {
        Map postedCitizen = jsonDecode(responsePostCitizen.body);

        Navigator.pushReplacementNamed(context, '/authorized', arguments: {
          'nom': postedCitizen['nom'],
          'prenom': postedCitizen['prenom'],
        });
      }
      else {
        Navigator.pushReplacementNamed(context, '/error', arguments: {
          "error": "Erreur lors de l'appel d'une ressource : "+responsePostCitizen.body,
        });
      }

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
    authorizeCitizen(data['mkeddemId'], data['qrContent']);

    return Scaffold(
        backgroundColor: themePrimaryColor,
        body: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            )
        )
    );
  }
}
