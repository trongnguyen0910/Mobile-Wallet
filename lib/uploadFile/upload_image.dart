import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdproject/uploadFile/upload_success.dart';

import '../home.dart';
import '../page/profile.dart';
import '../page/thanksyoupage.dart';

class ImageUploaderWidget extends StatefulWidget {
  const ImageUploaderWidget({Key? key}) : super(key: key);
  @override
  _ImageUploaderWidgetState createState() => _ImageUploaderWidgetState();
}
class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  final picker = ImagePicker();
  File? _image;
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }
  Future uploadImage() async {
    if (_image == null) {
      return;
    }
   
    final url = 'https://node-js-fpt-wallet.herokuapp.com/services/images';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['accept'] = 'application/json';
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path, contentType: MediaType('image', 'jpeg')));
    request.fields['note'] = 'ok';
    final response = await request.send();
    final content = await response.stream.bytesToString();
    final jsonData = json.decode(content);
    final imageUrl = jsonData['data'];
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('imageUrl', imageUrl);
    print(content);
    if (content != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadSuccess()),
    );
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        // tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
        
      ),
      
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              uploadImage();
            },
            child: Text('Upload Image'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
