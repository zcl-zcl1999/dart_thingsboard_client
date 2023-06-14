import 'package:thingsboard_client/src/model/alarm_comment_models.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    ThingsboardClient? tbClient;

    setUp(() async {
      tbClient = ThingsboardClient('http://localhost:8080');
      await tbClient!.init();
    });

    test('First Test', () async {
      await tbClient!.login(LoginRequest('', ''));
      // EntityTypeFilter entityTypeFilter = EntityTypeFilter(entityType: EntityType.DEVICE);
      // List<AlarmSearchStatus> alarmSearchStatus = [AlarmSearchStatus.ACTIVE];
      // AlarmCountQuery alarmCountQuery = AlarmCountQuery(entityFilter: entityTypeFilter, statusList: alarmSearchStatus);
      // print("countAlarmsByQuery: $alarmCountQuery");
      // var count = await tbClient!.getEntityQueryService().countAlarmsByQuery(alarmCountQuery);
      // print("count: $count");

      Map<String, String> comment = {"text": "test comment14"};
      var alarmComment = AlarmComment(comment: comment);
      print("alarmComment: $alarmComment");
      var json = alarmComment.toJson();
      print("json: $json");

      // alarmComment = await tbClient!.getAlarmCommentService().saveAlarmComment("2c07ddaf-5e66-442a-9ff8-0f0ad46a6fc5", alarmComment);
      // print("alarmComment: $alarmComment");
      var alarmComments = await tbClient!.getAlarmCommentService().getAlarmComments("2c07ddaf-5e66-442a-9ff8-0f0ad46a6fc5", PageLink(10));
      print("alarmComments: $alarmComments");
      alarmComments.data.forEach((element) {
        print("element: $element");
      });


      expect(tbClient!.getDeviceService(), isNot(null));
    });

  });
}
