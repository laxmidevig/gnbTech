import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  GoogleSignInAccount? _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/drive.file'],
  );

  Future<void> _handleSignIn() async {
    try {
      final user = await _googleSignIn.signIn();
      setState(() {
        _currentUser = user;
        print('user google$user');
      });
    } catch (error) {
      print('Google Sign-In error: $error');
    }
  }

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });

    if (image != null && _currentUser != null) {
      await uploadToGoogleDrive(File(image.path));
    }
  }

  Future<void> uploadToGoogleDrive(File file) async {
    final authHeaders = await _currentUser?.authHeaders;
    if (authHeaders == null) {
      print('Missing auth headers');
      return;
    }

    final client = GoogleHttpClient(authHeaders);

    final uri = Uri.parse("https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart");

    final fileBytes = await file.readAsBytes();
    final fileName = file.path.split('/').last;

    final request = http.MultipartRequest("POST", uri)
      ..fields['name'] = fileName
      ..files.add(http.MultipartFile.fromBytes('file', fileBytes, filename: fileName));

    request.headers.addAll(authHeaders);

    final response = await client.send(request);
    if (response.statusCode == 200) {
      print("File uploaded to Google Drive.");
    } else {
      print("Upload failed: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    _handleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    double s = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Pick Image",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: s * 0.055,
              color: Colors.white),
        ),
      ),
      body: Center(
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(File(_image!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

// Custom HTTP client for Google Auth
class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = IOClient();

  GoogleHttpClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
