import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'customColors.dart';

class DisplayMessage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 8,
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
                    child: Text("Unable to connect with the internet. Check your internet connection and try again", style: TextStyle(color: Colors.black, fontSize: 16),),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Try again', style: TextStyle(color: Colors.blue, fontSize: 16),),
                      onPressed: (){
                        Navigator.pop(context);
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
}
