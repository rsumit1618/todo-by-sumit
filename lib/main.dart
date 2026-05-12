import 'dart:io';
import 'package:data/core/app/app_http_override.dart';
import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:data/di/local_di.dart';
import 'package:data/helper/app_local_database_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/firebase_options.dart';
import 'package:flutter_clean_architecture/main/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (NetworkConfig.currentFlavor == ProductFlavor.dev) {
    HttpOverrides.global = AppHttpOverrides();
  }
  if (DefaultFirebaseOptions.isConfigured) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  final db = await AppLocalDatabase.create();
  runApp(ProviderScope(
    overrides: [
      appLocalDatabaseProvider.overrideWithValue(db),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return App();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {}
    if (state == AppLifecycleState.inactive) {
      debugPrint('ApplicationState : {Inactive}');
    }
    if (state == AppLifecycleState.paused) {
      debugPrint('ApplicationState : {Paused}');
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
