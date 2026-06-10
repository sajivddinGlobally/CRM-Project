import 'package:crm_app/core/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

// --- DUMMY DATA MODELS ---
class AttendanceSummary {
  final int totalDays;
  final int workingDays;
  final int presentDays;
  final int lateDays;
  final int absentDays;

  AttendanceSummary({
    required this.totalDays,
    required this.workingDays,
    required this.presentDays,
    required this.lateDays,
    required this.absentDays,
  });
}

class AttendanceLog {
  final String date;
  final String checkIn;
  final String checkOut;
  final int statusType; // 0 = Present, 1 = Late, 2 = Absent

  AttendanceLog({
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.statusType,
  });
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // 1. Current Selected Month State
  String selectedMonth = "March";

  // Available Months List for Dropdown
  final List<String> monthsList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  // 2. Dynamic Dummy Data Map (Changes based on selected month)
  final Map<String, AttendanceSummary> monthlySummaries = {
    "March": AttendanceSummary(
      totalDays: 31,
      workingDays: 27,
      presentDays: 26,
      lateDays: 2,
      absentDays: 1,
    ),
    "April": AttendanceSummary(
      totalDays: 30,
      workingDays: 24,
      presentDays: 22,
      lateDays: 1,
      absentDays: 1,
    ),
    "May": AttendanceSummary(
      totalDays: 31,
      workingDays: 26,
      presentDays: 25,
      lateDays: 0,
      absentDays: 1,
    ),
  };

