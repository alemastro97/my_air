import 'dart:convert';
import 'dart:io' as Io;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:myair/main.dart';

class ChangeImage extends StatefulWidget {
  @override
  _ChangeImageState createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  Io.File _image; //File in which the image will be loaded and updated
  final picker = ImagePicker(); //Extract the image in camera/folder

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( //It will load the image as soon as _getImage() function return the future
      future: _getImage(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
          child: Stack(
            children: [
              //User Image
              Center(
                child: _image != null //Checking of the image presence
                    ? Container( //in case the image is different from null it loads the image selected by the user or already in the google account
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200.0)),
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundImage: FileImage(_image),
                            )))
                    : CircleAvatar( //Otherwise it loads a default user image
                        backgroundImage:
                            new AssetImage('assets/images/blank_profile.png'),
                        radius: 200.0,
                      ),
              ),
              //Image changer
              Align( // This is the pen with which you can change the profile image
                alignment: Alignment.center,
                child: Container(
                  width: (MediaQuery.of(context).size.height) / 5,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.3,
                      heightFactor: 0.3,
                      child: GestureDetector( //Detect the tap on the icon
                        onTap: () {
                          _showPicker(context); // Shows a menu in which you can selected between: take the picture with the camera and take it from the gallery
                        },
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                shape: BoxShape.circle),
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
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //getter of the image in case the user already has one
  _getImage() async {
    if (actualUser.img != '') {
      //Clear the cache image in order to not pick the previous one
      imageCache.clear();
      imageCache.clearLiveImages();
      //It generates a temporary image file in order to make all the operation to tranform the string in an IMAGE
      _image = await writeImageTemp(actualUser.img, 'image');
    }
  }

  //Get image from the camera
  _imgFromCamera() async {
    //Get the image from the camera with the ImagePicker Plugin
    final image = (await picker.getImage(source: ImageSource.camera));
    //Save the image in the user account and database as a string of bytes
    actualUser.updateUserImg(base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    //Set the state of the widget in order to show the new image
    setState(() {
      _image = Io.File(image.path);
    });
  }
  //Get image from the gallery
  _imgFromGallery() async {
    //Get the image from the gallery with the ImagePicker Plugin
    final image = await picker.getImage(source: ImageSource.gallery);
    //Save the image in the user account and update both databases
    actualUser.updateUserImg(base64Encode(Io.File(image.path).readAsBytesSync()).toString());
    //Set the state of the widget in order to show the new image
    setState(() {
      _image = Io.File(image.path);
    });
  }

  //Generate a file in which is possible to manipulate the strings and convert it in bytes
  Future<Io.File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = Io.File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }

  //source selector of the images
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
        });
  }
}
