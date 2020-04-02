import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:track_corona/dialog.dart';

import 'endPoint.dart';

final String url = 'https://www.trackcorona.live/api/';
var log = Logger();


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
