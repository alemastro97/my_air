
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/Views/HomePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as br;

import '../../main.dart';
class ChangeImage extends StatefulWidget {
  final Function changeTopImage;


  ChangeImage({
    Key key,
    this.changeTopImage,
  }) : super (key: key);


  _ChangeImageState createState() => _ChangeImageState();
}
class  _ChangeImageState extends State<ChangeImage>{
  Io.File _image = null;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print(actualUser.img);

    return  FutureBuilder(
      future: _getImage(),
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
        child: Stack(
          children: [
            Center(
              child: _image != null ?
              Container(height:MediaQuery.of(context).size.height,decoration:BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(200.0)),child: FittedBox(fit:BoxFit.fill,child: CircleAvatar(backgroundImage: FileImage(_image), )))
              :
               CircleAvatar(backgroundImage: new AssetImage('assets/images/blank_profile.png'), radius: 200.0,),
        ),
            Align(
              alignment: Alignment.center,
              child:Container(
                width:( MediaQuery.of(context).size.height)/5,
                height: MediaQuery.of(context).size.height/5,

                child:Align(
                  alignment: Alignment.bottomRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.3,
                    heightFactor:0.3,
                    child: GestureDetector(
                      onTap: (){
                        _showPicker(context);
                      },
                      child: Container(
                        child:  Container(
                          // width:( MediaQuery.of(context).size.height)/10,
                          decoration:
                          BoxDecoration(color: Theme.of(context).accentColor,
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                LineAwesomeIcons.pen,
                                color: kDarkPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), /*Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                             // width:( MediaQuery.of(context).size.height)/10,
                              decoration:
                              BoxDecoration(color: Theme.of(context).accentColor,
                                  shape: BoxShape.circle
                              ),
                              child: Placeholder(),
                            ),
                          )//////Icon(
                            LineAwesomeIcons.pen,
                            color: kDarkPrimaryColor,
                          ),*/
              ),),

          ],
        ),



      );},
    );
  }
   _getImage() async {
    print("Entro in get Omage");
    widget.changeTopImage();
    if(actualUser.img != '') {
      print("--------------------"+actualUser.img.toString());
      imageCache.clear();
      imageCache.clearLiveImages();
       _image = await writeImageTemp(actualUser.img, 'image');
    }
  }

  /*Future<void> adjustImage() async{
    Io.File toAdjustFile = _image;
    br.Image toAdjust = br.decodeImage(toAdjustFile.readAsBytesSync());
    toAdjust = br.adjustColor(toAdjust, contrast: _contrast, brightness: _brightness, exposure: _exposure);
    setState(() {
      _imageWidget = Image.memory(br.encodeJpg(toAdjust));
    });
  }*/
//Todo capire come fare update senza ricaricare tutto
//TODO cambiare anche top image
  _imgFromCamera() async {
     final image =  (await picker.getImage(source: ImageSource.camera));
     actualUser.img = base64Encode(Io.File(image.path).readAsBytesSync()).toString();
     await DatabaseHelper().setImg(actualUser.email,base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    setState(()  {
      _image = Io.File(image.path);
      FirebaseDatabaseHelper().updateImage();

    });
  }

  _imgFromGallery() async {
    final image = await  picker.getImage( source: ImageSource.gallery);
    if(image!=null){}
    actualUser.img = base64Encode(Io.File(image.path).readAsBytesSync()).toString();
    await DatabaseHelper().setImg(actualUser.email,base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    setState(()  {
      _image = Io.File(image.path) ;
      FirebaseDatabaseHelper().updateImage();
    });
  }
  Future<Io.File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = Io.File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
