import 'dart:developer' show log;

import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetProfileProvider.dart';
import 'package:crm_app/screen/loginScreen.dart';
import 'package:crm_app/screen/setting/attandanceScreen.dart';
import 'package:crm_app/screen/setting/changePasswordScreen.dart';
import 'package:crm_app/screen/setting/documentScreen.dart';
import 'package:crm_app/screen/setting/editProfleScreen.dart';
import 'package:crm_app/screen/setting/helpSupportScreen.dart';
import 'package:crm_app/screen/setting/notificationSettingScreen.dart';
import 'package:crm_app/screen/setting/performanceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(getProfileProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.scaffBg),
      body: profile.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 170.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF007AFF), Color(0xFF004999)],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                            left: 24.w,
                            top: 30.h,
                          ),
                          child: Text(
                            "Settings",
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        left: 24.w,
                        child: Container(
                          width: 88.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.grey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              data.data?.offerLetter ?? "",
                              fit: BoxFit.cover,
                              width: 88.w,
                              height: 88.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 88.w,
                                  height: 88.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 24.w,
                        bottom: 8.h,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => EditProfleScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 11.h,
                              top: 11.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.buttonBg,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.w,
                              ),
                            ),
                            child: Text(
                              "EDIT PROFILE",
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: -0.54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: data.data?.fullName ?? "John Smith",
                                  style: GoogleFonts.inter(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF050A14),
                                    letterSpacing: -0.54,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " (${data.data?.employeeId ?? 'EMP-1024'})",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF050A14),
                                    letterSpacing: -0.54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "SALES EXECUTIVE",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonBg,
                              letterSpacing: -0.54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.data?.email ?? "smithjoh21@gmail.com",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF263238),
                              letterSpacing: -0.54,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              color: Color(0xFF263238),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            data.data?.phone ?? "+91 XXXXXXX45",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF263238),
                              letterSpacing: -0.54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
                      SizedBox(height: 30.h),
                      _tile(
                        icon: Icons.person_outline,
                        title: 'Personal Info',
                        subtitle: 'View & edit details',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EditProfleScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.description_outlined,
                        title: 'Documents',
                        subtitle: 'ID proofs, contracts',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DocumentScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.bar_chart_outlined,
                        title: 'Performance',
                        subtitle: 'View your performance and KPIs',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PerformanceScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.access_time_outlined,
                        title: 'Attendance',
                        subtitle: 'Shortcut to Activity module',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AttendanceScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.notifications_active_outlined,
                        title: 'Notifications Settings',
                        subtitle: 'Review invoices and payments',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => NotificationSettingScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        subtitle: 'Get help and contact us',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      _tile(
                        icon: Icons.support_agent_outlined,
                        title: 'Help & Support',
                        subtitle: 'Get help and contact us',
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => HelpSupportScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 50.h),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 0,
                              backgroundColor: Color(0xffB71C1C),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              margin: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 20.h,
                              ),
                              content: Text(
                                "Logout Sucessfull",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.1,
                                  height: 1,
                                ),
                              ),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(bottom: 11.h, top: 11.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Color(0xFFFFE5E5),
                          ),
                          child: Center(
                            child: Text(
                              "Logout",
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFF0000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          log(error.toString());
          return PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: Center(
              child: Text(
                "Something went wrong",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: Color(0xFF007AFF))),
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback callback,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: callback,
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Color(0xFFE5F2FF),
              ),
              child: Center(
                child: Icon(icon, color: AppColors.buttonBg, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF050A14),
                    letterSpacing: -0.54,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF263238),
                    letterSpacing: -0.54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
