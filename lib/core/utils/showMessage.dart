import 'package:crm_app/core/utils/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccessSnackBar(String message) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          gradient: const LinearGradient(
            colors: [
              Color(0xff43A047), // Green
              Color(0xff1B5E20), // Dark Green
            ],
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showErrorMessage({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 20.h),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xffB40A0A),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.white, size: 22.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
