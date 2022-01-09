import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';
import 'package:pizza_time/widgets/snack/snack.dart';

class UploadImgInFirebase extends StatefulWidget {
  final void Function(String value) onUplodinSuccess;

  final String? path;
  UploadImgInFirebase(
      {Key? key, required this.onUplodinSuccess, this.path = 'images/users'})
      : super(key: key);

  @override
  _UploadImgInFirebaseState createState() => _UploadImgInFirebaseState();
}

class _UploadImgInFirebaseState extends State<UploadImgInFirebase> {
  late double _progress;
  late bool _isUploading;
  late String _error;
  void initState() {
    _progress = 0.0;
    _isUploading = false;
    _error = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: _isUploading == false
          ? ButtonDefault(
              borderRadiusInlWell: BorderRadius.all(Radius.circular(20)),
              decoration: BoxDecoration(
                  color: AppColors.red[200],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.upload,
                      color: AppColors.write,
                      size: 16,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      FlutterI18n.translate(context, 'profile.avatar'),
                      style: TextStyle(color: AppColors.write),
                    )
                  ],
                ),
              ),
              onPress: () {
                _openGallery(context);
              },
            )
          : Text(
              "${FlutterI18n.translate(context, 'label.uploading')} ${_progress.toStringAsFixed(0)}%"),
    );
  }

  void _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _uploadImg(image.path, image.name);
    }
  }

  Future<void> _uploadImg(String filePath, String name) async {
    File largeFile = File(filePath);
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('/${widget.path}/$name')
        .putFile(largeFile);
    setState(() {
      _isUploading = true;
      _error = "";
    });
    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      log("uploding: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}");
      setState(() {
        _progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });
    }, onError: (e) {
      String error = task.snapshot.toString();
      if (e.code == 'permission-denied') {
        error = 'User does not have permission to upload to this reference.';
      }
      setState(() {
        _error = error;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar(error));
    });

    try {
      await task;
      setState(() {
        _isUploading = false;
        _progress = 0.0;
        _error = "";
      });
      final url = await task.snapshot.ref.getDownloadURL();
      widget.onUplodinSuccess(url);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        setState(() {
          _error = 'User does not have permission to upload to this reference.';
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar(
            'User does not have permission to upload to this reference.'));
      }
    }
  }
}
