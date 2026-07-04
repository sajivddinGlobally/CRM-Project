import 'dart:developer';

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
          color: const Color(0xFFFFF5F5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFFECACA)),
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
            Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF007AFF),
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Color(0xFF007AFF),
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

void showErrorSnackBar(String message) {
  final context = navigatorKey.currentContext;
  log("CONTEXT => $context");

  if (context == null) {
    log("Context is NULL");
    return;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5F5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFFECACA)),
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
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFDC2626),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF262833),
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