  final Map<String, List<AttendanceLog>> monthlyLogs = {
    "March": [
      AttendanceLog(
        date: "31 March 2026",
        checkIn: "09:02 AM",
        checkOut: "—",
        statusType: 0,
      ),
      AttendanceLog(
        date: "29 March 2026",
        checkIn: "09:14 AM",
        checkOut: "06:18 PM",
        statusType: 0,
      ),
      AttendanceLog(
        date: "29 March 2026",
        checkIn: "—",
        checkOut: "—",
        statusType: 2,
      ),
      AttendanceLog(
        date: "29 March 2026",
        checkIn: "10:14 AM",
        checkOut: "06:18 PM",
        statusType: 1,
      ),
    ],
    "April": [
      AttendanceLog(
        date: "15 April 2026",
        checkIn: "09:00 AM",
        checkOut: "06:00 PM",
        statusType: 0,
      ),
      AttendanceLog(
        date: "14 April 2026",
        checkIn: "09:30 AM",
        checkOut: "06:15 PM",
        statusType: 1,
      ),
    ],
    "May": [
      AttendanceLog(
        date: "02 May 2026",
        checkIn: "08:55 AM",
        checkOut: "05:45 PM",
        statusType: 0,
      ),
    ],
  };
  @override
  Widget build(BuildContext context) {
    // Fallback if data for selected month doesn't exist in dummy data
    final currentSummary =
        monthlySummaries[selectedMonth] ??
        AttendanceSummary(
          totalDays: 30,
          workingDays: 22,
          presentDays: 20,
          lateDays: 1,
          absentDays: 1,
        );
    final currentLogs = monthlyLogs[selectedMonth] ?? [];
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        elevation: 0,
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
        titleSpacing: -6,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF262833),
              ),
            ),
            Text(
              "MONDAY, 31 MARCH 2026",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF7A7E93),
                fontWeight: FontWeight.w400,
                letterSpacing: -0.54,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                _buildCheckInCard(),
                SizedBox(height: 20.h),
                Text(
                  "Today's ATTENDANCE SUMMARY",
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF69818C),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffEEF2F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            _headerText("FIELD"),
                            _headerText("DETAILS"),
                          ],
                        ),
                      ),
                      _row(title: "Check In", value: "09:02 AM"),
                      _row(title: "Check Out", value: "— (pending)"),
                      _row(title: "Hours Worked", value: "01:24:38 (live)"),
                      _row(
                        title: "Biometric Sync",
                        value: "✅ Synced — BIO-003",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34.h),
                _buildSectionHeader(),
                SizedBox(height: 20.h),
                _buildChartAndStats(currentSummary),
                SizedBox(height: 40.h),
                Text(
                  "MONTHLY ATTENDANCE LOG",
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF69818C),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildLogTableHeader(),
                _buildLogList(currentLogs),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          _buildBottomActionButton(),
        ],
      ),
    );
  }

  Widget _headerText(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF063466),
            letterSpacing: -0.54,
          ),
        ),
      ),
    );
  }

  Widget _row({
    required String title,
    required String value,
    bool isLast = false,
    bool highlight = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Color(0xFFE5E5E5), width: 1.w),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: highlight ? FontWeight.w500 : FontWeight.w400,
                  color: highlight
                      ? const Color(0xff0E4173)
                      : const Color(0xFF5F6273),
                  letterSpacing: -0.54,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
                  color: highlight
                      ? const Color(0xFF063466)
                      : const Color(0xFF262833),
                  letterSpacing: -0.54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "THIS MONTH'S ATTENDANCE",
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF69818C),
          ),
        ),

        PopupMenuButton<String>(
          onSelected: (String value) {
            setState(() {
              selectedMonth = value;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: Color(0xFFE9E9EB), width: 1.w),
          ),
          elevation: 3,
          color: Colors.white,
          itemBuilder: (BuildContext context) {
            return monthsList.map((String month) {
              return PopupMenuItem<String>(
                value: month,
                height: 40.h,
                child: Text(
                  month,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: selectedMonth == month
                        ? AppColors.buttonBg
                        : Colors.black87,
                    fontWeight: selectedMonth == month
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedMonth,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Color(0xFF262833),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.54,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.sp,
                  color: Color(0xFF262833),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- REST OF THE UI PARTS WITH PASSED PARAMETERS ---

  Widget _buildCheckInCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(0xFF007AFF), Color(0xFF004999)],
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 165.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(51, 255, 255, 255),
                  Color.fromARGB(0, 255, 255, 255),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
              child: Text(
                "Check In Card",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.54,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STATUS",
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB3D7F3),
                        letterSpacing: -0.54,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "🔴 Not Checked In",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.54,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "LOCATION",
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB3D7F3),
                        letterSpacing: -0.54,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Ludhiana 📍",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartAndStats(AttendanceSummary summary) {
    final double percent = (summary.workingDays / summary.totalDays) * 100;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Chart
        Expanded(
          flex: 4,
          child: Container(
            height: 230.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Main circular chart
                SfRadialGauge(
                  axes: [
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      startAngle: 90,
                      endAngle: 90,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle: AxisLineStyle(
                        thickness: 26.w,
                        color: const Color(0xFFE5F2FF),
                        thicknessUnit: GaugeSizeUnit.logicalPixel,
                      ),
                      pointers: [
                        /// Blue arc
                        RangePointer(
                          value: percent,
                          width: 26.w,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color(0xff007AFF),
                        ),

                        /// Red bubble
                        MarkerPointer(
                          value: percent + 2,
                          markerType: MarkerType.rectangle,
                          markerWidth: 22.w,
                          markerHeight: 10.h,
                          color: Color(0xFFFF0000),
                        ),

                        // / Dark bubble
                        MarkerPointer(
                          value: percent + 6,
                          markerType: MarkerType.circle,
                          markerWidth: 25.w,
                          markerHeight: 25.w,
                          color: const Color(0xFF063466),
                        ),

                        /// Dark blue bubble
                        MarkerPointer(
                          value: percent + 12,
                          markerType: MarkerType.circle,
                          markerWidth: 28.w,
                          markerHeight: 28.w,
                          color: const Color(0xFF0056B3),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "TOTAL DAYS",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF263238),
                        letterSpacing: -0.54,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${summary.totalDays}",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
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
        ),
        SizedBox(width: 12.w),

        /// Right stats
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildStatMetricRow(
                "WORKING",
                summary.workingDays.toString().padLeft(2, '0'),
                const Color(0xff007AFF),
              ),
              SizedBox(height: 8.h),
              _buildStatMetricRow(
                "PRESENT",
                summary.presentDays.toString().padLeft(2, '0'),
                const Color(0xff3D8BFF),
              ),

              SizedBox(height: 8.h),

              _buildStatMetricRow(
                "LATE",
                summary.lateDays.toString().padLeft(2, '0'),
                const Color(0xff0B2C59),
              ),

              SizedBox(height: 8.h),

              _buildStatMetricRow(
                "ABSENT",
                summary.absentDays.toString().padLeft(2, '0'),
                Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatMetricRow(
    String label,
    String value,
    Color indicatorColor, {
    bool isAbsent = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border(
          left: BorderSide(color: indicatorColor, width: 3.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: isAbsent ? Colors.red : Colors.grey.shade600,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.54,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: indicatorColor,
              letterSpacing: -0.54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Color(0xFFE6EBF0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "DATE",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF063466),
                letterSpacing: -0.54,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "CHECK IN",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF063466),
                letterSpacing: -0.54,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "CHECK OUT",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF063466),
                letterSpacing: -0.54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogList(List<AttendanceLog> logs) {
    if (logs.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(child: Text("No records found for this month.")),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: logs.length,
      separatorBuilder: (_, __) =>
          Divider(height: 1.h, color: Colors.grey.shade200),
      itemBuilder: (context, index) {
        final item = logs[index];
        Color statusColor = Colors.green;
        if (item.statusType == 1) statusColor = Colors.amber;
        if (item.statusType == 2) statusColor = Colors.red;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      item.date,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Color(0xFF262833),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  item.checkIn,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Color(0xFF262833),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.54,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  item.checkOut,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Color(0xFF262833),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.54,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.w),
        width: double.infinity,
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            elevation: 0,
          ),
          child: Text(
            "Check Out",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
