import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:authorizeit/Shared/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String cin;
  String qrContent = "";
  String qrScanError = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildCinField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'CIN',
        labelStyle: TextStyle(color: themeSecondaryColor),
        counterStyle: TextStyle(color: themeSecondaryColor),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: themeSecondaryColor,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: themeLightColor,
            )
        )
      ),
      style: TextStyle(color: Colors.white),
      maxLength: 10,
      validator: (String value) {
        if(value.isEmpty) {
          return 'Le CIN est requis!';
        }

        return null;
      },
      onSaved: (String value) {
        cin = value;
      },
    );
  }

  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        qrContent = qrResult;
        qrScanError = "";
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          qrScanError = "L'autorisation de la caméra a été refusée";
          qrContent = "";
        });
      } else {
        setState(() {
          qrScanError = "Une erreur inconnue : $ex";
          qrContent = "";
        });
      }
    } on FormatException {
      setState(() {
        qrScanError = "Vous avez appuiez sur le bouton de retour en arrière sans scannez aucune chose!";
        qrContent = "";
      });
    } catch (ex) {
      setState(() {
        qrScanError = "Une erreur inconnue : $ex";
        qrContent = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      buildCinField(),
                      SizedBox(height: 100,),
                      FlatButton(
                          child: Image(
                            image: AssetImage('assets/qr-code.png'),
                            height: 100,
                            width: 100,
                          ),
                          onPressed: () async {
                            if(!_formKey.currentState.validate()) {
                              return;
                            }

                            _formKey.currentState.save();

                            // launch the qr code scanner to get users info

                            await _scanQR();

                            // navigate to info page

                            if(qrContent.isNotEmpty) {
                              Navigator.pushNamed(context, '/info', arguments: {
                                "mkeddemCin": cin,
                                "qrContent": qrContent
                              });
                            }

                            if(qrScanError.isNotEmpty) {
                              Navigator.pushNamed(context, '/error', arguments: {
                                "error": qrScanError,
                              });
                            }

                          }
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
