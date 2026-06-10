import 'package:crm_app/core/constant/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          "Notifications",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              notificationCard(
                title: 'Urgent Ticket Assigned',
                subtitle: 'Payment issue from Rajesh Traders',
                time: '5 MINS AGO',
                buttonText: 'VIEW TICKET',
              ),
              SizedBox(height: 10.h),
              card(
                title: 'Follow-up Due',
                subtitle: 'Call Suresh Electronics at 4:00 PM',
                time: '5 MINS AGO',
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE6EBF0),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Color(0xFFF3F5F7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sale Added Successfully",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF828489),
                            letterSpacing: -0.54,
                          ),
                        ),
                        Text(
                          "5 MIN AGO",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFAFB4B7),
                            letterSpacing: -0.34,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "You closed ₹5,000 deal",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFAFB4B7),
                        letterSpacing: -0.54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              notificationCard(
                title: 'Check-in Reminder',
                subtitle: 'You haven’t checked in yet',
                time: '5 MINS AGO',
                buttonText: 'Check In',
              ),
              SizedBox(height: 10.h),
              card(
                title: 'Meeting Scheduled',
                subtitle: 'Discuss project milestones with the team',
                time: '10 MINS AGO',
              ),
              SizedBox(height: 10.h),
              card(
                title: 'Document Review',
                subtitle: 'Review the latest contract draft',
                time: '30 MINS AGO',
              ),
              SizedBox(height: 10.h),
              card(
                title: 'Email Sent',
                subtitle: 'Sent proposal to client for approval',
                time: '1 HOUR AGO',
              ),
              SizedBox(height: 10.h),
              card(
                title: 'Task Assigned',
                subtitle: 'Assign design update to marketing',
                time: '2 HOUR AGO',
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationCard({
    required String title,
    required String subtitle,
    required String time,
    required String buttonText,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                time,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF263238),
                  letterSpacing: -0.34,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF677074),
              letterSpacing: -0.54,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Color(0xFFE5F2FF),
            ),
            child: Text(
              buttonText,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.buttonBg,
                letterSpacing: -0.54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget card({
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                time,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF263238),
                  letterSpacing: -0.34,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF677074),
              letterSpacing: -0.54,
            ),
          ),
        ],
      ),
    );
  }
}
