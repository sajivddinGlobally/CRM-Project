import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/screen/forgot/forgotPasswordScreen.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              _inputForm(hintText: "Enter your employee ID"),
              SizedBox(height: 10.h),
              _inputForm(hintText: "Enter your Password"),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => MyBottomNav()),
                  );
                },
                child: Text(
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

  Widget _inputForm({required String hintText}) {
    return TextField(
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
