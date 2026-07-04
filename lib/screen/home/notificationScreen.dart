import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/getNotificationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final notifications = [
    {
      "title": "Meeting Scheduled",
      "subtitle": "Discuss project milestones with the team",
      "time": "10 MINS AGO",
    },
    {
      "title": "Document Review",
      "subtitle": "Review the latest contract draft",
      "time": "30 MINS AGO",
    },

    {
      "title": "Email Sent",
      "subtitle": "Sent proposal to client for approval",
      "time": "30 MINS AGO",
    },

    {
      "title": "Task Assigned",
      "subtitle": 'Assign design update to marketing',
      "time": "30 MINS AGO",
    },
  ];

  bool isSelectionMode = false;

  List<int> selectedItems = [];

  void deleteSelected() {
    setState(() {
      notifications.removeWhere(
        (item) => selectedItems.contains(notifications.indexOf(item)),
      );

      selectedItems.clear();
      isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(getNotificationProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            onPressed: () {
              if (isSelectionMode) {
                setState(() {
                  isSelectionMode = false;
                  selectedItems.clear();
                });
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              isSelectionMode ? Icons.close : Icons.arrow_back_ios,
              color: Color(0xFF063466),
              size: 22.sp,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          isSelectionMode
              ? "${selectedItems.length} Selected"
              : "Notifications",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -6,
        actions: [
          if (isSelectionMode)
            IconButton(
              onPressed: deleteSelected,
              icon: Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
            ),
        ],
      ),
      body: notificationState.when(
        data: (data) {
          return SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
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
                  SizedBox(height: 15.h),
                  notificationCard(
                    title: 'Check-in Reminder',
                    subtitle: 'You haven’t checked in yet',
                    time: '5 MINS AGO',
                    buttonText: 'Check In',
                  ),
                  SizedBox(height: 15.h),
                  // card(
                  //   title: 'Meeting Scheduled',
                  //   subtitle: 'Discuss project milestones with the team',
                  //   time: '10 MINS AGO',
                  // ),
                  // SizedBox(height: 10.h),
                  // card(
                  //   title: 'Document Review',
                  //   subtitle: 'Review the latest contract draft',
                  //   time: '30 MINS AGO',
                  // ),
                  // SizedBox(height: 10.h),
                  // card(
                  //   title: 'Email Sent',
                  //   subtitle: 'Sent proposal to client for approval',
                  //   time: '1 HOUR AGO',
                  // ),
                  // SizedBox(height: 10.h),
                  // card(
                  //   title: 'Task Assigned',
                  //   subtitle: 'Assign design update to marketing',
                  //   time: '2 HOUR AGO',
                  // ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    // itemCount: notifications.length,
                    itemCount: data.data?.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedItems.contains(index);
                      return InkWell(
                        borderRadius: BorderRadius.circular(15.r),
                        onLongPress: () {
                          // Light vibration
                          // HapticFeedback.mediumImpact();

                          // HapticFeedback.selectionClick();

                          //  ye strong feel karayega
                          // HapticFeedback.mediumImpact();

                          ///ye heavy feel
                          HapticFeedback.heavyImpact();

                          setState(() {
                            isSelectionMode = true;
                            if (!selectedItems.contains(index)) {
                              selectedItems.add(index);
                            }
                          });
                        },
                        onTap: () {
                          if (isSelectionMode) {
                            setState(() {
                              if (selectedItems.contains(index)) {
                                selectedItems.remove(index);

                                if (selectedItems.isEmpty) {
                                  isSelectionMode = false;
                                }
                              } else {
                                selectedItems.add(index);
                              }
                            });
                          } else {
                            ////  Navigate notofication details screen
                          }
                        },
                        child: listCard(
                          title: data.data?[index].title ?? "",
                          subtitle: data.data?[index].title ?? "",
                          time: data.data?[index].createdAt != null
                              ? timeago.format(
                                  DateTime.parse(
                                    data.data![index].createdAt.toString(),
                                  ).toLocal(),
                                )
                              : "",
                          index: index,
                          isSelected: isSelected,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30.h),
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
      margin: EdgeInsets.only(bottom: 12.h),
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

  Widget listCard({
    required int index,
    required bool isSelected,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE8F2FF) : Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected ? AppColors.buttonBg : const Color(0xFFE5E5E5),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isSelectionMode)
            Padding(
              padding: EdgeInsets.only(right: 14.w),
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: AppColors.buttonBg,
                size: 24.sp,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF050A14),
                          letterSpacing: -0.54,
                        ),
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
          ),
        ],
      ),
    );
  }
}
