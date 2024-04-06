import 'dart:async';

import '../../../common/constants/constants.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/model/task_model.dart';
import '../repository/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  final HomeRepository _homeRepository;

  HomeViewModel({HomeRepository? homeRepository})
      : _homeRepository = homeRepository ?? HomeRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  List<Status> _statusList = [];

  List<Status> get statusList => _statusList;

  int _todoLength = 1;
  int _ongoingLength = 0;
  int _doneLength = 0;

  int get todoLength => _todoLength;
  int get ongoingLength => _ongoingLength;
  int get doneLength => _doneLength;

  @override
  Future<void> init() async {
    await fetchTask();
    taskOverview();
    fetchStatus();
    super.init();
  }

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void dismissLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTask() async {
    showLoading();

    final response = await _homeRepository.fetchData();

    _taskList = response ?? [];

    dismissLoading();
  }

  Future<void> taskOverview() async {
    _todoLength = taskList
        .map((element) => element.status?.status == Constants.todo)
        .length;
    _ongoingLength = taskList
        .where((element) => element.status?.status == Constants.onGoing)
        .length;
    _doneLength = taskList
        .where((element) => element.status?.status == Constants.done)
        .length;

    notifyListeners();
  }

  Future<void> fetchStatus() async {
    final response = await _homeRepository.fetchStatus();

    _statusList = response ?? [];
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await _homeRepository.delete(id);

    final response = await _homeRepository.fetchData();

    _taskList = response ?? [];
    notifyListeners();
  }

  Future<Task?> updateStatus(String id, String statusId) async {
    final data = await _homeRepository.updateStatus(id, statusId);

    final response = await _homeRepository.fetchData();

    _taskList = response ?? [];

    taskOverview();
    return data;
  }
}
