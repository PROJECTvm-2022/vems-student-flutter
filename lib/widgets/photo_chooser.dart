import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vems/utils/snackbar_helper.dart';

///
/// Created by Sunil Kumar on 01-07-2020 09:15 PM.
///
class PhotoChooser extends StatelessWidget {
  final String title;

  const PhotoChooser({this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 22,
          ),
          Text(
            title ?? 'Choose from a source',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          DefaultTextStyle(
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.camera, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera,
                            size: 60, color: MyColors.brightPrimary),
                        Text(S.of(context).camera)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 38,
                ),
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.gallery, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 60,
                          color: MyColors.brightPrimary,
                        ),
                        Text(S.of(context).gallery)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 0, color: Colors.grey),
          FlatButton(
            textColor: colorScheme.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: Center(child: Text('Cancel')),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _chooseImage(ImageSource source, BuildContext context) {
    ImagePicker()
        .getImage(
      source: source,
    )
        .then((file) {
      if (file != null && file.path != null && file.path.isNotEmpty) {
        ImageCropper()
            .cropImage(
                sourcePath: file.path,
                maxWidth: 500,
                maxHeight: 500,
                aspectRatioPresets: [
                  CropAspectRatioPreset.square,
                ],
                androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Crop your image',
                  toolbarColor: Theme.of(context).colorScheme.primary,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.square,
                  lockAspectRatio: true,
                ),
                iosUiSettings: IOSUiSettings(
                    minimumAspectRatio: 1.0,
                    title: 'Crop Your Image',
                    aspectRatioLockEnabled: true,
                    showCancelConfirmationDialog: true))
            .then((File value) {
          if (value.path != null && value.path.isNotEmpty) {
            Navigator.pop(context, value);
          } else {
            Get.snackbar('Oops', 'Error while cropping image',
                snackPosition: SnackPosition.BOTTOM,
                snackStyle: SnackStyle.FLOATING,
                animationDuration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(16));
          }
        }).catchError((error, s) {
          print('Crop error $error $s');
        });
      }
    }).catchError((error) {
      Get.snackbar('Oops', 'Please allow permission to upload image.',
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          animationDuration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(16));
    });
  }
}

_chooseImage(ImageSource source, BuildContext context) {
  ImagePicker()
      .pickImage(
    source: source,
  )
      .then((file) {
    if (file != null && file.path != null && file.path.isNotEmpty) {
      ImageCropper()
          .cropImage(
              sourcePath: file.path,
              // maxWidth: 500,
              // maxHeight: 500,
              aspectRatioPresets: [
                // CropAspectRatioPreset.square,
              ],
              androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Crop Your Image',
                toolbarColor: Get.theme.primaryColor,
                toolbarWidgetColor: Colors.white,
                // initAspectRatio: CropAspectRatioPreset.square,
                // lockAspectRatio: true,
              ),
              iosUiSettings: IOSUiSettings(
                  minimumAspectRatio: 1.0,
                  title: 'Crop Your Image',
                  aspectRatioLockEnabled: true,
                  showCancelConfirmationDialog: true))
          .then((File value) {
        if (value != null && value.path != null && value.path.isNotEmpty) {
          Navigator.pop(context, value);
        }
      });
    }
  }).catchError((error) {
    SnackBarHelper.show('Error', 'Please allow permission to upload image.');
  });
}

class PhotoChooserWidget extends StatelessWidget {
  final bool isMultiple;
  final Function(List<File> files) onSelected;

  const PhotoChooserWidget({
    this.isMultiple = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconContainer(
            title: 'Take Picture',
            type: 1,
            onTap: () {
              chooseImages(1);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: IconContainer(
            title: 'Upload from device',
            type: 2,
            onTap: () {
              chooseImages(2);
            },
          ),
        ),
      ],
    );
  }

  chooseImages(int type) async {
    try {
      if (type == 1) {
        // camera
        final file = await ImagePicker().pickImage(source: ImageSource.camera);
        if (file != null && file.path != null && file.path.isNotEmpty) {
          onSelected?.call([File(file.path)]);
        }
      } else {
        // gallery
        final value = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: true);
        if (value != null) {
          final files = value.paths.map((e) => File(e)).toList();
          onSelected?.call(files);
        }
      }
    } catch (err) {}
  }
}

class IconContainer extends StatelessWidget {
  final String title;
  final int type;
  final VoidCallback onTap;

  const IconContainer({this.title, this.type = 1, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            Icon(type == 1 ? Icons.camera : Icons.photo,
                size: 60, color: MyColors.brightPrimary),
            const SizedBox(height: 16),
            Text("$title"),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffCEDCE5)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class MultiPhotoChooser extends StatelessWidget {
  final String title;

  const MultiPhotoChooser({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "Choose photo",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 22),
          child: PhotoChooserWidget(
            onSelected: (files) {
              Get.back(result: files);
            },
          ),
        ),
      ],
    );
  }
}
