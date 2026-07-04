import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetTicketDetailsProvider.dart';
import 'package:crm_app/screen/clients/clientScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const TicketDetailScreen({super.key, required this.id});

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  final descriptionController = TextEditingController();
  bool isDescriptionSet = false;
  void _showActionMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(button.size.width, 90.h, 20.w, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Colors.white,
      items: [
        _menuItem(Icons.edit_outlined, "Edit Ticket"),
        _menuItem(Icons.person_add_alt_outlined, "Reassign Ticket"),
        _menuItem(Icons.priority_high_outlined, "Escalate"),
        _menuItem(Icons.cancel_outlined, "Close Ticket"),
      ],
    );
  }

  PopupMenuItem _menuItem(IconData icon, String title) {
    return PopupMenuItem(
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

  String? selectStatus;
  final List<String> statusList = ["Open", "In Progress", "Closed"];
  @override
  Widget build(BuildContext context) {
    final ticketDetails = ref.watch(getTicketDetailsProvider(widget.id));
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
          "Ticket Details",
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
      body: ticketDetails.when(
        data: (data) {
          descriptionController.text = data.data?.issueDescription ?? "";
          selectStatus ??= data.data?.status;
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
                                "URGENT",
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
                                vertical: 10.h,
                                horizontal: 15.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: Color(0xFFE1EBE1),
                              ),
                              child: Text(
                                data.data?.status ?? "IN PROGRESS",
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
                        SizedBox(height: 12.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: data.data?.ticketId ?? "#TK-1024 ",
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  color: Color(0xFF050A14),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.54,
                                ),
                              ),
                              TextSpan(
                                text:
                                    data.data?.issueCategory ??
                                    "Payment not reflecting",
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
                              "01 May 2026",
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
                              "10:30 AM",
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
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: LinearGradient(
                        colors: [Color(0xFF007AFF), Color(0xFF004999)],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "DUE BY",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.54,
                              ),
                            ),
                            Text(
                              "02 May 2026",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: SizedBox(
                            height: 6.h,
                            child: LinearProgressIndicator(
                              value: 0.90,
                              backgroundColor: const Color(0xFF1A5FAA),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFFFFFFF),
                              ),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "DUE IN 4 HRS",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: Color(0xFFB3CAE3),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "CLIENT DETAILS",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Color(0xFF69818C),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.54,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Rajesh Enterprises",
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
                              data.data?.raisedBy ?? "Rajesh Traders",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF263238),
                                height: 0,
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
                              "+91 XXXXXXX45",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF263238),
                                height: 0,
                                letterSpacing: -0.54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: Color(0xFF007AFF),
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "CALL",
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ClientScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF007AFF),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "VIEW CLIENTS",
                                      style: GoogleFonts.inter(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "ISSUE DESCRIPTION",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Color(0xFF69818C),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.54,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hint: Text(
                        "Client made payment but it’s not reflecting in dashboard.",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF263238),
                          letterSpacing: -0.54,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: Color.fromARGB(25, 0, 0, 0),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: AppColors.buttonBg,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "ATTACHMENTS",
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
                        icon: Icons.edit_document,
                        fileName: "INVOICE.PDF",
                      ),
                      _attachmentBox(
                        icon: Icons.image,
                        fileName: "PAYMENT SCREENSHOT.JPG",
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "STATUS CONTROL",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Color(0xFF69818C),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.54,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  customDropdown<String>(
                    value: selectStatus,
                    hint: "Update Status",
                    items: statusList,
                    onChanged: (value) {
                      setState(() {
                        selectStatus = value;
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
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
    );
  }

  Widget customDropdown<T>({
    required String hint,
    required List<T> items,
    required T? value,
    required void Function(T?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Color.fromARGB(25, 0, 0, 0), width: 1.w),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          borderRadius: BorderRadius.circular(20.r),
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF063466),
              letterSpacing: -0.54,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF063466),
            size: 22.sp,
          ),
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF063466),
                  letterSpacing: -0.54,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
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
