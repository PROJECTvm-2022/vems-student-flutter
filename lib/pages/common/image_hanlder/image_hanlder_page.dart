///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 12:29 am
///
import 'dart:io';
import 'package:vems/config/assets.dart';
import 'package:vems/widgets/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vems/widgets/photo_chooser.dart';

class ImageHandlerPage extends StatefulWidget {
  final List<File> files;

  const ImageHandlerPage(this.files);

  @override
  _ImageHandlerPageState createState() => _ImageHandlerPageState();
}

class _ImageHandlerPageState extends State<ImageHandlerPage> {
  List<File> images = [];
  PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    images = widget.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select files'),
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff161616),
        actions: [
          if (images.isNotEmpty)
            Center(
              child: Row(
                children: [
                  Text(
                    "${images.length} files selected",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                      icon: Icon(Icons.crop),
                      onPressed: () {
                        ImageCropper()
                            .cropImage(
                                sourcePath: images[currentIndex].path,
                                aspectRatioPresets: [],
                                androidUiSettings: AndroidUiSettings(
                                  toolbarTitle: 'Crop Your Image',
                                  toolbarColor: Get.theme.primaryColor,
                                  toolbarWidgetColor: Colors.white,
                                ),
                                iosUiSettings: IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                    title: 'Crop Your Image',
                                    aspectRatioLockEnabled: true,
                                    showCancelConfirmationDialog: true))
                            .then((File value) {
                          if (value != null) {
                            setState(() {
                              images[currentIndex] = value;
                            });
                          }
                        });
                      }),
                  const SizedBox(width: 8),
                ],
              ),
            ),
        ],
      ),
      backgroundColor: Color(0xff161616),
      body: Column(
        children: [
          Expanded(
            child: images.isEmpty
                ? Center(
                    child: Text(
                      "No images selected",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : PageView.builder(
                    controller: _controller,
                    itemCount: images.length,
                    onPageChanged: (i) {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    itemBuilder: (ctx, index) => Image.file(images[index]),
                  ),
          ),
          SizedBox(
            height: 90,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                _controller.animateToPage(currentIndex,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 65,
                              clipBehavior: Clip.antiAlias,
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 10),
                              child: Stack(children: [
                                Positioned.fill(
                                    child: Image.file(
                                  images[index],
                                  fit: BoxFit.cover,
                                )),
                                Positioned(
                                    right: 6,
                                    top: 5,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            images.remove(images[index]);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          MyAssets.cross,
                                          height: 20,
                                        )))
                              ]),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )),
                ),
                const SizedBox(width: 10),
                Container(
                  color: Color(0xff282828),
                  width: 1,
                  height: 60,
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () async {
                    final result = await Get.bottomSheet(
                        MultiPhotoChooser(title: 'Add more files'),
                        backgroundColor: Get.theme.scaffoldBackgroundColor);
                    if (result != null) {
                      setState(() {
                        images.addAll(result);
                      });
                    }
                  },
                  child: DottedBorder(
                    color: Color(0xff929292),
                    padding: const EdgeInsets.all(14),
                    radius: Radius.circular(4),
                    strokeWidth: 1,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () async {
                          // if (images.isNotEmpty) {
                          //   final result = await Get.bottomSheet(
                          //       AssignSubmitSheet(),
                          //       backgroundColor:
                          //           Theme.of(context).scaffoldBackgroundColor);
                          //
                          //   if (result != null) {
                          //     try {
                          //       setState(() {
                          //         isLoading = true;
                          //       });
                          //       final urls = await ApiCall.multiFileUpload(
                          //           images, 'assignments');
                          //       setState(() {
                          //         isLoading = false;
                          //       });
                          //       print("$urls");
                          //       Get.back(result: urls);
                          //     } catch (err) {
                          //       setState(() {
                          //         isLoading = false;
                          //       });
                          //       print("$err");
                          //       SnackBarHelper.show("", "$err");
                          //     }
                          //   }
                          // }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff3E9AFF).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
