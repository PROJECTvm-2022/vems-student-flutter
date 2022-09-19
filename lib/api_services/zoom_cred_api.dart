import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/zoom_datum.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 23/5/21 at 7:54 PM
///

Future<ZoomDatum> getZoomConfig(String id) async {
  var resultMap =
      await ApiCall.post(ApiRoutes.zoomApi, body: {"liveClass": id});

  return ZoomDatum.fromJson(resultMap.data);
}
