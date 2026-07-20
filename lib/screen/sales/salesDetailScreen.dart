import 'dart:developer' show log;

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetSaleDetilesProvider.dart';
import 'package:crm_app/data/Provider/GetSaleProvider.dart';
import 'package:crm_app/screen/sales/addSaleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SalesDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const SalesDetailScreen({super.key, required this.id});

  @override
  ConsumerState<SalesDetailScreen> createState() => _SalesDetailScreenState();
}

class _SalesDetailScreenState extends ConsumerState<SalesDetailScreen> {
  void _showActionMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(button.size.width, 90.h, 20.w, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Colors.white,
      items: [
        _menuItem(Icons.edit, "Edit Sale",(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSaleScreen(saleId: saleId,)));
        }),
        _menuItem(Icons.download, "Download Invoice",(){}),
        _menuItem(Icons.share, "Share Receipt", (){}),
        _menuItem(Icons.delete, "Delete Sale", ()async{
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
            final isScuess = await res.saleDeleteData(id: saleId!);
            if (isScuess) {
              ref.invalidate(getSaleProvider);
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

  PopupMenuItem _menuItem(IconData icon, String title,VoidCallback callback) {
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

  String? saleId;

  @override
  Widget build(BuildContext context) {
    final saleDetiles = ref.watch(getSaleDetilesProvider(widget.id));
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
          "Sale Details",
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
      body: saleDetiles.when(
        data: (data) {
          saleId = data.data!.id.toString();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 21.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: LinearGradient(
                        colors: [Color(0xFF007AFF), Color(0xFF004999)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "#SAL-1024",
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: -0.54,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "₹12,000",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFB3D5FA),
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  width: 4.w,
                                  height: 4.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3D5FA),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  data.data?.date != null
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(
                                            data.data!.date.toString(),
                                          ),
                                        )
                                      : "1 May 2026",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFB3D5FA),
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 76.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.r),
                            color: Color(0xFFB5C500),
                          ),
                          child: Center(
                            child: Text(
                              data.data?.paymentStatus ?? 
                              "PENDING",
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1C06),
                                letterSpacing: -0.54,
                              ),
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
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF69818C),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
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
                      border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                              data.data?.fullName ??
                              
                              "RAJESH TRADERS",
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
                        SizedBox(height: 15.h),
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
                            "Jaipur, Rajasthan",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonBg,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "PRODUCT DETAILS",
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
                          title: "Product Name",
                          value: data.data?.productName ?? "Premium Plan",
                        ),
                        _row(title: "Duration", value: "12 Months"),
                        _row(
                          title: "Quantity",
                          value: data.data?.quantity ?? "2",
                        ),
                        _row(title: "Unit Price", value: "₹6,000"),
                        _row(title: "Discount", value: "₹0"),
                        _row(
                          title: "Final Amount",
                          value: "₹12,000",
                          isLast: true,
                          highlight: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "PAYMENT DETAILS",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF69818C),
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TXN9384232437",
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
                                        "₹12,000",
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
                                        data.data?.paymentMethod ?? "UPI",
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
                                        data.data?.date != null
                                            ? DateFormat('dd MMM yyyy').format(
                                                DateTime.parse(
                                                  data.data!.date.toString(),
                                                ),
                                              )
                                            : "1 May 2026",
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
                                  data.data?.paymentStatus ?? "PAID",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "ADDED NOTE",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF69818C),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 20.h,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.transparent,
                      border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
                    ),
                    child: Text(
                      "Client requested onboarding support tomorrow.",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF263238),
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
                    "FOLLOW-UP DETAILS",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF69818C),
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check product activation",
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
                                        "03 May 2026 ",
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
                                        "4:00 PM",
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 8.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFF007AFF),
                              ),
                              child: Icon(
                                Icons.edit_square,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          log(error.toString());
          return PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: Center(
              child: Text(
                "Something went wrong",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: Color(0xFF007AFF))),
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
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
