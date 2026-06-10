import 'package:crm_app/core/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InteractionHistoryScreen extends StatefulWidget {
  const InteractionHistoryScreen({super.key});

  @override
  State<InteractionHistoryScreen> createState() =>
      _InteractionHistoryScreenState();
}

class _InteractionHistoryScreenState extends State<InteractionHistoryScreen> {
  final List<Map<String, dynamic>> activityList = [
    {
      "icon": Icons.call_outlined,
      "iconBg": const Color(0xFFE5F2FF),
      "iconColor": const Color(0xFF007AFF),
      "title": "Call with client",
      "subtitle": "Discussed renewal pricing",
      "date": "01 MAY 2026 • 11:30 AM",
    },
    {
      "icon": Icons.attach_money,
      "iconBg": const Color(0xFFE7F8F4),
      "iconColor": const Color(0xFF1BB394),
      "title": "Sale Completed",
      "subtitle": "₹12,000 • Premium Plan",
      "date": "01 MAY 2026 • 11:30 AM",
    },
    {
      "icon": Icons.attach_money,
      "iconBg": const Color(0xFFE7F8F4),
      "iconColor": const Color(0xFF1BB394),
      "title": "Sale Completed",
      "subtitle": "₹12,000 • Premium Plan",
      "date": "01 MAY 2026 • 11:30 AM",
    },
    {
      "icon": Icons.attach_money,
      "iconBg": const Color(0xFFE7F8F4),
      "iconColor": const Color(0xFF1BB394),
      "title": "Sale Completed",
      "subtitle": "₹12,000 • Premium Plan",
      "date": "01 MAY 2026 • 11:30 AM",
    },
    {
      "icon": Icons.attach_money,
      "iconBg": const Color(0xFFE7F8F4),
      "iconColor": const Color(0xFF1BB394),
      "title": "Sale Completed",
      "subtitle": "₹12,000 • Premium Plan",
      "date": "01 MAY 2026 • 11:30 AM",
    },
  ];
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
          "Interaction History",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -6,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (context, index) {
            final item = activityList[index];
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item["iconBg"],
                        ),
                        child: Icon(
                          item["icon"],
                          size: 16.sp,
                          color: item["iconColor"],
                        ),
                      ),
                      if (index != activityList.length - 1)
                        Expanded(
                          child: Container(
                            width: 1.w,
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            color: const Color(0xFFE5E5E5),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"],
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF050A14),
                              letterSpacing: -0.54,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            item["subtitle"],
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF263238),
                              letterSpacing: -0.54,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            item["date"],
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF263238),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          width: 177.w,
          height: 81.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Color(0xFF007AFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              Text(
                "Add New Interaction ",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -0.54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
