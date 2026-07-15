import 'dart:developer';

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetLeadFollowUpReminderProvider.dart';
import 'package:crm_app/data/Provider/GetLeadProvider.dart';
import 'package:crm_app/data/Provider/leadDetailsProvider.dart';
import 'package:crm_app/data/Provider/leadFilterProvider.dart';
import 'package:crm_app/screen/lead/addNewLeadScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeadDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const LeadDetailScreen({super.key, required this.id});

  @override
  ConsumerState<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends ConsumerState<LeadDetailScreen> {
  void _showActionMenu() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(button.size.width, 90.h, 20.w, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Colors.white,
      items: [
        _menuItem(Icons.edit, "Edit Lead", () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddnewLeadScreen(leadId: leadId),
            ),
          );
          log("Lead Id $leadId");
        }),
        _menuItem(Icons.cancel_outlined, "Mark Lost", () async {
          try {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.buttonBg),
                  ),
                );
              },
            );
            final res = ref.read(authServiceProvider);
            final isScuess = await res.markLostLeadData(id: markId!);
            if (isScuess) {
              ref.invalidate(leadProvider);
              Navigator.pop(context, true);
            }
          } catch (e) {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            log(e.toString());
          } finally {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        }),
        _menuItem(Icons.delete, "Delete", () async {
          try {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.buttonBg),
                  ),
                );
              },
            );
            final res = ref.read(authServiceProvider);
            final isScuess = await res.leadDelete(id: leadId!);
            if (isScuess) {
              ref.invalidate(leadProvider);
              ref.invalidate(leadFilterProvider("new"));
              Navigator.pop(context, true);
            }
          } catch (e) {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            log(e.toString());
          } finally {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        }),
      ],
    );
  }

  PopupMenuItem _menuItem(IconData icon, String title, VoidCallback callback) {
    return PopupMenuItem(
      value: title,
      onTap: callback,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF063466), size: 20.sp),
          SizedBox(width: 10.w),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF063466),
            ),
          ),
        ],
      ),
    );
  }

  String? leadId;
  String? markId;

  @override
  Widget build(BuildContext context) {
    final leadDetailState = ref.watch(leadDetailsProvider(widget.id));
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
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
          "Lead Details",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: 0,
        actionsPadding: EdgeInsets.only(right: 8.w),
        actions: [
          IconButton(
            onPressed: () {
              _showActionMenu();
            },
            icon: Icon(
              Icons.more_horiz,
              color: const Color(0xFF063466),
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: leadDetailState.when(
        data: (data) {
          leadId = data.data?.id.toString();
          markId = data.data?.id.toString();
          final preferredDate = data.data?.reminderDate != null
              ? DateFormat(
                  "dd MMM yyyy",
                ).format(DateTime.parse(data.data!.reminderDate.toString()))
              : "";

          final preferredTime = data.data?.preferredTime != null
              ? DateFormat(
                  "hh:mm a",
                ).format(DateFormat("HH:mm").parse(data.data!.preferredTime!))
              : "";

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Color(0xFFE6EEF8), Color(0xFFE6F2FF)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 15.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: Color(0xFFFFE6E6),
                              ),
                              child: Text(
                                "HOT LEAD",
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF0000),
                                  letterSpacing: -0.54,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 11.h,
                                horizontal: 14.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFFE5F8ED),
                              ),
                              child: Center(
                                child: Text(
                                  "CONTACTED",
                                  style: GoogleFonts.inter(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF00B94A),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          // "#SAL-1024 Rajesh Electronics",
                          data.data?.assignedTo ?? "N/A",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: Color(0xFF050A14),
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.54,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // "RAJESH SHARMA",
                              data.data?.leadName ?? "N/A",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
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
                              // "28 Apr 2026",
                              preferredDate,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
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
                              "ADMIN ASSIGNED",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF263238),
                                letterSpacing: -0.54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "CONTACT INFORMATION",
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
                        bottom: BorderSide(
                          color: Color(0xFFE5E5E5),
                          width: 1.w,
                        ),
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
                        _row(
                          title: "Phone Number",
                          value: "${data.data?.mobileNumber ?? ""}",
                        ),
                        if (data.data!.alternateContact!.isNotEmpty)
                          _row(
                            title: "Alternate Number",
                            value: "${data.data?.alternateContact ?? ""}",
                          ),
                        _row(
                          title: "Email",
                          value: "${data.data?.email ?? ""}",
                        ),
                        _row(
                          title: "Location",
                          value:
                              "${data.data?.address ?? ""} ${data.data?.city ?? ""}",
                        ),
                        if (preferredTime.isNotEmpty)
                          _row(
                            title: "Preferred Contact Time",
                            value: "$preferredTime",
                          ),
                        _row(
                          title: "Final Amount",
                          value: "₹${data.data?.budgetRange ?? ""}",
                          isLast: true,
                          highlight: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "INTEREST DETAILS",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF69818C),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 21.h,
                      horizontal: 21.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium Plan",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: Color(0xFF050A14),
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.54,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "₹15,000",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF063466),
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
                              "01 May 2026",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF263238),
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
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("Something went wrong"));
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: AppColors.buttonBg)),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 10.h),
        color: AppColors.scaffBg,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: Color(0xFFDaECFF),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  showRescheduleBottomSheet(context, leadId.toString());
                },
                child: Text(
                  "Schedule Follow-up",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttonBg,
                    letterSpacing: -0.54,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: AppColors.buttonBg,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Convert Lead",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: -0.54,
                  ),
                ),
              ),
            ),
          ],
        ),
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
}

String? formatDateForApi(DateTime? date) {
  if (date == null) return null;
  return DateFormat("yyyy-MM-dd").format(date);
}

String? formatTimeForApi(TimeOfDay? time) {
  if (time == null) return null;

  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

void showRescheduleBottomSheet(BuildContext context, String id) {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController noteController = TextEditingController();
  bool isReschedule = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Handle
                    Center(
                      child: Container(
                        width: 55.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h),

                    /// Title
                    Text(
                      "Reschedule Follow-up",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF063466),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// Date & Time
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: Container(
                              height: 55.h,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedDate == null
                                          ? "Select Date"
                                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 20.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                setState(() {
                                  selectedTime = pickedTime;
                                });
                              }
                            },
                            child: Container(
                              height: 55.h,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedTime == null
                                          ? "Select Time"
                                          : selectedTime!.format(context),
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    size: 20.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    /// Note
                    TextField(
                      controller: noteController,
                      maxLines: 4,
                      style: GoogleFonts.inter(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Enter reminder note",
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF007AFF),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF007AFF),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF007AFF),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 14.w),

                        Consumer(
                          builder: (context, ref, child) {
                            return Expanded(
                              child: SizedBox(
                                height: 50.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF007AFF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isReschedule = true;
                                    });
                                    try {
                                      final service = ref.read(
                                        authServiceProvider,
                                      );
                                      final res = await service
                                          .rescheduleFollowUpLead(
                                            id: id,
                                            reminderDate: formatDateForApi(
                                              selectedDate,
                                            )!,
                                            reminderTime: formatTimeForApi(
                                              selectedTime,
                                            )!,
                                            reminderNote: noteController.text
                                                .trim(),
                                          );

                                      if (res) {
                                        ref.invalidate(leadDetailsProvider);
                                        Navigator.pop(context);
                                      }
                                    } catch (e) {
                                      log(e.toString());
                                    } finally {
                                      setState(() {
                                        isReschedule = false;
                                      });
                                    }
                                  },
                                  child: isReschedule
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 1.5,
                                          ),
                                        )
                                      : Text(
                                          "Save",
                                          style: GoogleFonts.inter(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
