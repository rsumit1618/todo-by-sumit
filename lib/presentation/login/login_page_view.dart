import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';
import 'package:flutter_clean_architecture/presentation/login/login_page_view_model.dart';

class LoginPageView extends BasePageViewWidget<LoginPageViewModel> {
  const LoginPageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, LoginPageViewModel model) {
    final size = MediaQuery.of(context).size;
    final isSmallHeight = size.height < 700;

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: isSmallHeight ? 12 : 20,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              padding: EdgeInsets.all(isSmallHeight ? 18 : 24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Section
                  _buildHeader(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 20 : 32),

                  // Welcome Section
                  _buildWelcomeSection(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 24 : 32),

                  // Email Field
                  _buildEmailField(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 18 : 22),

                  // Password Field
                  _buildPasswordField(isSmallHeight),

                  const SizedBox(height: 8),

                  // Forgot Password
                  _buildForgotPasswordButton(),

                  SizedBox(height: isSmallHeight ? 12 : 18),

                  // Login Button
                  _buildLoginButton(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 16 : 20),

                  // Divider
                  _buildDivider(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 16 : 22),

                  // Email Login Button
                  _buildEmailLoginButton(isSmallHeight),

                  SizedBox(height: isSmallHeight ? 18 : 28),

                  // Skip Login
                  _buildSkipLoginButton(isSmallHeight),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallHeight) {
    return Row(
      children: [
        // Logo
        Container(
          height: isSmallHeight ? 48 : 55,
          width: isSmallHeight ? 48 : 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.onPrimary,
            size: isSmallHeight ? 26 : 30,
          ),
        ),
        const SizedBox(width: 14),
        // App Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Todo by SUMIT",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isSmallHeight ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Manage your daily tasks beautifully",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isSmallHeight ? 12 : 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection(bool isSmallHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back 👋",
          style: TextStyle(
            fontSize: isSmallHeight ? 26 : 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Login to continue managing your tasks efficiently.",
          style: TextStyle(
            fontSize: isSmallHeight ? 13 : 15,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(bool isSmallHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: "Enter your email",
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: EdgeInsets.symmetric(vertical: isSmallHeight ? 16 : 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(bool isSmallHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: true,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: "Enter your password",
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
            suffixIcon: const Icon(Icons.visibility_off_outlined, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: EdgeInsets.symmetric(vertical: isSmallHeight ? 16 : 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 6),
        ),
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(bool isSmallHeight) {
    return SizedBox(
      width: double.infinity,
      height: isSmallHeight ? 52 : 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.30),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: isSmallHeight ? 15 : 17,
              fontWeight: FontWeight.w700,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isSmallHeight) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "OR",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: isSmallHeight ? 12 : 14,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildEmailLoginButton(bool isSmallHeight) {
    return SizedBox(
      width: double.infinity,
      height: isSmallHeight ? 50 : 56,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.mail_outline_rounded),
        label: Text(
          "Login with Email",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isSmallHeight ? 14 : 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipLoginButton(bool isSmallHeight) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Skip Login",
          style: TextStyle(
            fontSize: isSmallHeight ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}