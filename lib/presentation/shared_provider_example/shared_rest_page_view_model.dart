import 'package:domain/usecase/get_dashboard_summary_usecase.dart';
import 'package:kick_stack/base/base_page_view_model.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/extentions/steam_extension.dart';
import 'package:kick_stack/utils/request_manager.dart';
import 'package:kick_stack/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class SharedRestPageViewModel extends BasePageViewModel {
  final GetDashboardSummaryUseCase _getDashboardSummaryUseCase;

  SharedRestPageViewModel({
    required GetDashboardSummaryUseCase getDashboardSummaryUseCase,
  }) : _getDashboardSummaryUseCase = getDashboardSummaryUseCase {
    _dashboardRequest.listen(_fetchDashboardFromUseCase);
  }

  final PublishSubject<GetDashboardSummaryUseCaseParam> _dashboardRequest =
      PublishSubject<GetDashboardSummaryUseCaseParam>();

  final BehaviorSubject<Resource<bool>> _dashboardResponse =
      BehaviorSubject<Resource<bool>>.seeded(Resource.none());

  Stream<Resource<bool>> get dashboardResponseStream =>
      _dashboardResponse.stream;

  final BehaviorSubject<DateTime?> _lastFetchedAt =
      BehaviorSubject<DateTime?>.seeded(null);

  Stream<DateTime?> get lastFetchedAtStream => _lastFetchedAt.stream;

  void fetchDashboardData() {
    _dashboardRequest.safeAdd(GetDashboardSummaryUseCaseParam());
  }

  void _fetchDashboardFromUseCase(GetDashboardSummaryUseCaseParam params) {
    RequestManager<bool>(
      params,
      createCall: () => _getDashboardSummaryUseCase.execute(params: params),
    ).asFlow().listen((event) {
      updateLoader();
      _dashboardResponse.safeAdd(event);

      if (event.status == Status.SUCCESS) {
        _lastFetchedAt.safeAdd(DateTime.now());
      }

      if (event.status == Status.ERROR && event.appError != null) {
        showToastWithError(event.appError!);
      }
    });
  }

  @override
  void dispose() {
    _dashboardRequest.close();
    _dashboardResponse.close();
    _lastFetchedAt.close();
    super.dispose();
  }
}
