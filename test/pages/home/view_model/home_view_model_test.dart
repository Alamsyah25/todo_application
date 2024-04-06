import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_application/core/model/status_model.dart';
import 'package:todo_application/core/model/task_model.dart';
import 'package:todo_application/features/home/repository/home_repository.dart';
import 'package:todo_application/features/home/view_model/home_view_model.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  final repository = MockHomeRepository();

  setUp(() {
    final responseTask = [
      {
        'id': 'd2526f37-980e-4b06-af21-b23bff35f74f',
        'task_name': 'Daily Standup',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'due_date': '2024-04-08',
        'status': {
          'id': '0f18b97f-2789-4c19-8e07-e9d35bea5066',
          'status': 'ongoing'
        }
      },
      {
        'id': '5762eaed-88f9-4cfb-8cd9-ad8fe2d5e2e2',
        'task_name': 'Sprint Planning',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'due_date': '2024-04-06',
        'status': {
          'id': '88d2aeb7-3af5-4d7d-b8ca-394b6b9097e9',
          'status': 'done'
        }
      },
      {
        'id': 'e208ad2a-617a-4bda-9260-bb2a30206e2e',
        'task_name': 'Sprint Grooming',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'due_date': '2024-04-06',
        'status': {
          'id': 'a2c0d930-e2a7-49b8-811b-d4b037849ee9',
          'status': 'todo'
        }
      }
    ];
    final responseStatus = [
      {'id': '0f18b97f-2789-4c19-8e07-e9d35bea5066', 'status': 'ongoing'},
      {'id': '88d2aeb7-3af5-4d7d-b8ca-394b6b9097e9', 'status': 'done'},
      {'id': 'a2c0d930-e2a7-49b8-811b-d4b037849ee9', 'status': 'todo'}
    ];

    final responseUpdateStatus = {
      'id': 'd2526f37-980e-4b06-af21-b23bff35f74f',
      'task_name': 'Daily Standup',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'due_date': '2024-04-08',
      'status': {'id': '88d2aeb7-3af5-4d7d-b8ca-394b6b9097e9', 'status': 'done'}
    };

    /// init response
    final task = responseTask.map((e) => Task.fromJson(e)).toList();
    final status = responseStatus.map((e) => Status.fromJson(e)).toList();
    final defaultTask = Task.fromJson(responseUpdateStatus);

    /// stub repository with success response
    when(() => repository.fetchData()).thenAnswer((_) async => task);
    when(() => repository.fetchStatus()).thenAnswer((_) async => status);
    when(() => repository.updateStatus(any(), any()))
        .thenAnswer((_) async => defaultTask);
    when(() => repository.delete(any())).thenAnswer((_) async => defaultTask);
  });

  group('home view model', () {
    test('init repo', () {
      final viewModel = HomeViewModel(homeRepository: null);

      expect(viewModel.isLoading, isFalse);
    });

    test('init vm', () async {
      final viewModel = HomeViewModel(homeRepository: repository);

      // act
      viewModel.init();

      // assert
      expect(
        viewModel.todoLength,
        0,
      );
      expect(
        viewModel.ongoingLength,
        0,
      );
      expect(
        viewModel.doneLength,
        0,
      );
    });

    test('test fetching list task', () async {
      /// init view model
      final viewModel = HomeViewModel(homeRepository: repository);

      /// check value before call function
      expect(viewModel.taskList, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.todoLength, 0);
      expect(viewModel.ongoingLength, 0);
      expect(viewModel.doneLength, 0);

      /// call view model function
      await viewModel.fetchTask();
      viewModel.taskOverview();

      /// check value after call function
      expect(viewModel.taskList, isNotEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.todoLength, 1);
      expect(viewModel.ongoingLength, 1);
      expect(viewModel.doneLength, 1);
    });

    test('test fetching list status', () async {
      /// init view model
      final viewModel = HomeViewModel(homeRepository: repository);

      /// check value before call function
      expect(viewModel.statusList, isEmpty);
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      await viewModel.fetchStatus();
      await Future.delayed(Duration.zero);

      /// check value after call function
      expect(viewModel.statusList, isNotEmpty);
      expect(viewModel.isLoading, isFalse);
    });

    test('test update status', () async {
      /// init view model
      final viewModel = HomeViewModel(homeRepository: repository);

      /// check value before call function
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      await viewModel.updateStatus(
        viewModel.taskList.firstOrNull?.id ?? '',
        '88d2aeb7-3af5-4d7d-b8ca-394b6b9097e9',
      );

      /// check value after call function
      expect(viewModel.isLoading, isFalse);

      verify(() => repository.updateStatus(any(), any())).called(1);
    });

    test('test update status', () async {
      /// init view model
      final viewModel = HomeViewModel(homeRepository: repository);

      /// check value before call function
      expect(viewModel.isLoading, isFalse);

      /// call view model function
      await viewModel.deleteTask(
        viewModel.taskList.firstOrNull?.id ?? '',
      );

      /// check value after call function
      expect(viewModel.isLoading, isFalse);

      verify(() => repository.delete(any())).called(1);
    });

    test('test loading', () async {
      /// init view model
      final viewModel = HomeViewModel(homeRepository: repository);

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
