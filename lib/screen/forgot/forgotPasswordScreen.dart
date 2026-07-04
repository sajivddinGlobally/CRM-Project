import 'dart:developer';
import 'dart:math' hide log;

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/pretty.dio.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/screen/forgot/otpVerifyScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool isLoading = false;

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
            SizedBox(height: 47.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/SvgImage/forgotpassImage.svg",
                    width: 295.w,
                    height: 263.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: Divider(color: Color(0xFF263238), thickness: 1.w),
                ),
              ],
            ),
            SizedBox(height: 90.h),
            Text(
              "Reset your password",
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262833),
                letterSpacing: -0.54,
              ),
            ),
            Text(
              "Enter your registered mobile number or email",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5F6480),
                letterSpacing: -0.54,
              ),
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
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
                    "Enter your email",
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
                    borderSide: BorderSide(
                      color: AppColors.buttonBg,
                      width: 1.w,
                    ),
                  ),
                ),
              ),
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
                if (emailController.text.trim().isEmpty) {
                  return;
                }
                setState(() {
                  isLoading = true;
                });

                try {
                  final service = ref.read(authServiceProvider);
                  final response = await service.forgotPasswordData(
                    email: emailController.text.trim(),
                  );
                  if (response.status = true) {
                    log("OTP Send Successfull");
                    showSuccessSnackBar(response.message ?? "");
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            OtpVerifyScreen(email: emailController.text.trim()),
                      ),
                    );
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
                      "Submit Code",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonText,
                      ),
                    ),
            ),
            SizedBox(height: 80.h),
            Text(
              "We’ll send you a verification link on your registered mail, verify\n OTP to update your password.",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7E93),
                letterSpacing: -0.54,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
