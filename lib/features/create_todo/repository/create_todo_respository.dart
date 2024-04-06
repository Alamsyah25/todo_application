import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/model/task_model.dart';

class CreateTodoRepository {
  Future<Task?> createTask(Task task) async {
    try {
      final data = await Supabase.instance.client.from('task').insert(
        {
          'task_name': task.taskName,
          'description': task.description,
          'due_date': task.dueDate,
          'status_id': task.statusId
        },
      ).select();
      if (kDebugMode) {
        print('Response Data $data');
      }

      return data.map((e) => Task.fromJson(e)).toList().firstOrNull;
    } catch (e) {
      if (kDebugMode) {
        print('Response Error $e');
      }
      return null;
    }
  }

  Future<Task?> updateTask(Task task) async {
    try {
      final data = await Supabase.instance.client.from('task').update(
        {
          'task_name': task.taskName,
          'description': task.description,
          'due_date': task.dueDate,
        },
      ).match(
        {'id': task.id},
      ).select();
      if (kDebugMode) {
        print('Response Data $data');
      }

      return data.map((e) => Task.fromJson(e)).toList().firstOrNull;
    } catch (e) {
      if (kDebugMode) {
        print('Response Error $e');
      }
      return null;
    }
  }
}
