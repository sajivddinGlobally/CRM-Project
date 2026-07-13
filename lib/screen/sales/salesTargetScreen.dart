import 'dart:developer';

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/data/Provider/GetLeadFollowUpReminderProvider.dart';
import 'package:crm_app/data/Provider/GetLeadProvider.dart';
import 'package:crm_app/data/Provider/GetSaleProvider.dart';
import 'package:crm_app/data/Provider/get_dashboard_provider.dart';
import 'package:crm_app/screen/lead/leadDetailScreen.dart';
import 'package:crm_app/screen/lead/leadScreen.dart';
import 'package:crm_app/screen/sales/addSaleScreen.dart';
import 'package:crm_app/screen/sales/salesDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SalesTargetScreen extends ConsumerStatefulWidget {
  const SalesTargetScreen({super.key});

  @override
  ConsumerState<SalesTargetScreen> createState() => _SalesTargetScreenState();
}

class _SalesTargetScreenState extends ConsumerState<SalesTargetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double targetValue = 145000 / 200000;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: targetValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  final PageController _pageController = PageController(viewportFraction: 0.90);
  final PageController _salePageController = PageController(
    viewportFraction: 0.90,
  );
  int tabIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isMarking = false;

  @override
  Widget build(BuildContext context) {
    final getSale = ref.watch(getSaleProvider);
    final leadState = ref.watch(leadProvider);
    final dashboardAsync = ref.watch(dashboardProvider);
    final getFollowUpState = ref.watch(getLeadFollowUpReminderProvider);
    final isLoading =
        getSale.isLoading ||
        leadState.isLoading ||
        dashboardAsync.isLoading ||
        getFollowUpState.isLoading;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.buttonBg),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(0xFFE6EEFA)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardAsync.when(
              data: (data) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(color: Color(0xFFECECF9)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sales & Targets",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF063466),
                          letterSpacing: -0.54,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 20.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF007AFF), Color(0xFF002199)],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58.w,
                                          height: 58.w,
                                          child: CircularProgressIndicator(
                                            // value: _animation.value,
                                            value:
                                                ((data
                                                        .data
                                                        ?.sales
                                                        ?.achievementPercentage ??
                                                    0) /
                                                100),
                                            strokeWidth: 6,
                                            backgroundColor: Color(0xFF4493F3),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          // "${(_animation.value * 100).toInt()}%",
                                          "${data.data?.sales?.achievementPercentage ?? 0}%",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(width: 16.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Monthly Target",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(
                                          204,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.w),
                                    Text(
                                      // "₹1,45,000 / ₹2,00,000",
                                      "₹${data.data?.sales?.totalSalesValue ?? 0} / ₹${data.data?.sales?.target ?? 0}",
                                      style: GoogleFonts.inter(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          salesCard("Today’s Sales", "₹12,000"),
                          SizedBox(width: 10.w),
                          salesCard("Avg Daily", "₹8,500"),
                          SizedBox(width: 10.w),
                          salesCard("Required Daily", "₹9,200"),
                        ],
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text("Something went wrong"));
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: AppColors.buttonBg),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSale.when(
                  data: (data) {
                    final salesList = data.data ?? [];

                    if (salesList.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Text(
                            "Recent Sales",
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E1E1E),
                              letterSpacing: -0.54,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12.h),
                          height: 200.h,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: data.data?.length,
                            itemBuilder: (context, index) {
                              final item = data.data?[index];
                              return Container(
                                margin: EdgeInsets.only(right: 15.w),
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                  bottom: 20.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Color.fromARGB(25, 0, 0, 0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 15.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              7.r,
                                            ),
                                            color: Color.fromARGB(
                                              25,
                                              0,
                                              122,
                                              255,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "PREMIUM PLAN",
                                              style: GoogleFonts.inter(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF007AFF),
                                                letterSpacing: -0.54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 15.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              7.r,
                                            ),
                                            color: Color.fromARGB(
                                              25,
                                              181,
                                              197,
                                              0,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item?.paymentStatus ?? "PENDING",
                                              style: GoogleFonts.inter(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XffB5C500),
                                                letterSpacing: -0.54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      item?.employee?.fullName ??
                                          "Sharma Traders",
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
                                          "₹5,000",
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF007AFF),
                                            letterSpacing: -0.54,
                                            height: 0,
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
                                          "${item?.time}",
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF263238),
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                SalesDetailScreen(
                                                  id: item!.id.toString(),
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: AppColors.buttonBg,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "VIEW DETAILS",
                                            style: GoogleFonts.inter(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.buttonBg,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (salesList.length > 1) ...[
                          SizedBox(height: 10.h),
                          Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: data.data?.length ?? 0,
                              effect: ScrollingDotsEffect(
                                activeDotColor: Color(0xFF063466),
                                dotColor: Color(0xFFCDD6E0),
                                dotHeight: 6.h,
                                dotWidth: 6.w,
                                spacing: 5.w,
                                activeStrokeWidth: 2,
                                activeDotScale: 1.4,
                                maxVisibleDots: 5,
                              ),
                              onDotClicked: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF007AFF)),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Leads",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E1E1E),
                          letterSpacing: -0.54,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LeadScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E1E1E),
                            letterSpacing: -0.54,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF1E1E1E),
                            decorationThickness: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      leadTabItem("New", 0),
                      SizedBox(width: 10.w),
                      leadTabItem("Contacted", 1),
                      SizedBox(width: 10.w),
                      leadTabItem("Converted", 2),
                      SizedBox(width: 10.w),
                      leadTabItem("Lost", 3),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                leadState.when(
                  data: (data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: data.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10.w,
                            left: 24.w,
                            right: 24.w,
                          ),
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => LeadDetailScreen(
                                        id: data.data![index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 15.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          7.r,
                                        ),
                                        color: Color(0xFFE5F8ED),
                                      ),
                                      child: Text(
                                        "NEW LEAD",
                                        style: GoogleFonts.inter(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF00B94A),
                                          letterSpacing: -0.54,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      // "RK Enterprises Private Limited",
                                      data.data?[index].businessName ?? "N/A",
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
                                          // "Rajesh Kumar",
                                          data.data?[index].leadName ?? "N/A",
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF263238),
                                            height: 0,
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
                                          // "+91 XXXXXXX",
                                          data.data?[index].mobileNumber ??
                                              "N/A",
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF263238),
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        color: Color(0xFFE5F2FF),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "ADD NOTE",
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.buttonBg,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.buttonBg,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "MARK CONVETED",
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.buttonBg,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF007AFF),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.call_outlined,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(child: Text("Somwthing went wrong"));
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(color: AppColors.buttonBg),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            getFollowUpState.when(
              data: (data) {
                final followUpData = data.data;
                if (followUpData!.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Text(
                        "Today’s Follow-ups",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E1E1E),
                          letterSpacing: -0.54,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.h),
                      height: 200.h,
                      child: PageView.builder(
                        controller: _salePageController,
                        itemCount: followUpData?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 15.w),
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 20.h,
                              bottom: 20.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color.fromARGB(25, 0, 0, 0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  // "Call Suresh Electronics",
                                  "Call ${followUpData![index].businessName}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    color: Color(0xFF050A14),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.54,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  // "3:00 PM",
                                  followUpData[index].reminderTime ?? "N/A",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF007AFF),
                                    letterSpacing: -0.54,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 12.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE5F2FF),
                                    border: Border(
                                      left: BorderSide(
                                        color: AppColors.buttonBg,
                                        width: 2.w,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    // "Interested in yearly plan”",
                                    followUpData[index].reminderNote ?? "N/A",
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttonBg,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showRescheduleBottomSheet(
                                            context,
                                            followUpData[index].id.toString(),
                                          );
                                        },
                                        child: Container(
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            color: Color(0xFFE5F2FF),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "RESCHEDULE",
                                              style: GoogleFonts.inter(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.buttonBg,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isMarking = true;
                                          });
                                          try {
                                            final service = ref.read(
                                              authServiceProvider,
                                            );
                                            final res = await service
                                                .markDoneFollowUp(
                                                  id: followUpData[index].id
                                                      .toString(),
                                                );
                                            if (res) {
                                              ref.invalidate(
                                                getLeadFollowUpReminderProvider,
                                              );
                                            }
                                          } catch (e) {
                                            log(e.toString());
                                            setState(() {
                                              isMarking = false;
                                            });
                                          } finally {
                                            isMarking = false;
                                          }
                                        },
                                        child: Container(
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: isMarking
                                                ? Colors.grey.shade200
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            border: Border.all(
                                              color: isMarking
                                                  ? Colors.grey
                                                  : AppColors.buttonBg,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isMarking
                                                  ? "MARKING..."
                                                  : "MARK DONE",
                                              style: GoogleFonts.inter(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.buttonBg,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF007AFF),
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.call_outlined,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (followUpData.length > 1)
                      Center(
                        child: SmoothPageIndicator(
                          controller: _salePageController,
                          count: data.data?.length ?? 0,
                          effect: ScrollingDotsEffect(
                            activeDotColor: Color(0xFF063466),
                            dotColor: Color(0xFFCDD6E0),
                            dotHeight: 6.h,
                            dotWidth: 6.w,
                            spacing: 5.w,
                            activeStrokeWidth: 2,
                            activeDotScale: 1.4,
                            maxVisibleDots: 5,
                          ),
                          onDotClicked: (index) {
                            _salePageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
              error: (error, stackTrace) {
                log(error.toString());
                return Center(child: Text("Somwthing went wrong"));
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: AppColors.buttonBg),
              ),
            ),
            SizedBox(height: 30.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => AddSaleScreen()),
                );
              },
              child: Center(
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
                        "Add New Sale",
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
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget salesCard(final String title, final String amount) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFCCE0FB), width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF37474F),
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              amount,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF063466),
                letterSpacing: -0.54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadTabItem(String name, int index) {
    final isSelected = tabIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          tabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          color: isSelected ? Color(0xFF007AFF) : Color(0xFFE5F2FF),
        ),
        child: Center(
          child: Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Color(0xFF007AFF),
            ),
          ),
        ),
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
                                        ref.invalidate(
                                          getLeadFollowUpReminderProvider,
                                        );
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
