///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 12:27 am
///

import 'dart:io';
import 'package:vems/config/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ImageListViewPage extends StatefulWidget {
  final String appBarName;
  final List<String> images;
  final List<File> fileImages;

  const ImageListViewPage({this.images, this.fileImages, this.appBarName = ''});

  @override
  _ImageListViewPageState createState() => _ImageListViewPageState();
}

class _ImageListViewPageState extends State<ImageListViewPage> {
  List<String> get images => widget.images;

  List<File> get fileImages => widget.fileImages;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
                itemCount:
                    fileImages == null ? images.length : fileImages.length,
                itemBuilder: (ctx, index) {
                  return InteractiveViewer(
                    child: fileImages == null
                        ? Image.network(
                            images[index],
                            height: height,
                            width: width,
                          )
                        : Image.file(
                            fileImages[index],
                            height: height,
                            width: width,
                          ),
                  );
                }),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        MyAssets.backArrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${widget.appBarName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
