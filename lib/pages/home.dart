import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

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
      decoration: InputDecoration(labelText: 'CIN du Mkeddem'),
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
          qrScanError = "Camera permission was denied";
          qrContent = "";
        });
      } else {
        setState(() {
          qrScanError = "Unknown Error $ex";
          qrContent = "";
        });
      }
    } on FormatException {
      setState(() {
        qrScanError = "You pressed the back button before scanning anything";
        qrContent = "";
      });
    } catch (ex) {
      setState(() {
        qrScanError = "Unknown Error $ex";
        qrContent = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: <Widget>[
                  Text(
                    'AuthorizeIT',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Bonjour,',
                    style: TextStyle(
                      fontSize: 22.0
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildCinField(),
                        SizedBox(height: 25,),
                        RaisedButton.icon(
                            onPressed: () async {
                              if(!_formKey.currentState.validate()) {
                                return;
                              }

                              _formKey.currentState.save();

                              // launch the qr code scanner to get users info

                              await _scanQR();
                              print('######################################');
                              print(qrScanError);
                              print(qrContent);
                              print('######################################');

                              // navigate to loading page, send cin and qrContent as arguments


                              if(qrContent.isNotEmpty) {
                                await Navigator.pushNamed(context, '/loading', arguments: {
                                  "mkeddemCin": cin,
                                  "qrContent": qrContent
                                });
                              }

                            },
                            icon: Icon(Icons.settings_overscan),
                            label: Text('Scanner'))
                      ],
                    ),
                  ),
                  SizedBox(height: 100,),
                  qrScanError.isNotEmpty?Text(
                    qrScanError,
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ):Text(
                    '',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 22.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
