import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_application/core/model/task_model.dart';
import 'package:todo_application/features/create_todo/repository/create_todo_respository.dart';
import 'package:todo_application/features/create_todo/view_model/create_todo_view_model.dart';

class MockCreateTodoRepository extends Mock implements CreateTodoRepository {}

void main() {
  final repository = MockCreateTodoRepository();
  late CreateTodoViewModel viewModel;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;

  setUp(() {
    registerFallbackValue(Task());

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();

    viewModel = CreateTodoViewModel(
        createTodoRepository: repository,
        titleController: titleController,
        descriptionController: descriptionController,
        dateController: dateController);

    viewModel.init();

    final responseTask = {
      'id': 'd2526f37-980e-4b06-af21-b23bff35f74f',
      'task_name': 'Daily Standup',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'due_date': '2024-04-08',
      'status': {'id': '88d2aeb7-3af5-4d7d-b8ca-394b6b9097e9', 'status': 'done'}
    };

    /// init response
    final task = Task.fromJson(responseTask);

    /// stub repository with success response
    when(() => repository.createTask(
          any(),
        )).thenAnswer((_) async => task);
    when(() => repository.updateTask(any())).thenAnswer((_) async => task);
  });

  group('create todo view model', () {
    test('init repo', () {
      viewModel = CreateTodoViewModel(
          createTodoRepository: null,
          titleController: titleController,
          descriptionController: descriptionController,
          dateController: dateController);

      viewModel.init();

      expect(viewModel.isLoading, isFalse);
    });

    test('text editing controller value', () async {
      const titleValue = 'title';
      const descValue = 'desc';
      const dateValue = '2024-01-01';

      titleController.text = titleValue;
      descriptionController.text = descValue;
      dateController.text = dateValue;

      expect(viewModel.title, titleValue);
      expect(viewModel.description, descValue);
      expect(viewModel.date, dateValue);
    });

    test('test create task', () async {
      const titleValue = 'title';
      const descValue = 'desc';
      const dateValue = '2024-01-01';

      titleController.text = titleValue;
      descriptionController.text = descValue;
      dateController.text = dateValue;

      /// check value before call function
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      await viewModel.createTask();

      /// check value after call function
      expect(viewModel.isLoading, isFalse);

      verify(() => repository.createTask(any())).called(1);
    });
    test('test update task', () async {
      const titleValue = 'title';
      const descValue = 'desc';
      const dateValue = '2024-01-01';
      const id = '001';

      titleController.text = titleValue;
      descriptionController.text = descValue;
      dateController.text = dateValue;

      /// check value before call function
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      await viewModel.updateTask(id);

      /// check value after call function
      expect(viewModel.isLoading, isFalse);

      verify(() => repository.updateTask(any())).called(1);
    });

    test('test loading', () async {
      /// check value before call function
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      viewModel.showLoading();

      /// check value after call function
      expect(viewModel.isLoading, isTrue);

      /// call view model function
      viewModel.dismissLoading();

      /// check value after call function
      expect(viewModel.isLoading, isFalse);
    });
  });
}
