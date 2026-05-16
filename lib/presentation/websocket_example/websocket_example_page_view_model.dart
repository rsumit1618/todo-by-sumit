import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:data/core/config/network_config.dart';
import 'package:domain/entities/live_update_entity.dart';
import 'package:domain/usecase/get_live_updates_usecase.dart';
import 'package:kick_stack/base/base_page_view_model.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/extentions/steam_extension.dart';
import 'package:kick_stack/utils/request_manager.dart';
import 'package:kick_stack/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class WebSocketExamplePageViewModel extends BasePageViewModel {
  final GetLiveUpdatesUseCase _getLiveUpdatesUseCase;

  WebSocketExamplePageViewModel({
    required GetLiveUpdatesUseCase getLiveUpdatesUseCase,
  }) : _getLiveUpdatesUseCase = getLiveUpdatesUseCase {
    _initialLoadRequest.listen(_loadInitialItemsFromRest);
  }

  WebSocket? _socket;
  StreamSubscription? _socketSubscription;
  bool _started = false;
  List<String> _seedTitles = const [];

  final PublishSubject<GetLiveUpdatesUseCaseParam> _initialLoadRequest =
      PublishSubject<GetLiveUpdatesUseCaseParam>();

  final BehaviorSubject<List<LiveUpdateEntity>> _items =
      BehaviorSubject<List<LiveUpdateEntity>>.seeded(const []);
  Stream<List<LiveUpdateEntity>> get itemsStream => _items.stream;

  final BehaviorSubject<Resource<bool>> _connectionState =
      BehaviorSubject<Resource<bool>>.seeded(Resource.none());
  Stream<Resource<bool>> get connectionStateStream => _connectionState.stream;

  void start({required List<String> seedTitles}) {
    if (_started) return;
    _started = true;
    _seedTitles = seedTitles;
    _initialLoadRequest.safeAdd(GetLiveUpdatesUseCaseParam());
    _connectSocket();
  }

  void deleteItem(String id) {
    _removeItem(id);
    _socket?.add(jsonEncode({'type': 'delete', 'id': id}));
  }

  void _loadInitialItemsFromRest(GetLiveUpdatesUseCaseParam params) {
    RequestManager<List<LiveUpdateEntity>>(
      params,
      createCall: () => _getLiveUpdatesUseCase.execute(params: params),
    ).asFlow().listen((event) {
      setLoading(event.status == Status.LOADING);
      if (event.status == Status.SUCCESS && _items.value.isEmpty) {
        final data = event.data ?? const [];
        _items.safeAdd(data.isEmpty ? _seedItems() : data);
      }
      if (event.status == Status.ERROR && _items.value.isEmpty) {
        _items.safeAdd(_seedItems());
      }
    });
  }

  Future<void> _connectSocket() async {
    _connectionState.safeAdd(Resource.loading<bool>());
    try {
      _socket = await WebSocket.connect(NetworkConfig.webSocketUrl);
      _connectionState.safeAdd(Resource.success<bool>(data: true));
      _socketSubscription = _socket?.listen(
        _handleSocketMessage,
        onError: (_) => _connectionState.safeAdd(Resource.error<bool>()),
        onDone: () => _connectionState.safeAdd(Resource.none<bool>()),
      );
    } catch (_) {
      _connectionState.safeAdd(Resource.error<bool>());
    }
  }

  void _handleSocketMessage(dynamic message) {
    if (message is! String) return;
    final decoded = jsonDecode(message);
    if (decoded is! Map<String, dynamic>) return;

    final type = decoded['type']?.toString();
    if (type == 'delete') {
      _removeItem(decoded['id'].toString());
      return;
    }

    final itemJson = decoded['item'];
    if (itemJson is! Map<String, dynamic>) return;

    final incoming = _itemFromSocketJson(itemJson);
    final items = List<LiveUpdateEntity>.from(_items.value);
    final index = items.indexWhere((item) => item.id == incoming.id);
    if (index == -1) {
      items.insert(0, incoming);
    } else {
      items[index] = incoming;
    }
    _items.safeAdd(items);
  }

  void _removeItem(String id) {
    final next = _items.value.where((item) => item.id != id).toList();
    _items.safeAdd(next);
  }

  LiveUpdateEntity _itemFromSocketJson(Map<String, dynamic> json) {
    final updatedAt = DateTime.tryParse(json['updatedAt']?.toString() ?? '');
    return LiveUpdateEntity(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  List<LiveUpdateEntity> _seedItems() {
    final now = DateTime.now();
    return List.generate(_seedTitles.length, (index) {
      return LiveUpdateEntity(
        id: 'seed-${index + 1}',
        title: _seedTitles[index],
        updatedAt: now.subtract(Duration(minutes: index * 3)),
      );
    });
  }

  @override
  void dispose() {
    _socketSubscription?.cancel();
    _socket?.close();
    _initialLoadRequest.close();
    _items.close();
    _connectionState.close();
    super.dispose();
  }
}
