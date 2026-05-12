import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';
import 'package:flutter_clean_architecture/main/navigation/route_path.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash_page_view_model.dart';
import 'package:flutter_clean_architecture/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:flutter_clean_architecture/utils/logger.dart';


class SplashPageView extends BasePageViewWidget<SplashPageViewModel> with Logger {

  const SplashPageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, model) {
    bool isNavigated = false;

    return AppStreamBuilder<double>(
      initialData: 0.0,
      stream: model.gotoDashboardStream,
      onData: (data) {
        logger('Progress : $data');
        if (data >= 0.99 && !isNavigated) {

          isNavigated = true;
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.login,
          );
        }
      },

      dataBuilder: (context, progress) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF5F7FB),
                Color(0xFFEDEFFF),
              ],
            ),
          ),

          child: Stack(
            children: [
              /// TOP RIGHT CIRCLE
              Positioned(
                top: -80,
                right: -60,
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.08),
                  ),
                ),
              ),

              /// BOTTOM LEFT CIRCLE
              Positioned(
                bottom: -100,
                left: -80,
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary.withOpacity(0.08),
                  ),
                ),
              ),

              /// MAIN CONTENT
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        /// LOGO CONTAINER
                        Container(
                          height: 110,
                          width: 110,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),

                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.35),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),

                        const SizedBox(height: 34),

                        /// APP NAME
                        const Text(
                          "Todo by SUMIT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// SUBTITLE
                        const Text(
                          "Organize your tasks.\nBoost your productivity.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 60),

                        /// PROGRESS INDICATOR
                        SizedBox(
                          width: 220,
                          child: Column(
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: LinearProgressIndicator(
                                  minHeight: 8,
                                  value: progress??0.0,
                                  backgroundColor:
                                  AppColors.border,

                                  valueColor:
                                  const AlwaysStoppedAnimation(
                                    AppColors.primary,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              Text(
                                "${((progress??0.0) * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// BOTTOM TEXT
              Positioned(
                bottom: 28,
                left: 0,
                right: 0,
                child: Text(
                  "Made with Flutter ❤️",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}