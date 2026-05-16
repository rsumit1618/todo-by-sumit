// DO NOT EDIT. This is core generated via package:intl/generate_localized.dart
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    'apiCallSuccess': MessageLookupByLibrary.simpleMessage('API call completed'),
    'appName': MessageLookupByLibrary.simpleMessage('KickStack'),
    'callDashboardSummaryApi': MessageLookupByLibrary.simpleMessage('Call dashboard summary'),
    'createLocalTask': MessageLookupByLibrary.simpleMessage('Create local task'),
    'deleteLiveItem': MessageLookupByLibrary.simpleMessage('Delete live item'),
    'deleteTask': MessageLookupByLibrary.simpleMessage('Delete task'),
    'emptyTaskMessage': MessageLookupByLibrary.simpleMessage('No local tasks yet'),
    'fetchRestData': MessageLookupByLibrary.simpleMessage('Fetch REST data'),
    'getStarted': MessageLookupByLibrary.simpleMessage('Get started'),
    'goBack': MessageLookupByLibrary.simpleMessage('Go back'),
    'lastFetchedAt': (value) => 'Last fetched at ${value}',
    'liveSeedInventoryUpdated': MessageLookupByLibrary.simpleMessage('Inventory updated'),
    'liveSeedOrderCreated': MessageLookupByLibrary.simpleMessage('Order created'),
    'liveSeedPaymentReceived': MessageLookupByLibrary.simpleMessage('Payment received'),
    'loading': MessageLookupByLibrary.simpleMessage('Loading'),
    'localTaskCreated': MessageLookupByLibrary.simpleMessage('Local task saved'),
    'login': MessageLookupByLibrary.simpleMessage('Login'),
    'noSharedTimestamp': MessageLookupByLibrary.simpleMessage('No shared timestamp yet'),
    'openRestApiExample': MessageLookupByLibrary.simpleMessage('REST API example'),
    'openSharedDetails': MessageLookupByLibrary.simpleMessage('Open shared details'),
    'openSharedProviderExample': MessageLookupByLibrary.simpleMessage('Shared provider example'),
    'openSharedRestExample': MessageLookupByLibrary.simpleMessage('Open shared REST example'),
    'openSqliteExample': MessageLookupByLibrary.simpleMessage('SQLite example'),
    'openWebSocketExample': MessageLookupByLibrary.simpleMessage('WebSocket example'),
    'refreshLocalTasks': MessageLookupByLibrary.simpleMessage('Refresh local tasks'),
    'refreshSharedProvider': MessageLookupByLibrary.simpleMessage('Refresh shared provider'),
    'restApiExampleDescription': MessageLookupByLibrary.simpleMessage('Call a Retrofit API through view model, use case, repository, and data source layers.'),
    'restApiExampleTitle': MessageLookupByLibrary.simpleMessage('REST API example'),
    'restApiFailed': MessageLookupByLibrary.simpleMessage('Dashboard summary API failed'),
    'restApiSuccess': MessageLookupByLibrary.simpleMessage('Dashboard summary API completed'),
    'restApiWaiting': MessageLookupByLibrary.simpleMessage('API response will appear here'),
    'restDataFailed': MessageLookupByLibrary.simpleMessage('REST data failed'),
    'restDataLoaded': MessageLookupByLibrary.simpleMessage('REST data loaded from use case'),
    'restDataNotLoaded': MessageLookupByLibrary.simpleMessage('REST data is not loaded yet'),
    'sampleTaskTitle': MessageLookupByLibrary.simpleMessage('Sample local task'),
    'sharedProviderDataAvailable': MessageLookupByLibrary.simpleMessage('Shared provider data is available here'),
    'sharedRestDescription': MessageLookupByLibrary.simpleMessage('This screen fetches REST data and stores the response in a provider shared with the next screen.'),
    'sharedRestDetailDescription': MessageLookupByLibrary.simpleMessage('This screen reads the same provider instance, so it can show the REST data loaded on the previous screen.'),
    'sharedRestDetailTitle': MessageLookupByLibrary.simpleMessage('Shared provider detail'),
    'sharedRestTitle': MessageLookupByLibrary.simpleMessage('Shared REST provider'),
    'sqliteExampleDescription': MessageLookupByLibrary.simpleMessage('Create, read, update, and delete local tasks through the clean architecture flow.'),
    'sqliteExampleTitle': MessageLookupByLibrary.simpleMessage('SQLite example'),
    'starterSubtitle': MessageLookupByLibrary.simpleMessage('Clean Flutter starter for REST API, SQLite, secure storage, SSL, shared providers, and WebSocket updates.'),
    'webSocketConnected': MessageLookupByLibrary.simpleMessage('Live updates connected'),
    'webSocketConnecting': MessageLookupByLibrary.simpleMessage('Connecting to live updates'),
    'webSocketDisconnected': MessageLookupByLibrary.simpleMessage('Live updates disconnected'),
    'webSocketExampleDescription': MessageLookupByLibrary.simpleMessage('Load initial data from REST, then merge live WebSocket updates into a smooth list.'),
    'webSocketExampleTitle': MessageLookupByLibrary.simpleMessage('WebSocket live updates'),
    'webSocketFallback': MessageLookupByLibrary.simpleMessage('Backend is not connected yet, showing starter data'),
  };
}