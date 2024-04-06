import 'dart:convert';

import 'package:todo_application/core/model/status_model.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Task {
  Task({
    this.id,
    this.taskName,
    this.description,
    this.dueDate,
    this.statusId,
    this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: asT<String?>(json['id']),
        taskName: asT<String?>(json['task_name']),
        description: asT<String?>(json['description']),
        dueDate: asT<String?>(json['due_date']),
        statusId: asT<String?>(json['status_id']),
        status: json['status'] == null
            ? null
            : Status.fromJson(asT<Map<String, dynamic>>(json['status'])!),
      );

  String? id;
  String? taskName;
  String? description;
  String? dueDate;
  String? statusId;
  Status? status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'task_name': taskName,
        'description': description,
        'due_date': dueDate,
        'status_id': statusId,
        'status': status,
      };
}
