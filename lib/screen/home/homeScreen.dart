import 'dart:developer';

import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetTicketProvider.dart';
import 'package:crm_app/data/Provider/getNotificationProvider.dart';
import 'package:crm_app/screen/activity/activityScreen.dart';
import 'package:crm_app/screen/clients/addClientScreen.dart';
import 'package:crm_app/screen/home/notificationScreen.dart';
import 'package:crm_app/screen/sales/addSaleScreen.dart';
import 'package:crm_app/screen/sales/salesTargetScreen.dart';
import 'package:crm_app/screen/setting/settingScreen.dart';
import 'package:crm_app/screen/ticket/createTicketScreen.dart';
import 'package:crm_app/screen/ticket/ticketDetailScreen.dart';
import 'package:crm_app/screen/ticket/ticketScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/Provider/get_dashboard_provider.dart';

class MyBottomNav extends ConsumerStatefulWidget {
  const MyBottomNav({super.key});

  @override
  ConsumerState<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends ConsumerState<MyBottomNav> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> navItems = [
    {"image": "assets/SvgImage/home.svg", "title": "HOME"},
    {"image": "assets/SvgImage/sales.svg", "title": "SALES"},
    {"image": "assets/SvgImage/tickets.svg", "title": "TICKETS"},
    {"image": "assets/SvgImage/activity.svg", "title": "ACTIVITY"},
    {"image": "assets/SvgImage/settings.svg", "title": "SETTINGS"},
  ];
  final List<Widget> pages = [
    HomeScreen(),
    SalesTargetScreen(),
    TicketScreen(),
    ActivityScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) return;
        setState(() {
          selectedIndex = 0;
        });
      },
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: Container(
          height: 75.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -6),
                blurRadius: 14.r,
                spreadRadius: 0,
                color: Color.fromARGB(38, 6, 52, 102),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              navItems.length,
              (index) => Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: _navItem(
                    image: navItems[index]["image"],
                    title: navItems[index]["title"],
                    isSelected: selectedIndex == index,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required String image,
    required String title,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(51, 0, 122, 255),
                  Color.fromARGB(0, 0, 122, 255),
                ],
              )
            : null,
      ),
      child: Column(
        children: [
          Container(
            height: 4.h,
            color: isSelected ? Color(0xFF007AFF) : Colors.transparent,
          ),
          const Spacer(),
          SvgPicture.asset(
            image,
            color: isSelected ? Colors.blue : Colors.blueGrey,
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.blue : Colors.blueGrey,
              letterSpacing: -0.4,
            ),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double targetValue = 12000 / 18000;

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

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double _progress = 0.0;

  void startAnimation(double value) {
    _controller.reset();

    _animation = Tween<double>(
      begin: 0,
      end: value,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final getTicket = ref.watch(getTicketProvider);
    final notificationState = ref.watch(getNotificationProvider);
    final unreadCount = notificationState.maybeWhen(
      data: (data) =>
          data.data?.where((item) => item.isRead == false).length ?? 0,
      orElse: () => 0,
    );
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(0xFF0C80FF)),
      body: dashboardAsync.when(
        data: (dashboardData) {
          final name = dashboardData.data?.employee?.fullName ?? "User";
          final companyName = dashboardData.data?.employee?.companyName ?? "";
          final employeeId = dashboardData.data?.employee?.employeeId ?? "";
          final openTicket = dashboardData.data?.tickets?.open ?? "";

          final sales = dashboardData.data?.sales;
          final achievedValue = (sales?.totalSalesValue ?? 0).toInt();
          final achieved = (sales?.totalSalesValue ?? 0).toDouble();
          final targetVale = (sales?.target ?? 0).toInt();
          final target = (sales?.target ?? 0).toDouble();

          final progress = target <= 0
              ? 0.0
              : (achieved / target).clamp(0.0, 1.0);

          final actualPercent = target <= 0 ? 0.0 : (achieved / target) * 100;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_progress != progress) {
              setState(() {
                _progress = progress;
              });
              startAnimation(progress);
            }
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF007AFF), Color(0xFF002199)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning, ${name}",
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    employeeId,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(178, 255, 255, 255),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),

                                  SizedBox(width: 6.w),
                                  Container(
                                    width: 4.w,
                                    height: 4.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    companyName,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(178, 255, 255, 255),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ),
                              ).then((value) {
                                ref.invalidate(getNotificationProvider);
                              });
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 44.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Color(0xFF007AFF),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.notifications_none_rounded,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                                if (unreadCount > 0)
                                  Positioned(
                                    right: -2,
                                    top: -5,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        unreadCount > 99
                                            ? "99+"
                                            : unreadCount.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 20.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Color(0xFF007AFF),
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
                                            value: progress,
                                            strokeWidth: 6,
                                            backgroundColor: const Color(
                                              0xFF4493F3,
                                            ),
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(Colors.white),
                                          ),
                                        ),
                                        Text(
                                          // "${actualPercent.toStringAsFixed(0)}%",
                                          "${actualPercent.toStringAsFixed(2)}%",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 14.sp,
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
                                      "TODAY’S TARGET",
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
                                      "₹${achievedValue} / ₹${targetVale}",
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
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 191.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              top: 15.h,
                              bottom: 15.h,
                              right: 15.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Color(0xFF194DBD)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    // color: Color(0xFF007AFF),
                                    color: Color(0xFF1A6ADD),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/SvgImage/ticket.svg",
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Open Tickets",
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
                                    Text(
                                      openTicket.toString(),
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
                          ),
                          Container(
                            width: 191.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              top: 15.h,
                              bottom: 15.h,
                              right: 15.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Color(0xFF194DBD)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Color(0xFF1A6ADD),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/SvgImage/ticket.svg",
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PENDING Tasks",
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
                                    Text(
                                      "04",
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 13.h, top: 13.h),
                  decoration: BoxDecoration(color: Color(0xFFE5F2FF)),
                  child: Center(
                    child: Text(
                      "NOT CHECKED IN YET, PLEASE CHECK IN",
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF007AFF),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeMenuCard(
                        image: "assets/SvgImage/wallet.svg",
                        name: "Add Sale",
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddSaleScreen(),
                            ),
                          );
                        },
                      ),
                      homeMenuCard(
                        image: "assets/SvgImage/note.svg",
                        name: "Create Ticket",
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateTicketScreen(),
                            ),
                          );
                        },
                      ),
                      homeMenuCard(
                        image: "assets/SvgImage/user.svg",
                        name: "Add Client",
                        callback: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddClientScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Text(
                        "Your Priority Tasks",
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
                      height: 140.h,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 15.w),
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 20.h,
                              bottom: 10.h,
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
                                  "Follow up with Rajesh Traders about the product",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    color: Color(0xFF050A14),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.54,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Urgent",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFF0000),
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
                                      "Due today, 4:00 PM",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 30.h,
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
                                            "Call",
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
                                        width: double.infinity,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          color: AppColors.buttonBg,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Mark Done",
                                            style: GoogleFonts.inter(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
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
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 10,
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
                ),
                getTicket.when(
                  data: (data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data.data!.isNotEmpty) ...[
                          SizedBox(height: 34.h),
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text(
                              "Recently Assigned Tickets",
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E1E1E),
                                letterSpacing: -0.54,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                        ],
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.data?.length,
                          itemBuilder: (context, index) {
                            final item = data.data?[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 24.w,
                                right: 24.w,
                                bottom: 10.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tiketCard(
                                    category: item?.issueCategory ?? "",
                                    ticketid: item?.ticketId ?? "",
                                    status: item?.status ?? "",
                                    id: item?.id ?? 0,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    log(stackTrace.toString());
                    log(error.toString());
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
                  loading: () => Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF007AFF),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: Text(
                    "Sales Overview",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E1E1E),
                      letterSpacing: -0.54,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 12.h),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF007AFF), Color(0xFF002199)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Target This Month",
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -0.54,
                        ),
                      ),
                      SizedBox(height: 19.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TARGET",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(204, 255, 255, 255),
                            ),
                          ),
                          Text(
                            "ACHIEVED",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(204, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹1,00,000",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: -0.54,
                            ),
                          ),
                          Text(
                            "₹1,24,000",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: -0.54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Divider(
                        color: Colors.white,
                        thickness: 8.h,
                        radius: BorderRadius.circular(40.r),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "YOU HAVE EXCEEDED YOUR TARGET BY ₹24,000. GREAT WORK!",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(204, 255, 255, 255),
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: AppColors.buttonBg)),
        error: (e, _) => Center(child: Text("Something went wrong")),
      ),
      floatingActionButton: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 6.w),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(60, 0, 122, 255),
              blurRadius: 20.r,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {},
          child: Container(
            width: 62.w,
            height: 62.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF007AFF), Color(0xFF002199)],
              ),
            ),
            child: Center(
              child: SvgPicture.asset("assets/SvgImage/floating.svg"),
            ),
          ),
        ),
      ),
    );
  }

  Widget homeMenuCard({
    required String image,
    required String name,
    required VoidCallback callback,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: callback,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 25.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Color(0xFFECF0F5),
            ),
            child: Center(
              child: SvgPicture.asset(image, width: 28.w, height: 28.h),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF063466),
              letterSpacing: -0.54,
            ),
          ),
        ],
      ),
    );
  }

  Widget tiketCard({
    required String status,
    required String ticketid,
    required String category,
    required int id,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.transparent,
        border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: Color(0xFF050A14),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.54,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Urgent",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFF0000),
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
                          ticketid,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF263238),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 14.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xFFE5F8ED),
                ),
                child: Center(
                  child: Text(
                    status,
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
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => TicketDetailScreen(id: id.toString()),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 35.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.buttonBg),
              ),
              child: Center(
                child: Text(
                  "View details",
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
  }
}
