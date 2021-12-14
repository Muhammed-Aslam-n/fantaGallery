import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';


List<File> imageList = [];

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? imagetoStore;

  @override
  void initState() {
    super.initState();
    debugPrint("");
  }

  Future pickImage({var location}) async {
    try {
      final imagethatpicking =
          await ImagePicker().pickImage(source: location);
      if (imagethatpicking == null) return null;
      debugPrint("Image toStore path is ${imagetoStore}");

      final imageTemporary = File(imagethatpicking.path);
      debugPrint("Image Temporary path is ${imageTemporary}");
      imageList.add(imageTemporary);
      final base = basename(imageTemporary.toString().trim());
      debugPrint(
          "the File Name is $base\n----------------------------------------------");

      Directory? directory = await getExternalStorageDirectory();
      final DirectoryPath = await directory!.path;
      debugPrint("The Path file going to save is $DirectoryPath");
      final File newImage = await imageTemporary.copy('${DirectoryPath}/$base');

      setState(() {
        this.imagetoStore = imageTemporary;
        GallerySaver.saveImage(imagetoStore!.path,albumName:'My photos');
      });
    } on PlatformException catch (e) {
      print('Failed To Pick Image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255,122,129,220),
                  gradient: LinearGradient(begin: Alignment(.5, 3.5), colors: [
                    Color.fromARGB(255, 122, 129, 220),
                    Color.fromARGB(255, 122, 129, 220),
                    Color.fromARGB(255, 136, 143, 223)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: Column(
                children: const [
                  SizedBox(
                    height: 60,
                  ),
                  ListTile(
                    title: Text(
                      "\t\t\t\t\t\tFantaGallery",
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,fontFamily: "viga"),
                    ),
                    subtitle: Text(
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\tgrabs your Personal ",
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          letterSpacing: 1.2,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w700,
                      fontFamily: "pacifico"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Card(
              margin: EdgeInsets.all(20),
              shadowColor: Color.fromARGB(255, 122, 129, 220),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Save your personals , Keep yourself inside !",
                  style: TextStyle(
                      wordSpacing: 1.2,
                      letterSpacing: 0.7,
                      color: Color.fromARGB(255, 122, 129, 220)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await pickImage(location: ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Color.fromARGB(255, 122, 129, 220),
                    size: 60,
                    semanticLabel: "Pick from Gallery",
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () async {
                      // await getPermission(ImageSource.camera);
                      pickImage(location:ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Color.fromARGB(255, 122, 129, 220),
                      size: 60,
                      semanticLabel: "Pick from Camera",
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color:Color.fromARGB(240, 136,143,223),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: const Text(
                "FataGallery minds your Data and Stores locally \nWe are concerned about your Privacy\nFeel free to use",
              style: TextStyle(wordSpacing: 1.3,letterSpacing: 1.3,color: Colors.white),
              ),
            ),SizedBox(
              height: 20,
            ),
            Align(
              child: ElevatedButton(
                onPressed: (){
                  debugPrint('Gallery View Clicked');
                  Navigator.pushNamed(context, '/gallery');
                },
                child: Text("Discover you !",style: TextStyle(color: Color.fromARGB(240, 136,143,223)),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // getPermission(location) async{
  //   var status = await Permission.camera.status;
  //   if(!status.isGranted){
  //     PermissionStatus permissionStatus = await Permission.camera.request();
  //     print("\n--------------------------\nPermission Status is ${permissionStatus.isGranted}\n------------------------");
  //   }else{
  //     pickImage(location: location);
  //   }
  // }
}

// String newPath = "";
// List<String> folders = DirectoryPath.split("/");
// for (var value in folders) {
//   print(value);
//   if (value != "Android") {
//     newPath += value + "/";
//   } else {
//     break;
//   }
// }
//
// debugPrint("Before Assigning folder name " + newPath);
// newPath = newPath + "Fgallery";
// debugPrint("After Assigning folder name " + newPath);
//
// Directory dummyDir = Directory(newPath);
// print("Dummy Directory is $dummyDir");
// final editDirectory = dummyDir.path;
// print("Secondary Folder Directory is $editDirectory");
// if (!await dummyDir.exists()) {
//   print("Not Exists");
// } else {
//   print("Exists");
// }
