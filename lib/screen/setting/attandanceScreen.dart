
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/get_attendence_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../core/apiService/apiServiceProvider.dart';
import '../../data/Model/AttendenceSummaryModel.dart';
import '../../data/Model/attendence_history_response.dart';
import '../../data/Model/check_in_response_model.dart' hide Data;
import '../../data/Model/check_out_respomse_model.dart' hide Data;
import '../../data/Provider/get_attendence_summary_provider.dart';

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


class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() =>
      _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {

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
    final attendanceHistoryAsync = ref.watch(getAttendenceHistoryProvider);
    final attendanceSummaryAsync = ref.watch(getAttendenceSummaryProvider);
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
                SizedBox(height: 34.h),
                _buildSectionHeader(),
                SizedBox(height: 20.h),
                attendanceSummaryAsync.when(
                  data: (response) {
                    final summary = response.data?.summary;

                    return _buildChartAndStats(summary!);
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, s) => Center(
                    child: Text(e.toString()),
                  ),
                ),
                // _buildChartAndStats(currentSummary),
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
                attendanceHistoryAsync.when(
                  data: (response) {
                    final logs = response.data ?? [];

                    if (logs.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Center(
                          child: Text("No attendance history found"),
                        ),
                      );
                    }

                    return    _buildLogList(logs);

                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (e, s) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Center(
                      child: Text(e.toString()),
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          attendanceSummaryAsync.when(
            data: (response) {
              final summary = response.data;

              return      _buildBottomActionButton(summary);

            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, s) => Center(
              child: Text(e.toString()),
            ),
          ),

        ],
      ),
    );
  }

  // --- MONTH SELECTOR DESIGN ---
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

  Widget _buildChartAndStats(Summary summary) {
    final totalDays = summary?.totalDays ?? 0;
    final working = summary?.working ?? 0;
    final present = summary?.present ?? 0;
    final late = summary?.late ?? 0;
    final absent = summary?.absent ?? 0;

    final double percent =
    totalDays == 0 ? 0 : (working / totalDays) * 100;    return Row(
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
                summary.working.toString().padLeft(2, '0'),
                const Color(0xff007AFF),
              ),
              SizedBox(height: 8.h),
              _buildStatMetricRow(
                "PRESENT",
                summary.present.toString().padLeft(2, '0'),
                const Color(0xff3D8BFF),
              ),

              SizedBox(height: 8.h),

              _buildStatMetricRow(
                "LATE",
                summary.late.toString().padLeft(2, '0'),
                const Color(0xff0B2C59),
              ),

              SizedBox(height: 8.h),

              _buildStatMetricRow(
                "ABSENT",
                summary.absent.toString().padLeft(2, '0'),
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

  Widget _buildLogList(List<AttendanceLogData> logs) {
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

        switch ((item.status ?? "").toLowerCase()) {
          case "late":
            statusColor = Colors.orange;
            break;
          case "absent":
            statusColor = Colors.red;
            break;
          default:
            statusColor = Colors.green;
        }

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
                    Expanded(
                      child: Text(
                        item.date != null
                            ? "${item.date!.day}/${item.date!.month}/${item.date!.year}"
                            : "-",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  item.checkInTime ?? "-",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  item.checkOutTime ?? "-",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  bool isLoading = false;
  Widget _buildBottomActionButton(Data? summary) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.w),
        width: double.infinity,
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            try {
              final service = ref.read(authServiceProvider);

              final response = summary?.checkedInToday == true
                  ? await service.checkOut(
                latitude: 26.9124,
                longitude: 75.7873,
              )
                  : await service.checkIn(
                latitude: 26.9124,
                longitude: 75.7873,
              );

              String message = "Success";

              if (response is CheckInResponseModel) {
                message = response.message ?? "Success";
              } else if (response is CheckOutResponseModel) {
                message = response.message ?? "Success";
              }

              showError(message);

              // Refresh attendance data
              ref.invalidate(getAttendenceSummaryProvider);
              ref.invalidate(getAttendenceHistoryProvider);

            } on DioException catch (e) {
              setState(() {
                isLoading = false;
              });

              showError(
                e.response?.data["message"] ??
                    e.response?.statusMessage ??
                    "Network Error",
              );
            } catch (e) {
              setState(() {
                isLoading = false;
              });

              showError("Something went wrong");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBg,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            elevation: 0,
          ),
        child: isLoading
          ? SizedBox(
          height: 22.h,
          width: 22.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
      summary?.checkedInToday == true ? "Check Out" : "Check In",
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
