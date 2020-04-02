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
        Container(
          child: Card(
            color: dead_indicate,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Connection Error", style: TextStyle(color: Colors.white, fontSize: 18),)
                    ,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text("Unable to connect with the internet. Check your internet connection and try again", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 16),),
                      onPressed: (){

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
