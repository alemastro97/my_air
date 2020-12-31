
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:myair/Services/Database_service/database_helper.dart';

import '../../main.dart';
class changeImage extends StatefulWidget {
  _changeImageState createState() => _changeImageState();
}
class  _changeImageState extends State<changeImage>{
  Io.File _image = new Io.File('');
  //Todo CreareImmagine
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print(actualUser.img);

    return  FutureBuilder(
      future: _getImage(),
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
//TODO inserire immaginer nel database e su fireb
        child: Stack(
          children: [
            Center(
              child: _image != null
                    ?
              CircleAvatar(backgroundImage: new FileImage(_image), radius: 200.0,)/* ClipRRect(
                borderRadius: BorderRadius.circular(300.0),

                  child: Image.file(
                    _image,
                    fit: BoxFit.fitHeight,
                  ),
                )*/
                    : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)),

                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),),


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
      await _image.writeAsBytes(base64Decode(actualUser.img));
      print(_image.toString());
  }

  _imgFromCamera() async {
     final image =  (await picker.getImage(source: ImageSource.camera));
     actualUser.img = base64Encode(Io.File(image.path).readAsBytesSync()).toString();
     await DatabaseHelper().setImg(actualUser.email,base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    setState(()  {
      _image = Io.File(image.path);

    });
  }

  _imgFromGallery() async {
    final image = await  picker.getImage( source: ImageSource.gallery);
    actualUser.img = base64Encode(Io.File(image.path).readAsBytesSync()).toString();
    await DatabaseHelper().setImg(actualUser.email,base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    setState(()  {
      _image = Io.File(image.path) ;

    });
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
