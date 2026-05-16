import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kick_stack/base/base_page_view_model.dart';
import 'package:kick_stack/base/base_widget.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/app/app_module.dart';
import 'package:kick_stack/main/app_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

abstract class BasePage<VM extends BasePageViewModel> extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<
  VM extends BasePageViewModel,
  T extends BasePage<VM>
>
    extends State<T> {}

abstract class BaseStatefulPage<
  VM extends BasePageViewModel,
  B extends BasePage<VM>
>
    extends BasePageState<VM, B> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isModelReadyCalled = false;

  BaseStatefulPage();

  @override
  void initState() {
    super.initState();

    /// Enables fullscreen edge-to-edge UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _setSystemUI();
  }

  VM? _viewModel;

  bool get attached => _viewModel != null;

  void _setSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: extendBodyBehindAppBar()
            ? Colors.transparent
            : statusBarColor(),
        statusBarIconBrightness: statusBarIconBrightness(),
        statusBarBrightness: statusBarBrightness(),
        systemNavigationBarColor: navigationBarColor(),
        systemNavigationBarIconBrightness: navigationBarIconBrightness(),
      ),
    );
  }

  Brightness statusBarIconBrightness() {
    return Brightness.dark;
  }

  Brightness statusBarBrightness() {
    return Brightness.dark;
  }

  Color navigationBarColor() {
    return Colors.white;
  }

  Brightness navigationBarIconBrightness() {
    return Brightness.dark;
  }

  /// Returns viewModel of the screen
  VM getViewModel() {
    return attached
        ? _viewModel!
        : throw AppError(
            cause: Exception("View model is not attached"),
            error: ErrorInfo(message: "View Model is not attached"),
            type: ErrorType.UI,
          );
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  /// Actual Screen which load scaffold and load UI
  Widget _getLayout() {
    return BaseWidget<AppViewModel>(
      providerBase: appViewModel,
      onModelReady: (model) {},
      builder: (context, appModel, child) {
        return BaseWidget<VM>(
          providerBase: provideBase(),
          onModelReady: _onBaseModelReady,
          builder: (BuildContext context, VM? model, Widget? child) {
            final scaffold = MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: scaffoldBackgroundColor(),
                appBar: buildAppbar(),
                extendBodyBehindAppBar: extendBodyBehindAppBar(),
                body: SizedBox.expand(
                  child: _buildScaffoldBody(context, model!),
                ),
                drawer: buildDrawer(),
                drawerEnableOpenDragGesture: drawerEnableOpenDragGesture(),
                bottomNavigationBar: buildBottomNavigationBar(),
                bottomSheet: buildBottomSheet(),
                resizeToAvoidBottomInset: true,
              ),
            );

            if (!willPopPage()) {
              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) async {
                  await onBackPressed(param: result);
                },
                child: scaffold,
              );
            }

            return scaffold;
          },
        );
      },
    );
  }

  //by default back button disable
  bool willPopPage() {
    return false;
  }

  /// Building a appbar of screen

  PreferredSizeWidget? buildAppbar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// Page background color
  Color scaffoldBackgroundColor() {
    return AppColors.background;
  }

  /// Status bar color
  /// In IOS scaffoldBackgroundColor is being applied as status bar color
  Color statusBarColor() {
    return Colors.transparent;
  }

  /// Building a drawer of screen
  Widget? buildDrawer() {
    return null;
  }

  /// Building a bottom-sheet
  Widget? buildBottomSheet() {
    return null;
  }

  /// Building a bottomNavigation Bar
  Widget? buildBottomNavigationBar() {
    return null;
  }

  bool extendBodyBehindAppBar() {
    return true;
  }

  bool drawerEnableOpenDragGesture() {
    return false;
  }

  Widget _buildScaffoldBody(BuildContext context, VM model) {
    return buildView(context, model);
  }

  @mustCallSuper
  Widget buildView(BuildContext context, VM model);

  void _onBaseModelReady(VM model) {
    _viewModel = model;

    /// Prevent multiple execution
    if (_isModelReadyCalled) {
      return;
    }

    _isModelReadyCalled = true;

    if (mounted) {
      onModelReady(model);
    }
  }

  Future<bool> onBackPressed({dynamic param}) {
    return _onWillPop(param);
  }

  Future<bool> _onWillPop(dynamic param) async {
    if (!mounted) return true;

    if (Navigator.canPop(context)) {
      Navigator.pop(context, param);
      return false;
    }

    return true;
  }

  /*Mandatory*/

  /// You can setup load something when model is ready, Ex: Load or fetch some data from remote layer
  void onModelReady(VM model) {}

  /// Declare and initialization of viewModel for the page
  ProviderBase provideBase();

  @override
  Widget build(BuildContext context) {
    return _getLayout();
  }

  @override
  void dispose() {
    _isModelReadyCalled = false;
    super.dispose();
  }
}

abstract class BasePageViewWidget<T extends BasePageViewModel> extends Widget {
  final ProviderBase providerBase;

  const BasePageViewWidget(this.providerBase, {super.key});

  @protected
  Widget build(BuildContext context, T model);

  @override
  DataProviderElement<T> createElement() =>
      DataProviderElement<T>(this, providerBase);
}

class DataProviderElement<T extends BasePageViewModel>
    extends ComponentElement {
  final ProviderBase providerBase;

  DataProviderElement(BasePageViewWidget super.widget, this.providerBase);

  @override
  BasePageViewWidget get widget => super.widget as BasePageViewWidget;

  @override
  Widget build() {
    return BaseWidget<T>(
      providerBase: providerBase,
      builder: (context, model, child) {
        return widget.build(this, model!);
      },
    );
  }
}
