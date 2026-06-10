import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/screen/clients/interactionHistoryScreen.dart';
import 'package:crm_app/screen/ticket/ticketDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientDetailScreen extends StatefulWidget {
  const ClientDetailScreen({super.key});

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  void _showActionMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(button.size.width, 90.h, 20.w, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Colors.white,
      items: [
        _menuItem(Icons.edit_outlined, "Edit Client", () {}),
        _menuItem(Icons.description_outlined, "View Documents", () {}),
        _menuItem(Icons.delete_outline, "Delete", () {}),
        _menuItem(Icons.history, "Interaction Hisotry", () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => InteractionHistoryScreen(),
            ),
          );
        }),
      ],
    );
  }

  PopupMenuItem _menuItem(IconData icon, String title, VoidCallback callback) {
    return PopupMenuItem(
      onTap: callback,
      value: title,
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

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 6.w),
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
          "Client Details",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -10.w,
        actionsPadding: EdgeInsets.only(right: 8.w),
        actions: [
          IconButton(
            onPressed: () {
              _showActionMenu(context);
            },
            icon: Icon(
              Icons.more_horiz,
              color: const Color(0xFF063466),
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                            borderRadius: BorderRadius.circular(6.r),
                            color: Color(0xFFD4E4F6),
                          ),
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
                              "ACTIVE",
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "#TK-1024 ",
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              color: Color(0xFF050A14),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.54,
                            ),
                          ),
                          TextSpan(
                            text: "Payment not reflecting",
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              color: Color(0xFF050A14),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "RAJESH SHARMA",
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
                          "28 Apr 2026",
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
              SizedBox(height: 30.h),
              Text(
                "BUSINESS DETAILS",
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
                    _row(title: "Phone Number", value: "+91 XXXXXXX45"),
                    _row(title: "Alternate Number", value: "+91 XXXXXXX98"),
                    _row(title: "Email", value: "rajesh@email.com"),
                    _row(title: "Industry", value: "Retail"),
                    _row(title: "GST Number", value: "27XXXXX1234X1Z5"),
                    _row(title: "Address", value: "Jaipur, Rajasthan"),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "ACTIVE PLAN DETAILS",
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
                    _row(title: "Plan Name", value: "Premium Plan"),
                    _row(title: "Plan Start", value: "12 Apr 2026"),
                    _row(title: "Plan End", value: "12 May 2027"),
                    _row(title: "Billing Cycle", value: "Yearly"),
                    _row(title: "Last Payment", value: "₹12,000"),
                    _row(title: "Renewal Status", value: "Upcoming"),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "SALES HISTORY",
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
                          _headerText("DETAILS"),
                          _headerText("AMOUNT"),
                        ],
                      ),
                    ),
                    _row(
                      title: "Plan Name",
                      value: "Premium Plan",
                      subtitle: "01 May 2026",
                    ),
                    _row(
                      title: "Plan Start",
                      value: "12 Apr 2026",
                      subtitle: "01 May 2026",
                    ),
                    _row(
                      title: "Plan End",
                      value: "12 May 2027",
                      subtitle: "01 May 2026",
                    ),
                    _row(
                      title: "Billing Cycle",
                      value: "Yearly",
                      subtitle: "01 May 2026",
                    ),
                    _row(
                      title: "Last Payment",
                      value: "₹12,000",
                      subtitle: "01 May 2026",
                    ),
                    _row(
                      title: "Renewal Status",
                      value: "Upcoming",
                      subtitle: "01 May 2026",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "SUPPORT TICKETS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  leadTabItem("OPEN TICKETS", 0),
                  SizedBox(width: 10.w),
                  leadTabItem("RESOLVED", 1),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 12.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                                    "#TKT-2291",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF263238),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Payment issue",
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      color: Color(0xFF050A14),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 7.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: Color(0xFFF7F9E5),
                              ),
                              child: Text(
                                "IN PROGRESS",
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFB0C000),
                                  letterSpacing: -0.54,
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
                                builder: (context) => TicketDetailScreen(),
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
                },
              ),
              SizedBox(height: 30.h),
              Text(
                "DOCUMENTS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 14.w,
                runSpacing: 12.h,
                children: [
                  _attachmentBox(
                    icon: Icons.description,
                    fileName: "AGREMENT.PDF",
                  ),
                  _attachmentBox(
                    icon: Icons.description,
                    fileName: "GST CERTIFICATE.PDF",
                  ),
                  _attachmentBox(
                    icon: Icons.description,
                    fileName: "INVOICE.PDF",
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
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
    String? subtitle,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F6273),
                      ),
                    ),
                ],
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

  Widget _attachmentBox({required IconData icon, required String fileName}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F2FF),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20.sp, color: const Color(0xFF007AFF)),
          SizedBox(width: 10.w),
          Text(
            fileName,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF007AFF),
              letterSpacing: -0.24,
            ),
          ),
        ],
      ),
    );
  }
}
