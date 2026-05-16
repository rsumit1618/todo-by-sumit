import 'package:domain/entities/task_entity.dart';
import 'package:domain/usecase/create_task_usecase.dart';
import 'package:domain/usecase/delete_task_usecase.dart';
import 'package:domain/usecase/get_local_tasks_usecase.dart';
import 'package:domain/usecase/update_task_usecase.dart';
import 'package:kick_stack/base/base_page_view_model.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/extentions/steam_extension.dart';
import 'package:kick_stack/utils/request_manager.dart';
import 'package:kick_stack/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class TaskHomePageViewModel extends BasePageViewModel {
  final GetLocalTasksUseCase _getLocalTasksUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskHomePageViewModel({
    required GetLocalTasksUseCase getLocalTasksUseCase,
    required CreateTaskUseCase createTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
  }) : _getLocalTasksUseCase = getLocalTasksUseCase,
       _createTaskUseCase = createTaskUseCase,
       _updateTaskUseCase = updateTaskUseCase,
       _deleteTaskUseCase = deleteTaskUseCase {
    _localTasksRequest.listen(_getLocalTasksFromUseCase);
    _createTaskRequest.listen(_createTaskFromUseCase);
    _updateTaskRequest.listen(_updateTaskFromUseCase);
    _deleteTaskRequest.listen(_deleteTaskFromUseCase);
  }

  final PublishSubject<GetLocalTasksUseCaseParam> _localTasksRequest =
      PublishSubject<GetLocalTasksUseCaseParam>();
  final PublishSubject<Resource<List<TaskEntity>>> _localTasksResponse =
      PublishSubject<Resource<List<TaskEntity>>>();
  Stream<Resource<List<TaskEntity>>> get localTasksResponseStream =>
      _localTasksResponse.stream;

  final PublishSubject<CreateTaskUseCaseParam> _createTaskRequest =
      PublishSubject<CreateTaskUseCaseParam>();
  final PublishSubject<Resource<TaskEntity>> _createTaskResponse =
      PublishSubject<Resource<TaskEntity>>();
  Stream<Resource<TaskEntity>> get createTaskResponseStream =>
      _createTaskResponse.stream;

  final PublishSubject<UpdateTaskUseCaseParam> _updateTaskRequest =
      PublishSubject<UpdateTaskUseCaseParam>();

  final PublishSubject<DeleteTaskUseCaseParam> _deleteTaskRequest =
      PublishSubject<DeleteTaskUseCaseParam>();

  void load() {
    getLocalTasks();
  }

  void getLocalTasks() {
    _localTasksRequest.safeAdd(GetLocalTasksUseCaseParam());
  }

  void createSampleTask({required String title}) {
    _createTaskRequest.safeAdd(CreateTaskUseCaseParam(title: title));
  }

  void toggleTask(TaskEntity task) {
    _updateTaskRequest.safeAdd(
      UpdateTaskUseCaseParam(task.copyWith(isCompleted: !task.isCompleted)),
    );
  }

  void deleteTask(String id) {
    _deleteTaskRequest.safeAdd(DeleteTaskUseCaseParam(id));
  }

  void _getLocalTasksFromUseCase(GetLocalTasksUseCaseParam params) {
    RequestManager<List<TaskEntity>>(
      params,
      createCall: () => _getLocalTasksUseCase.execute(params: params),
    ).asFlow().listen((event) {
      updateLoader();
      _localTasksResponse.safeAdd(event);
      if (event.status == Status.ERROR && event.appError != null) {
        showToastWithError(event.appError!);
      }
    });
  }

  void _createTaskFromUseCase(CreateTaskUseCaseParam params) {
    RequestManager<TaskEntity>(
      params,
      createCall: () => _createTaskUseCase.execute(params: params),
    ).asFlow().listen((event) {
      updateLoader();
      _createTaskResponse.safeAdd(event);
      if (event.status == Status.SUCCESS) {
        getLocalTasks();
      }
      if (event.status == Status.ERROR && event.appError != null) {
        showToastWithError(event.appError!);
      }
    });
  }

  void _updateTaskFromUseCase(UpdateTaskUseCaseParam params) {
    RequestManager<TaskEntity>(
      params,
      createCall: () => _updateTaskUseCase.execute(params: params),
    ).asFlow().listen((event) {
      updateLoader();
      if (event.status == Status.SUCCESS) {
        getLocalTasks();
      }
      if (event.status == Status.ERROR && event.appError != null) {
        showToastWithError(event.appError!);
      }
    });
  }

  void _deleteTaskFromUseCase(DeleteTaskUseCaseParam params) {
    RequestManager<bool>(
      params,
      createCall: () => _deleteTaskUseCase.execute(params: params),
    ).asFlow().listen((event) {
      updateLoader();
      if (event.status == Status.SUCCESS) {
        getLocalTasks();
      }
      if (event.status == Status.ERROR && event.appError != null) {
        showToastWithError(event.appError!);
      }
    });
  }

  @override
  void dispose() {
    _localTasksRequest.close();
    _localTasksResponse.close();
    _createTaskRequest.close();
    _createTaskResponse.close();
    _updateTaskRequest.close();
    _deleteTaskRequest.close();
    super.dispose();
  }
}
