import 'dart:async';
import 'dart:convert';

import 'package:thingsboard_client/src/model/model.dart';

import '../../thingsboard_client.dart';
import '../model/alarm_comment_models.dart';

PageData<AlarmCommentInfo> parseAlarmCommentInfoPageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => AlarmCommentInfo.fromJson(json));
}

class AlarmCommentService {
  final ThingsboardClient _tbClient;

  factory AlarmCommentService(ThingsboardClient tbClient) {
    return AlarmCommentService._internal(tbClient);
  }

  AlarmCommentService._internal(this._tbClient);


  Future<AlarmComment> saveAlarmComment(String alarmId, AlarmComment alarmComment,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>('/api/alarm/$alarmId/comment',
        data: jsonEncode(alarmComment),
        options: defaultHttpOptionsFromConfig(requestConfig));
    print("response.data: ${response.data}");
    return AlarmComment.fromJson(response.data!);
  }

  Future<PageData<AlarmCommentInfo>> getAlarmComments(String alarmId, PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    var response = await _tbClient.get<Map<String, dynamic>>('/api/alarm/$alarmId/comment',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    print("response.data: ${response.data}");
    return _tbClient.compute(parseAlarmCommentInfoPageData, response.data!);

  }

  Future<void> deleteAlarmComment(String alarmId, String commentId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/alarm/$alarmId/comment/$commentId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }


}
