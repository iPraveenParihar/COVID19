import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:track_corona/customColors.dart';
import 'package:track_corona/dialog.dart';
import 'endPoint.dart';

class ListData extends StatefulWidget {
  @override
  final List<Post> Data;
  final String DataName;
  ListData({this.Data, this.DataName});

  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {

  TextEditingController controller = new TextEditingController();
  var log = new Logger();

  List<Post> _searchResult = new List<Post>();


  onSearchTextChanged(String text) async {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }


    widget.Data.forEach((item) {
      if (item.location.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(item);

      }
    });

      setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("COVID-19 "+widget.DataName),
        ),

        body: widget.Data == null
            ? DisplayMessage()
            :Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(

                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: (text){

                      },
                    ),
                    trailing: IconButton(icon:  Icon(Icons.cancel), onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResult.isNotEmpty || controller.text.isNotEmpty
              ? ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (BuildContext context, int index){
                  return Center(

                    child: Card(
                      color: background,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text(_searchResult[index].location, style: TextStyle(color: Colors.white, fontSize: 20),),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(child: Text(_searchResult[index].confirmed.toString(), style: TextStyle(fontSize: 18, color: confirmed_indicate),),),
                                        ),
                                        Expanded(
                                          child: Center(child: Text(_searchResult[index].dead.toString(), style: TextStyle(fontSize: 18, color: dead_indicate),),),
                                        ),
                                        Expanded(
                                          child: Center(child: Text(_searchResult[index].recovered.toString(), style: TextStyle(fontSize: 18, color:recover_indicate),),),
                                        )
                                      ],
                                    ),
                                    Container(
                                        child:  Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text("updated: "+_searchResult[index].updated, style: TextStyle(fontSize: 12, color: Colors.white,),),
                                        )
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
                  : ListView.builder(
                itemCount: widget.Data.length,
                itemBuilder: (BuildContext context, int index){
                  return Center(

                    child: Card(
                      color: background,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text(widget.Data[index].location, style: TextStyle(color: Colors.white, fontSize: 20),),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(child: Text(widget.Data[index].confirmed.toString(), style: TextStyle(fontSize: 18, color: confirmed_indicate),),),
                                        ),
                                        Expanded(
                                          child: Center(child: Text(widget.Data[index].dead.toString(), style: TextStyle(fontSize: 18, color: dead_indicate),),),
                                        ),
                                        Expanded(
                                          child: Center(child: Text(widget.Data[index].recovered.toString(), style: TextStyle(fontSize: 18, color:recover_indicate),),),
                                        )
                                      ],
                                    ),
                                    Container(
                                        child:  Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text("updated: "+widget.Data[index].updated, style: TextStyle(fontSize: 12, color: Colors.white,),),
                                        )
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            )
          ],
        )
    );
  }
}

