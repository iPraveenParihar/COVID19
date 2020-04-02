import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:track_corona/endPoint.dart';
import 'package:track_corona/listView.dart';
import 'package:track_corona/customColors.dart';
import 'package:track_corona/getData.dart';
import 'package:track_corona/about.dart';

class HomePage extends StatefulWidget {

  State<StatefulWidget> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
{

  List<Post> _countryData, _cityData;
  int totalConfirmed = 0, totalDead = 0, totalRecovered = 0;
  bool isLoading = true;

  final String about = "COVID-19 is a never before encountered member of the coronavirus family. "
      "Fostering its growth in a Wuhan food market, the virus has now spread to 190+ nations.";
  final String version = "ve 0.1.1";

  var log = Logger();

  Comparator<Post> nameCompare = (a, b) => a.confirmed.compareTo(b.confirmed);

  @override
  void initState()
  {

    fetchData('countries/').then((data){
      totalRecovered = 0; totalConfirmed = 0; totalDead = 0;
      _countryData = data;
      for(int i = 0; i < _countryData.length; i++){
        totalConfirmed += _countryData[i].confirmed;
        totalDead += _countryData[i].dead;
        totalRecovered += _countryData[i].recovered;
      }
    });

    fetchData('cities/').then((data){
      _cityData = data;
      _cityData.sort();
      setState(() {
        isLoading = false;
      });

    });
  }

  Future<List<Post>> fetchData(String endPoint) async
  {
    try
    {
      final response = await http.get(url+endPoint);

      if(response.statusCode == 200)
      {
        Map<String,dynamic> map = new Map<String,dynamic>();
        map = json.decode(response.body);

        List<dynamic> jsonData = map['data'];
        List<Post> data = List<Post>();

        for(int i = 0; i < jsonData.length; i++){
          var _post = Post.fromJson(jsonData[i]);
          data.add(_post);
        }
        data.sort();

        return data;
      }
      else{
        throw Exception('Failed to load data:'+response.statusCode.toString());
      }

    }
    catch(Exception){
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Track Corona"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Text(about, style: TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center,),),
                decoration: BoxDecoration(
                    color: background
                ),
              ),
              ListTile(
                title: Text("Country", style: TextStyle(fontSize: 22),),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListData(Data: _countryData, DataName: "Country Report")));
                },
              ),
              Divider(),
              ListTile(
                title: Text("City",style: TextStyle(fontSize: 22),),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListData(Data: _cityData, DataName: "City/State Report")));
                },
              ),
              Divider(),
              ListTile(
                title: Text("About",style: TextStyle(fontSize: 22),),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
                } ,
              ),
              Divider(),
              ListTile(
                title: Text(version, style: TextStyle(fontSize: 18),),
              )
            ],
          ),
        ),
        body: Container(
            color: background,
            child: isLoading
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Counting...", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  )
                ],
              ),
            )
                : Column(
              children: <Widget>[
                Container(
                  height: 50,
                ),
                Expanded(
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(totalConfirmed.toString(), style: TextStyle(fontSize: 40, color: confirmed_indicate),),
                          ),
                          Container(
                            child: Text("Confirmed", style: TextStyle(fontSize: 38, color: Colors.white70),),
                          )
                        ],
                      )
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(totalDead.toString(), style: TextStyle(fontSize: 40, color: dead_indicate),),
                          ),
                          Container(
                            child: Text("Dead", style: TextStyle(fontSize: 38, color: Colors.white70),),
                          )
                        ],
                      )
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(totalRecovered.toString(), style: TextStyle(fontSize: 40, color: recover_indicate),),
                          ),
                          Container(
                            child: Text("Recovered", style: TextStyle(fontSize: 38, color: Colors.white70),),
                          )
                        ],
                      )
                  ),
                ),
              ],
            )
        )
    );
  }
}