import 'base_data.dart';
import 'id/alarm_comment_id.dart';
import 'id/alarm_id.dart';
import 'id/user_id.dart';
import 'has_name.dart';


enum AlarmCommentType { SYSTEM, OTHER }

AlarmCommentType alarmCommentTypeFromString(String value) {
  return AlarmCommentType.values.firstWhere(
          (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

extension AlarmCommentTypeToString on AlarmCommentType {
  String toShortString() {
    return toString().split('.').last;
  }
}

// todo
class AlarmComment extends BaseData<AlarmCommentId> with HasName {
  final AlarmId? alarmId;
  final UserId? userId;
  AlarmCommentType type;
  Map<String, dynamic> comment;

  AlarmComment({
    this.alarmId,
    this.userId,
    this.type = AlarmCommentType.OTHER, // Set default value for type
    required this.comment,
  }) : super();

  AlarmComment.fromJson(Map<String, dynamic> json)
      : alarmId = AlarmId.fromJson(json['alarmId']),
        userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null,
        type = alarmCommentTypeFromString(json['type']),
        comment = json['comment'] != null ? json['comment'] : {},
        super.fromJson(json, (id) => AlarmCommentId(id));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    if (alarmId != null) json['alarmId'] = alarmId?.toJson();
    if (userId != null) json['userId'] = userId?.toJson();
    json['type'] = type.toShortString();
    json['comment'] = comment; // Encode comment to JSON
    return json;
  }

  @override
  String getName() {
    return comment.toString();
  }

  @override
  String toString() {
    return 'AlarmComment{${alarmCommentString()}}';
  }

  String alarmCommentString([String? toStringBody]) {
    return '${baseDataString(
        'alarmId: $alarmId, userId: $userId, type: $type, comment: $comment, name: ${getName()}${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }

}

class AlarmCommentInfo extends AlarmComment {
  final String firstName;
  final String lastName;
  final String email;

  AlarmCommentInfo({
    required AlarmId alarmId,
    required UserId userId,
    required AlarmCommentType type,
    required Map<String, dynamic> comment,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(
    alarmId: alarmId,
    userId: userId,
    type: type,
    comment: comment,
  );

  AlarmCommentInfo.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'] ?? '',
        lastName = json['lastName'] ?? '',
        email = json['email'] ?? '',
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['email'] = email;
    return json;
  }

  @override
  String toString() {
    return 'AlarmCommentInfo{${alarmCommentInfoString()}}';
  }

  String alarmCommentInfoString([String? toStringBody]) {
    return '${alarmCommentString(
        'firstName: $firstName, lastName: $lastName, email: $email${toStringBody != null ? ', ' + toStringBody : ''}')}';

  }
}
