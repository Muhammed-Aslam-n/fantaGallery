import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryViewer extends StatefulWidget {
  const GalleryViewer({Key? key}) : super(key: key);

  @override
  _GalleryViewerState createState() => _GalleryViewerState();
}

late String directory;
List file = [];

@override
class _GalleryViewerState extends State<GalleryViewer> {
  void initState() {
    super.initState();
    _listofFiles();
  }

  var sliverBackGround = Image.asset("assets/background.jpg");

  void _listofFiles() async {
    Directory? directory = await getExternalStorageDirectory();
    final pathDir = await directory!.path;
    debugPrint("File Location path in GalleryView is $pathDir");
    setState(() {
      file = Directory("$pathDir").listSync();
    });
    debugPrint(file.length.toString());
  }

  Widget NoItem() {
    return Center(
        child: Text("No Images Added",
            style: TextStyle(fontSize: 22, color: Colors.white60)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: sliverBackGround,
                title: Text(
                  "FantaGallery",
                  style: TextStyle(
                      color: Color.fromARGB(255, 136, 143, 223),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "viga"),
                ),
              ),
              expandedHeight: 200,
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(1, index.isEven ? 2 : 1),
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 13,
                  itemCount: file.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>file.isEmpty?Text("No Images Addesd yet !",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color:Color.fromARGB(255, 122, 129, 220)),):buildCardImage(index),
                ),
              ),
            ),
          ],
        ));
  }
}

Widget buildCardImage(index) {
  return Container(
    margin: EdgeInsets.all(8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        file[index],
        fit: BoxFit.cover,
      ),
    ),
  );
}
// ListView.builder(itemCount: file.length,
// itemBuilder: (BuildContext context, int index) {
// return file.isEmpty ? NoItem():imageTile(index: index);
// }
