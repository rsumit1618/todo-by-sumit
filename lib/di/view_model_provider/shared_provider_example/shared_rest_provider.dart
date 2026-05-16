import 'package:kick_stack/di/usecase_provider/usecase_provider.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final sharedRestViewModelProvider =
    ChangeNotifierProvider<SharedRestPageViewModel>(
      (ref) => SharedRestPageViewModel(
        getDashboardSummaryUseCase: ref.read(
          getDashboardSummaryUseCaseProvider,
        ),
      ),
    );
