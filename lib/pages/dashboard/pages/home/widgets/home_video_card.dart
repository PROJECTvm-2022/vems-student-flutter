import 'package:flutter/material.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/video_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 3:15 PM
///

class HomeVideoCard extends StatelessWidget {
  final StudentVideoDatum datum;
  final VoidCallback onTap;

  const HomeVideoCard({Key key, this.datum, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
        child: SizedBox(
          width: 206,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 126,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
                        margin: const EdgeInsets.only(right: 4, bottom: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          "${countDownTimeFormatFromSeconds(datum.videoId.duration, hhMMss: true)}",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(datum?.thumbnail ?? ''),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(height: 10),
              Text(
                "${datum.videoId?.title}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${compactCount(datum.instituteBatchVideo.publicCommentCount)} Doubts",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? MyColors.grey
                      : MyColors.darkTextColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
