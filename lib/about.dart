import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:track_corona/customColors.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("About"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Container(
                child: Card(
                    elevation: 8,
                    color: background,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child:  Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(child: Text("Developed </> By", style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center,),),
                          ),
                          Center(child: Text("Praveen M", style: TextStyle(fontSize: 20, color: Colors.white),),),
                        ],
                      ),
                    )
                ),
              ),
              Container(
                child: Card(
                    elevation: 8,
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child:  Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(child: Text("This App is made possible by TrackCorona API", style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center,),),
                          ),
                          Center(child: Text("www.trackcorona.live", style: TextStyle(fontSize: 20, color: Colors.white),),),
                        ],
                      ),
                    )
                ),
              ),
              Container(
                child: Card(
                    elevation: 8,
                    color: emrald,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: Text("Stay Home and Be Safe", style: TextStyle(color: Colors.white, fontSize: 22),),
                      ),
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}
