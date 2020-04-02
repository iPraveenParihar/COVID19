import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:track_corona/customColors.dart';
import 'package:track_corona/getData.dart';
import 'package:track_corona/homePage.dart';
import 'package:track_corona/dialog.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  bool isConnected = false;

  void initState()
  {
    checkConnectivity().then((result){
      isConnected = result;

    });
  }

  Future<bool> checkConnectivity() async{
    var result = await (Connectivity().checkConnectivity());
    if(result == ConnectivityResult.none){
      return false;
    }

    setState(() {
      isConnected = true;
    });

    return true;
  }

  Widget showDialog()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Connection Error", style: TextStyle(color: Colors.red, fontSize: 18,),)
                    ,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text("Unable to connect with the server. Check your internet connection and try again", style: TextStyle(color: Colors.black, fontSize: 16),),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Try again', style: TextStyle(color: Colors.blue, fontSize: 16),),
                      onPressed: (){
                        checkConnectivity();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget showLoader()
  {
    return Material(
      color: background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Checking...", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ?HomePage()
        :showDialog();
  }
}
