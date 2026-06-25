import 'dart:developer' show log;

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/screen/loginScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const CreatePasswordScreen({super.key, required this.email});

  @override
  ConsumerState<CreatePasswordScreen> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool isNewPasswordHide = true;
  bool isConfirmPasswordHide = true;
  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.scaffBg,
        foregroundColor: Color(0xFF263238),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/SvgImage/resetPasswordImage.svg",
                    width: 295.w,
                    height: 263.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 0,
                  right: 0,
                  child: Divider(color: Color(0xFF263238), thickness: 1.w),
                ),
              ],
            ),
            SizedBox(height: 80.h),
            Text(
              "Create a new password",
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262833),
                letterSpacing: -0.54,
              ),
            ),
            Text(
              "Your new password must be different from your\n previous password.",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5F6480),
                letterSpacing: -0.54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 29.h),
            Divider(
              color: AppColors.buttonBg,
              thickness: 4.h,
              indent: 100,
              endIndent: 100,
              radius: BorderRadius.circular(40.r),
            ),
            SizedBox(height: 30.h),
            _inputForm(
              hintText: "Enter new password",
              controller: newPasswordController,
              type: TextInputType.visiblePassword,
              obsureText: true,
              isHidden: isNewPasswordHide,
              onToggle: () {
                setState(() {
                  isNewPasswordHide = !isNewPasswordHide;
                });
              },
            ),
            SizedBox(height: 10.h),
            _inputForm(
              hintText: "Confirm new password",
              controller: confirmPasswordController,
              type: TextInputType.visiblePassword,
              obsureText: true,
              isHidden: isConfirmPasswordHide,
              onToggle: () {
                setState(() {
                  isConfirmPasswordHide = !isConfirmPasswordHide;
                });
              },
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(392.w, 56.h),
                backgroundColor: AppColors.buttonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                try {
                  final service = ref.read(authServiceProvider);
                  final response = await service.CreatePasswordData(
                    email: widget.email,
                    newPassword: newPasswordController.text.trim(),
                    confirmNewPassword: confirmPasswordController.text.trim(),
                  );
                  if (response.status = true) {
                    log("New Password Successfull");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                } on DioException catch (e) {
                  setState(() => isLoading = false);

                  showError(e.response?.data.toString() ?? "Network Error");
                } catch (e) {
                  setState(() => isLoading = false);

                  showError("Something went wrong");
                }
              },
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Reset Password",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonText,
                      ),
                    ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _inputForm({
    required String hintText,
    required TextEditingController controller,
    required TextInputType type,
    required bool isHidden,
    required VoidCallback onToggle,
    bool obsureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      child: TextField(
        obscureText: obsureText ? isHidden : false,
        controller: controller,
        keyboardType: type,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF263238),
          letterSpacing: -0.1,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 18.h,
          ),
          suffixIcon: obsureText
              ? IconButton(
                  onPressed: onToggle,
                  icon: Icon(
                    isHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20.sp,
                  ),
                )
              : SizedBox(width: 40.w),
          hint: Text(
            hintText,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7A7E93),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Color.fromARGB(25, 0, 0, 0),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.buttonBg, width: 1.w),
          ),
        ),
      ),
    );
  }
}
