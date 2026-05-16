// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree.');
    return instance!;
  }

  static S? maybeOf(BuildContext context) => Localizations.of<S>(context, S);

  String get appName => Intl.message('KickStack', name: 'appName');
  String get starterSubtitle => Intl.message('Clean Flutter starter for REST API, SQLite, secure storage, SSL, shared providers, and WebSocket updates.', name: 'starterSubtitle');
  String get getStarted => Intl.message('Get started', name: 'getStarted');
  String get login => Intl.message('Login', name: 'login');
  String get openRestApiExample => Intl.message('REST API example', name: 'openRestApiExample');
  String get openSqliteExample => Intl.message('SQLite example', name: 'openSqliteExample');
  String get openSharedProviderExample => Intl.message('Shared provider example', name: 'openSharedProviderExample');
  String get openWebSocketExample => Intl.message('WebSocket example', name: 'openWebSocketExample');
  String get restApiExampleTitle => Intl.message('REST API example', name: 'restApiExampleTitle');
  String get restApiExampleDescription => Intl.message('Call a Retrofit API through view model, use case, repository, and data source layers.', name: 'restApiExampleDescription');
  String get callDashboardSummaryApi => Intl.message('Call dashboard summary', name: 'callDashboardSummaryApi');
  String get restApiWaiting => Intl.message('API response will appear here', name: 'restApiWaiting');
  String get restApiSuccess => Intl.message('Dashboard summary API completed', name: 'restApiSuccess');
  String get restApiFailed => Intl.message('Dashboard summary API failed', name: 'restApiFailed');
  String get sqliteExampleTitle => Intl.message('SQLite example', name: 'sqliteExampleTitle');
  String get sqliteExampleDescription => Intl.message('Create, read, update, and delete local tasks through the clean architecture flow.', name: 'sqliteExampleDescription');
  String get createLocalTask => Intl.message('Create local task', name: 'createLocalTask');
  String get refreshLocalTasks => Intl.message('Refresh local tasks', name: 'refreshLocalTasks');
  String get deleteTask => Intl.message('Delete task', name: 'deleteTask');
  String get loading => Intl.message('Loading', name: 'loading');
  String get emptyTaskMessage => Intl.message('No local tasks yet', name: 'emptyTaskMessage');
  String get sampleTaskTitle => Intl.message('Sample local task', name: 'sampleTaskTitle');
  String get apiCallSuccess => Intl.message('API call completed', name: 'apiCallSuccess');
  String get localTaskCreated => Intl.message('Local task saved', name: 'localTaskCreated');
  String get openSharedRestExample => Intl.message('Open shared REST example', name: 'openSharedRestExample');
  String get sharedRestTitle => Intl.message('Shared REST provider', name: 'sharedRestTitle');
  String get sharedRestDescription => Intl.message('This screen fetches REST data and stores the response in a provider shared with the next screen.', name: 'sharedRestDescription');
  String get fetchRestData => Intl.message('Fetch REST data', name: 'fetchRestData');
  String get openSharedDetails => Intl.message('Open shared details', name: 'openSharedDetails');
  String get restDataNotLoaded => Intl.message('REST data is not loaded yet', name: 'restDataNotLoaded');
  String get restDataLoaded => Intl.message('REST data loaded from use case', name: 'restDataLoaded');
  String get restDataFailed => Intl.message('REST data failed', name: 'restDataFailed');
  String lastFetchedAt(Object value) => Intl.message('Last fetched at $value', name: 'lastFetchedAt', args: [value]);
  String get sharedRestDetailTitle => Intl.message('Shared provider detail', name: 'sharedRestDetailTitle');
  String get sharedRestDetailDescription => Intl.message('This screen reads the same provider instance, so it can show the REST data loaded on the previous screen.', name: 'sharedRestDetailDescription');
  String get sharedProviderDataAvailable => Intl.message('Shared provider data is available here', name: 'sharedProviderDataAvailable');
  String get noSharedTimestamp => Intl.message('No shared timestamp yet', name: 'noSharedTimestamp');
  String get refreshSharedProvider => Intl.message('Refresh shared provider', name: 'refreshSharedProvider');
  String get goBack => Intl.message('Go back', name: 'goBack');
  String get webSocketExampleTitle => Intl.message('WebSocket live updates', name: 'webSocketExampleTitle');
  String get webSocketExampleDescription => Intl.message('Load initial data from REST, then merge live WebSocket updates into a smooth list.', name: 'webSocketExampleDescription');
  String get webSocketConnecting => Intl.message('Connecting to live updates', name: 'webSocketConnecting');
  String get webSocketConnected => Intl.message('Live updates connected', name: 'webSocketConnected');
  String get webSocketDisconnected => Intl.message('Live updates disconnected', name: 'webSocketDisconnected');
  String get webSocketFallback => Intl.message('Backend is not connected yet, showing starter data', name: 'webSocketFallback');
  String get deleteLiveItem => Intl.message('Delete live item', name: 'deleteLiveItem');
  String get liveSeedOrderCreated => Intl.message('Order created', name: 'liveSeedOrderCreated');
  String get liveSeedPaymentReceived => Intl.message('Payment received', name: 'liveSeedPaymentReceived');
  String get liveSeedInventoryUpdated => Intl.message('Inventory updated', name: 'liveSeedInventoryUpdated');
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales => const <Locale>[Locale.fromSubtags(languageCode: 'en')];

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) return true;
    }
    return false;
  }
}