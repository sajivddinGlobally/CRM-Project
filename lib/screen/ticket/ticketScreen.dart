import 'dart:developer';

import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetTicketProvider.dart';
import 'package:crm_app/screen/ticket/createTicketScreen.dart';
import 'package:crm_app/screen/ticket/ticketDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketScreen extends ConsumerStatefulWidget {
  const TicketScreen({super.key});

  @override
  ConsumerState<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  final searchController = TextEditingController();

  List<dynamic> allTicket = [];
  List<dynamic> filteredTicket = [];

  @override
  Widget build(BuildContext context) {
    final getTicket = ref.watch(getTicketProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 24.w,
        title: Text(
          "Tickets",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
            letterSpacing: -0.54,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        if (value.trim().isEmpty) {
                          filteredTicket = List.from(allTicket);
                        } else {
                          filteredTicket = allTicket.where((ticket) {
                            return (ticket.issueCategory ?? "")
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                (ticket.ticketId ?? "").toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                (ticket.raisedBy ?? "").toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                (ticket.status ?? "").toLowerCase().contains(
                                  value.toLowerCase(),
                                );
                          }).toList();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 50.h,
                        minWidth: 45.w,
                      ),
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF677074),
                        size: 20.sp,
                      ),
                      hint: Text(
                        "Search...",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF677074),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 0,
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
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Color(0xFFE5F2FF),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: Color(0xFF007AFF),
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            getTicket.when(
              data: (data) {
                if (allTicket.isEmpty) {
                  allTicket = List.from(data.data ?? []);
                  filteredTicket = List.from(allTicket);
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100.h),
                  itemCount: filteredTicket.length,
                    itemBuilder: (context, index) {
                     final item = filteredTicket[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.w),
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
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 15.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.r),
                                    color: Color(0xFFFFE5E5),
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
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 15.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.r),
                                    color: Color(0xFFF7F9E5),
                                  ),
                                  child: Text(
                                    item?.status ?? "IN PROGRESS",
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
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              item?.issueCategory ?? "Payment not reflecting",
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
                                  item?.ticketId ?? "#TK-1024",
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
                                  item?.raisedBy ?? "Rajesh Traders",
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              TicketDetailScreen(
                                                id: item!.id.toString(),
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        border: Border.all(
                                          color: Color(0xFF007AFF),
                                          width: 1.w,
                                        ),
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
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Container(
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF007AFF),
                                      borderRadius: BorderRadius.circular(10.r),
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
              loading: () => SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF007AFF)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => CreateTicketScreen()),
          );
        },
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
                "Add New Ticket",
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
