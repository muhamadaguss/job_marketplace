import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_marketplace/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImagePicker _imagePicker = ImagePicker();
  final Uuid uuid = const Uuid();
  ImageCubit() : super(const ImageState());

  void clearImage() {
    emit(state.copyWith(
      imagePath: null,
      imageFile: [],
    ));
  }

  void pickImage() async {
    XFile? imageFile0 =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    imageFile0 = await cropImage(imageFile0!);
    if (imageFile0 != null) {
      List<String> imageFile = [];
      imageFile.add(imageFile0.path);
      final imageUrl = await imageUpload(imageFile0);
      emit(state.copyWith(
        imagePath: imageFile0.path,
        imageFile: imageFile,
        imageUrl: imageUrl,
      ));
    } else {
      emit(state.copyWith(
        imagePath: null,
        imageFile: [],
      ));
    }
  }

  Future<XFile?> cropImage(XFile image) async {
    CroppedFile? cropFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      maxHeight: 800,
      maxWidth: 600,
      compressQuality: 70,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Color(kLightBlue.value),
          toolbarWidgetColor: Color(kLight.value),
          initAspectRatio: CropAspectRatioPreset.ratio5x4,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        )
      ],
    );
    if (cropFile != null) {
      return XFile(cropFile.path);
    } else {
      return null;
    }
  }

  Future<String?> imageUpload(XFile file) async {
    File image = File(file.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child('jobMarket')
        .child("${uuid.v1()}.jpg");
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
