import 'package:flutter_riverpod/legacy.dart';
import 'package:kick_stack/di/usecase_provider/usecase_provider.dart';
import 'package:kick_stack/presentation/websocket_example/websocket_example_page_view_model.dart';

final webSocketExampleViewModelProvider =
    ChangeNotifierProvider.autoDispose<WebSocketExamplePageViewModel>(
      (ref) => WebSocketExamplePageViewModel(
        getLiveUpdatesUseCase: ref.read(getLiveUpdatesUseCaseProvider),
      ),
    );
