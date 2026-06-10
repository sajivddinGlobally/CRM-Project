import 'package:crm_app/core/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
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
          "Help & Support",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF262833),
          ),
        ),
        titleSpacing: -6,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              "COMMONLY ASKED QUESTIONS",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF69818C),
              ),
            ),
            SizedBox(height: 15.h),
            _expansionTile(
              title: 'How to add a sale?',
              subtitle:
                  'To add a sale you need to add a sale or learn to add a sale, just try to add something and then pray maybe it ges added automatically ',
            ),
            _expansionTile(
              title: 'How to resolve a ticket?',
              subtitle:
                  'Open the ticket details page, review the issue, and update the ticket status to resolved after completing the required action.',
            ),
            _expansionTile(
              title: 'How to check attendance?',
              subtitle:
                  'Go to the Attendance section from the dashboard to view your daily attendance records and working hours.',
            ),
            _expansionTile(
              title: 'How to apply for leave?',
              subtitle:
                  'Navigate to the Leave section, tap on "Apply Leave", select the leave dates, enter the reason, and submit your request.',
            ),
            _expansionTile(
              title: 'How to resolve a ticket?',
              subtitle:
                  'Open the Client section to view client information, recent activities, contact details, and project updates.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _expansionTile({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.only(left: 0, right: 0),
          title: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF050A14),
              letterSpacing: -.54,
            ),
          ),
          childrenPadding: EdgeInsets.zero,
          dense: true,
          shape: Border.all(color: Colors.transparent),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF69818C),
                    letterSpacing: -0.54,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
      ],
    );
  }
}
