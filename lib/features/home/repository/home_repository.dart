import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/model/status_model.dart';
import '../../../core/model/task_model.dart';

class HomeRepository {
  Future<List<Task>?> fetchData() async {
    try {
      final data = await Supabase.instance.client
          .from('task')
          .select('id, task_name, description, due_date, status(id, status)')
          .order('created_at', ascending: false);

      if (kDebugMode) {
        print('Response Data $data');
      }
      return data.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Response Error $e');
      }
      return null;
    }
  }

  Future<List<Status>?> fetchStatus() async {
    try {
      final data = await Supabase.instance.client.from('status').select();

      if (kDebugMode) {
        print('Response Data $data');
      }
      return data.map((e) => Status.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Response Error $e');
      }
      return null;
    }
  }

  Future<Task?> delete(String id) async {
    try {
      final data = await Supabase.instance.client.from('task').delete().match(
        {'id': id},
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

  Future<List<Task>?> fetchDataByStatus(String status) async {
    final data = await Supabase.instance.client
        .from('status')
        .select('id, status, task(id, task_name)')
        .inFilter('status', [status]);
    try {
      if (kDebugMode) {
        print('Response Data $data');
      }
      return data.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Response Errors $e');
      }
      return null;
    }
  }

  Future<Task?> updateStatus(String id, String statusId) async {
    try {
      final data = await Supabase.instance.client.from('task').update(
        {'status_id': statusId},
      ).match(
        {'id': id},
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
