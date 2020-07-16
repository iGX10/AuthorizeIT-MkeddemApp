import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:authorizeit/Shared/constants.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Info extends StatefulWidget {

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Map data = {};

  Map qrContent = {};

  String reasonName = '...';

  String citizenStatus = '...';

  void getReasonName(context, id) async {
    try{
      Response response = await get(api_base_url+reasons_url+id);
      Map data = jsonDecode(response.body);
      if(response.statusCode == 200) {
        setState(() {
          reasonName = data['nom'];
        });
      }
      else {
        Navigator.pushReplacementNamed(context, '/error', arguments: {
          "error": "Erreur lors de l'appel d'une ressource : "+response.body,
        });
      }
    }
    catch(e) {
      Navigator.pushReplacementNamed(context, '/error', arguments: {
        "error": e.toString(),
      });
    }
  }

  void getCitizenStatus(context, cin) async {
    try{
      Response response = await get(api_base_url+citizens_url+'?cin='+cin);
      List data = jsonDecode(response.body);
      if(response.statusCode == 200) {
        if(data.length != 0) {
          setState(() {
            citizenStatus = "Autorisé(e)";
          });
        }
        else {
          setState(() {
            citizenStatus = "Non autorisé(e)";
          });
        }
      }
      else {
        Navigator.pushReplacementNamed(context, '/error', arguments: {
          "error": "Erreur lors de l'appel d'une ressource : "+response.body,
        });
      }
    }
    catch(e) {
      Navigator.pushReplacementNamed(context, '/error', arguments: {
        "error": e.toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    qrContent = jsonDecode(data['qrContent']);

    getReasonName(context, qrContent['raison']);
    getCitizenStatus(context, qrContent['cin']);

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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Status',
                  style: TextStyle(
                      fontSize: 18,
                      color: themeSecondaryColor,
                      letterSpacing: 2
                  ),
                ),
                Text(
                  citizenStatus,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18,),
                Text(
                  'CIN',
                  style: TextStyle(
                    fontSize: 18,
                    color: themeSecondaryColor,
                    letterSpacing: 2
                  ),
                ),
                Text(
                  qrContent['cin'],
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18,),
                Text(
                  'Nom & Prénom',
                  style: TextStyle(
                      fontSize: 18,
                      color: themeSecondaryColor,
                      letterSpacing: 2
                  ),
                ),
                Text(
                  '${qrContent['nom']} ${qrContent['prenom']}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18,),
                Text(
                  'Adresse',
                  style: TextStyle(
                      fontSize: 18,
                      color: themeSecondaryColor,
                      letterSpacing: 2
                  ),
                ),
                Text(
                  qrContent['adresse'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18,),
                Text(
                  'Raison',
                  style: TextStyle(
                      fontSize: 18,
                      color: themeSecondaryColor,
                      letterSpacing: 2
                  ),
                ),
                Text(
                  reasonName,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50,),
                citizenStatus=='Non autorisé(e)'?Center(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    color: themeSecondaryColor,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/loading', arguments: {
                        "mkeddemCin": data['mkeddemCin'],
                        "qrContent": data['qrContent']
                      });
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 2
                      ),
                    ),
                  ),
                ):SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
