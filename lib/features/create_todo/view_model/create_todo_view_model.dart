import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/model/task_model.dart';
import '../repository/create_todo_respository.dart';

class CreateTodoViewModel extends BaseViewModel {
  final CreateTodoRepository _createTodoRepository;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final TextEditingController _dateController;

  CreateTodoViewModel({
    CreateTodoRepository? createTodoRepository,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController dateController,
  })  : _createTodoRepository = createTodoRepository ?? CreateTodoRepository(),
        _titleController = titleController,
        _descriptionController = descriptionController,
        _dateController = dateController;

  static const statusId = 'a2c0d930-e2a7-49b8-811b-d4b037849ee9';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? get title => _titleController.text.trim();

  String? get description => _descriptionController.text.trim();

  String? get date => _dateController.text.trim();

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void dismissLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<Task?> createTask() async {
    showLoading();

    final data = Task(
      taskName: title,
      description: description,
      dueDate: date,
      statusId: statusId,
    );

    final response = await _createTodoRepository.createTask(data);

    dismissLoading();
    return response;
  }

  Future<Task?> updateTask(String id) async {
    showLoading();

    final data = Task(
      id: id,
      taskName: title,
      description: description,
      dueDate: date,
    );

    final response = await _createTodoRepository.updateTask(data);

    dismissLoading();
    return response;
  }
}
