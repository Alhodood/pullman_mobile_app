
class TaskSummery{
  String progressing ;
  String  ongoing;
  String completed;
  TaskSummery({required this.completed, required this.ongoing, required this.progressing});
}
class Data {
  Data({
    this.id,
    this.name,
    this.picture,
    this.organizationId,
    this.team,
    this.fcmToken,
    this.authToken,
    this.email,
    this.phoneNumber,
    this.userId,
    this.signInProvider,
    this.createdAt,
    this.updatedAt,
    this.organization,
  });

  int? id;
  String? name;
  String? picture;
  int? organizationId;
  String? team;
  String? fcmToken;
  String? authToken;
  String? email;
  dynamic phoneNumber;
  String? userId;
  String? signInProvider;
  DateTime? createdAt;
  DateTime? updatedAt;
  Data? organization;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        organizationId: json["organizationId"],
        team: json["team"],
        fcmToken: json["fcm_token"],
        authToken: json["auth_token"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        userId: json["user_id"],
        signInProvider: json["sign_in_provider"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        organization: json["organization"] == null ? null : Data.fromMap(json["organization"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "picture": picture,
        "organizationId": organizationId,
        "team": team,
        "fcm_token": fcmToken,
        "auth_token": authToken,
        "email": email,
        "phone_number": phoneNumber,
        "user_id": userId,
        "sign_in_provider": signInProvider,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "organization": organization!.toMap(),
      };
}
class TaskStatistic {
  TaskStatistic({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory TaskStatistic.fromMap(Map<String, dynamic> json) => TaskStatistic(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
class Datum {
  Datum(
      {this.id,
      this.description,
      this.dueDate,
      this.isReminder,
      this.assignees,
      this.participants,
      this.organizationId,
      this.createdBy,
      this.team,
      this.priorityLevel,
      this.createdAt,
      this.updatedAt,
      this.organization,
      this.creator,
      this.status, this.todo,
    this.inProgress,
    this.completed,});

  int? id;
  String? description;
  String? dueDate;
  bool? isReminder;
  List<Data>? assignees;
  List<String>? participants;
  int? organizationId;
  int? createdBy;
  String? team;
  String? priorityLevel;
  DateTime? createdAt;
  DateTime? updatedAt;
  Data? organization;
  Data? creator;
  String? status;int? todo;
  int? inProgress;
  int? completed;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        description: json["description"],
        dueDate: json["due_date"],
        isReminder: json["is_reminder"],
        status: json["status"],
        assignees: json["assignees"] == null
            ? null
            : List<Data>.from(json["assignees"].map((x) => Data.fromMap(x))),
        participants: json["assignees"] == null
            ? null
            : List<String>.from(json["assignees"].map((x) => x['picture'])),
        organizationId: json["organizationId"],
        createdBy: json["created_by"],
        team: json["team"],
        priorityLevel: json["priority_level"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        organization: json["organization"] == null ? null : Data.fromMap(json["organization"]),
        creator: json["creator"] == null ? null : Data.fromMap(json["creator"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "due_date": dueDate,
        "is_reminder": isReminder,
        "assignees":
            assignees == null ? null : List<dynamic>.from(assignees!.map((x) => x.toMap())),
        "organizationId": organizationId,
        "created_by": createdBy,
        "team": team,
        "priority_level": priorityLevel,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "organization": organization!.toMap(),
        "creator": creator!.toMap(),
      };
}



class Task {
  Task({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Inbox {
  Inbox({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  // factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
  //       status: json["status"],
  //       message: json["message"],
  //       data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "message": message,
  //       "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  //     };
}