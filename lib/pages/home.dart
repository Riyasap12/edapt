import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List images = [];
  int page = 1;

  @override

  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    new Future.delayed(new Duration(seconds: 2));
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001e9d94cfcac454d538030e468a28b78b5'
        }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12,top: 5,bottom: 5),
          child: Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),

            child: Center(
              child: Text(
                "All",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20,bottom: 3,right: 54),
        child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(32),border: Border.all(color: Colors.grey),),
          width: 260,height: 60,child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 21,top: 6,bottom: 6,right: 12),
              child: Icon(Icons.home,size: 35,color: Colors.grey[700],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,top: 6,bottom: 6,right: 12),
              child: Icon(Icons.search,size: 35,color: Colors.grey[700],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,top: 6,bottom: 6,right: 12),
              child: Icon(Icons.message,size: 35,color: Colors.grey[700],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,top: 6,bottom: 6,right: 8),
              child: Icon(Icons.supervised_user_circle_rounded,size: 35,color: Colors.grey[700],),
            ),
          ],),
          ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 12, right: 12,top: 12),
              child: StaggeredGridView.countBuilder(
                itemCount: images.length,


                crossAxisCount: 2,
                mainAxisSpacing: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: InkWell(
                        /*onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                    imageurl: images[index]['src']['large2x'],
                                  )));
                        },*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    images[index]['src']['tiny'],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 5, left: 8),
                                  child: Container(
                                    child: Text(
                                      images[index]['photographer'].toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    width: 110,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 17),
                                  child: IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.more_horiz_rounded)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
