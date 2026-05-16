import 'package:flutter_riverpod/legacy.dart';
import 'package:kick_stack/di/usecase_provider/usecase_provider.dart';
import 'package:kick_stack/presentation/rest_api_example/rest_api_example_page_view_model.dart';

final restApiExampleViewModelProvider =
    ChangeNotifierProvider.autoDispose<RestApiExamplePageViewModel>(
      (ref) => RestApiExamplePageViewModel(
        getDashboardSummaryUseCase: ref.read(
          getDashboardSummaryUseCaseProvider,
        ),
      ),
    );
