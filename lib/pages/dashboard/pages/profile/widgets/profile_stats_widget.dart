import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/data_models/profile_stats_datum.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 10:24 PM
///

class ProfileStatsWidget extends StatelessWidget {
  final ProfileStatsDatum datum;

  const ProfileStatsWidget({Key key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatsCard(
            name: 'Classes Attend',
            asset: MyAssets.calenderCheck,
            value: '${datum.attendedClasses}',
          ),
          StatsCard(
            name: 'Attendance',
            asset: MyAssets.attendance,
            value: '${datum.attendancePercentage}%',
          ),
          StatsCard(
            name: 'Upcoming Classes',
            asset: MyAssets.upcomingClasses,
            value: '${datum.upcomingLiveClasses}',
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String asset;
  final String name;
  final String value;

  const StatsCard({Key key, this.asset, this.name, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(asset),
        const SizedBox(height: 7),
        Text(name ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            )),
        const SizedBox(height: 6),
        Text(value ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }
}
