import 'package:crm_app/core/constant/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool pushNotification = true;
  bool emailNotification = true;
  bool smsNotification = false;
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
              color: Color(0xFF063466),
              size: 22.sp,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          "Notification Settings",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -6,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildToggleTile(
              title: "Push Notifications",
              value: pushNotification,
              onChanged: (value) {
                setState(() {
                  pushNotification = value;
                });
              },
            ),
            buildSection(title: "SALES UPDATES", enabled: pushNotification),
            buildToggleTile(
              title: "Email Notifications",
              value: emailNotification,
              onChanged: (value) {
                setState(() {
                  emailNotification = value;
                });
              },
            ),
            buildSection(title: "SALES UPDATES", enabled: emailNotification),
            buildToggleTile(
              title: "SMS Notifications",
              value: smsNotification,
              onChanged: (value) {
                setState(() {
                  smsNotification = value;
                });
              },
            ),
            buildSection(title: "SALES UPDATES", enabled: smsNotification),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required String title, required bool enabled}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22.h, bottom: 12.h),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: enabled
                  ? const Color(0xFF69818C)
                  : const Color(0xFFC3CDD1),
            ),
          ),
        ),
        buildCheckRow(text: "New sale added", enabled: enabled),
        buildCheckRow(text: "Target updates", enabled: enabled),
        SizedBox(height: 14.h),
        Text(
          "TICKET ALERTS",
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: enabled ? const Color(0xFF8A99A8) : const Color(0xFFC8CDD2),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10.h),
        buildCheckRow(text: "New ticket assigned", enabled: enabled),
        buildCheckRow(text: "Status updates", enabled: enabled),
        SizedBox(height: 14.h),
        Text(
          "REMINDERS",
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: enabled ? const Color(0xFF8A99A8) : const Color(0xFFC8CDD2),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10.h),
        buildCheckRow(text: "Follow-ups", enabled: enabled),
        buildCheckRow(text: "Check-in reminders", enabled: enabled),
      ],
    );
  }

  Widget buildCheckRow({required String text, required bool enabled}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: enabled
                    ? const Color(0xFF050A14)
                    : const Color(0xFF9B9DA1),
                letterSpacing: -0.54,
              ),
            ),
          ),
          Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Transform.scale(
              scale: 0.8,
              child: Checkbox(
                value: enabled,
                onChanged: (value) {},
                activeColor: const Color(0xFF007AFF),
                side: BorderSide(
                  color: enabled ? AppColors.buttonBg : const Color(0xFF999999),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildToggleTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF050A14),
                letterSpacing: -0.54,
              ),
            ),
          ),
          Container(
            height: 35.h,
            width: 45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Transform.scale(
              scale: 0.6,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: AppColors.buttonBg,
                inactiveThumbColor: Colors.white,
                activeThumbColor: Colors.white,
                inactiveTrackColor: Color(0xFFACB5BF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
