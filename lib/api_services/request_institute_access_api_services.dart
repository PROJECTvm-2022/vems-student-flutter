import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/student_seat_datum.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 5:31 PM
///

Future<StudentSeatDatum> requestForInstituteAccess(
    {String institute, String course, int mode}) async {
  final result = await ApiCall.post(ApiRoutes.seatAccess, body: {
    "institute": institute,
    "instituteCourse": course,
    "type": mode,
  }, query: {
    "\$populate": "institute"
  });
  return StudentSeatDatum.fromJson(result.data);
}
