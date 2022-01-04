import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImage extends StatefulWidget {
  PickImage(this.filepickfn);

  final Function(File pickedImage) filepickfn;

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _pickedImage;
  void _imgFromCamera() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 120,
      maxWidth: 120,
    );
    setState(() {
      _pickedImage = File(imageFile!.path);
    });
    widget.filepickfn(File(imageFile!.path));
  }

  void _imgFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 120,
      maxWidth: 120,
    );

    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.filepickfn(_pickedImage as File);
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: _pickedImage == null
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: FileImage(_pickedImage as File),
                ),
        ))
      ],
    );
  }
}
