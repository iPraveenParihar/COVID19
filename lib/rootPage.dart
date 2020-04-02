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

  bool isConnected = false, isLoading = true;

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
      isLoading = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background,
        child: isLoading
        ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Loading...", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
            )
          ],
        ))
        : isConnected
          ? HomePage()
          : DisplayMessage(),
      ),
    );
  }
}
