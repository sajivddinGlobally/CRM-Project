import 'dart:developer';

import 'package:crm_app/core/apiService/apiService.dart';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/network/api.stateNetwork.dart';
import 'package:crm_app/core/utils/pretty.dio.dart';
import 'package:crm_app/data/Model/loginBodyModel.dart';
import 'package:crm_app/screen/forgot/forgotPasswordScreen.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final employeeId = TextEditingController();
  final password = TextEditingController();
  bool isPasswordHide = true;
  bool isLoading = false;

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            children: [
              SizedBox(height: 98.h),
              Center(
                child: Text(
                  "🚀 CRM Enterprise",
                  style: GoogleFonts.lexend(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SvgPicture.asset("assets/SvgImage/bro.svg"),
              SizedBox(height: 54.h),
              Text(
                "Login to your",
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF262833),
                ),
              ),
              Text(
                "Arora Industries account",
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF262833),
                  letterSpacing: -0.54,
                ),
              ),
              SizedBox(height: 25.h),
              Divider(
                color: AppColors.buttonBg,
                thickness: 4.h,
                indent: 100,
                endIndent: 100,
                radius: BorderRadius.circular(40.r),
              ),
              SizedBox(height: 30.h),
              _inputForm(
                hintText: "Enter your employee ID",
                type: TextInputType.name,
                controller: employeeId,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "Enter your Password",
                type: TextInputType.visiblePassword,
                controller: password,
                obsureText: true,
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonBg,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
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

                    final response = await service.loginData(
                      employeeId: employeeId.text.trim(),
                      password: password.text.trim(),
                    );

                    if (response.status == true) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (_) => const MyBottomNav()),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.message ?? "Login Failed"),
                        ),
                      );
                    }
                  } catch (e) {
                    if (e is DioException) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 4),
                            margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.h,
                            ),
                            content: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4F4),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFFFD6D6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFE5E5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: Color(0xFFE53935),
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      e.response?.data["message"] ??
                                          "Something went wrong",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF1F2937),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       e.response?.data["message"] ??
                      //           "Something went wrong",
                      //     ),
                      //   ),
                      // );
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 4),
                            margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.h,
                            ),
                            content: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4F4),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFFFD6D6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFE5E5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: Color(0xFFE53935),
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      "Somthing is Went Wrong",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF1F2937),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                    }
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
                        "Login",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonText,
                        ),
                      ),
              ),
              SizedBox(height: 93.h),
              Text(
                "Having trouble logging in? Contact your admin — ",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7A7E93),
                  letterSpacing: -0.54,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "ramesh@aroraindustries.in",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF262833),
                  letterSpacing: -0.54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputForm({
    required TextEditingController controller,
    required TextInputType type,
    required String hintText,
    bool obsureText = false,
  }) {
    return TextField(
      obscureText: obsureText ? isPasswordHide : false,
      controller: controller,
      style: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF263238),
        letterSpacing: -0.1,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
        hint: Text(
          hintText,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7A7E93),
          ),
        ),
        suffixIcon: obsureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordHide = !isPasswordHide;
                  });
                },
                icon: Icon(
                  isPasswordHide
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.sp,
                ),
              )
            : SizedBox(width: 40.w),
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
    );
  }
}
