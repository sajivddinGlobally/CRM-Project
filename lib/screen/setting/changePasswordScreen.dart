import 'dart:developer';

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF262833),
              size: 22.sp,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          "Change Password",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF262833),
          ),
        ),
        titleSpacing: -6,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            _inputForm(
              hintText: "Enter Current Password",
              type: TextInputType.visiblePassword,
              controller: oldPasswordController,
            ),
            _inputForm(
              hintText: "Enter New Password",
              type: TextInputType.visiblePassword,
              controller: newPasswordController,
            ),
            _inputForm(
              hintText: "Confirm New Password",
              type: TextInputType.visiblePassword,
              controller: confirmPasswordController,
            ),
            Expanded(child: SizedBox()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(392.w, 56.h),
                backgroundColor: AppColors.buttonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              onPressed: () async {
                if (newPasswordController.text.trim().isEmpty) {
                  return;
                }
                if (confirmPasswordController.text.trim().isEmpty) {
                  return;
                }

                if (oldPasswordController.text.trim().isEmpty) {
                  return;
                }
                if (newPasswordController.text.trim() !=
                    confirmPasswordController.text.trim()) {
                  showErrorSnackBar("Password do not match");
                }
                setState(() {
                  isLoading = true;
                });
                try {
                  final service = ref.read(authServiceProvider);
                  final response = await service.ChangePasswordData(
                    newPassword: newPasswordController.text.trim(),
                    confirmPassword: confirmPasswordController.text.trim(),
                    oldPassword: oldPasswordController.text.trim(),
                  );
                  if (response.status == true) {
                    showSuccessSnackBar(response.message ?? "");
                    Navigator.pop(context);
                  }
                } catch (e) {
                  setState(() => isLoading = false);
                } finally {
                  setState(() {
                    isLoading = false;
                  });
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
                      "Update Password",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonText,
                      ),
                    ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _inputForm({
    required String hintText,
    required TextInputType type,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextField(
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
