import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetLeadProvider.dart';
import 'package:crm_app/screen/lead/addNewLeadScreen.dart';
import 'package:crm_app/screen/lead/leadDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadScreen extends ConsumerStatefulWidget {
  const LeadScreen({super.key});

  @override
  ConsumerState<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends ConsumerState<LeadScreen> {
  final serchController = TextEditingController();
  List<dynamic> allLeads = [];
  List<dynamic> filteredLeads = [];
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    final leadDate = ref.watch(leadProvider);
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
          "Leads",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leadStatusCard(
                  title: 'NEW LEADS',
                  count: (leadDate.value?.data?.length ?? 0).toString(),
                ),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'TODAY’ FOLLOW-UP', count: '6'),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'CONVERTED', count: '14'),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              "LEADS LISTING",
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF69818C),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: serchController,
                    onChanged: (value) {
                      setState(() {
                        if (value.trim().isEmpty) {
                          filteredLeads = List.from(allLeads);
                        } else {
                          filteredLeads = allLeads.where((lead) {      

                            
                            return (lead.businessName ?? "")
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                (lead.leadName ?? "").toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                (lead.mobileNumber ?? "").contains(value);
                          }).toList();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 55.h,
                        minWidth: 45.w,
                      ),
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF677074),
                        size: 20.sp,
                      ),
                      hint: Text(
                        "SEARCH CLIENT...",
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
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
            leadDate.when(
              data: (data) {
                if (!isLoaded) {
                  allLeads = List.from(data.data ?? []);
                  filteredLeads = List.from(data.data ?? []);
                  isLoaded = true;
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100.h),
                    itemCount: filteredLeads.length,
                    itemBuilder: (context, index) {
                      final lead = filteredLeads[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.w),
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
                                      id: lead.id.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 20.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              // "Rajesh Enterprises",
                                              lead.businessName ?? "",
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
                                                  lead?.leadName ??
                                                      "Rajesh Traders",
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
                                                  lead?.mobileNumber ??
                                                      "+91 XXXXXXX45",
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
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 15.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              7.r,
                                            ),
                                            color: Color(0xFFFFE6E6),
                                          ),
                                          child: Text(
                                            // "NEW LEAD",
                                            lead.status ?? "N/A",
                                            style: GoogleFonts.inter(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFF0000),
                                              letterSpacing: -0.54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.h,
                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 11.h,
                                      horizontal: 14.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(0xFFECF0F5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INTERESTED IN",
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF37474F),
                                            letterSpacing: -0.54,
                                          ),
                                        ),
                                        Text(
                                          "PREMIUM PLAN",
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF063466),
                                            letterSpacing: -0.54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F8FF),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        color: Color(0xFFDaECFF),
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
                            ),
                          ],
                        ),
                      );
                    },
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddnewLeadScreen()),
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
                "Add New Lead",
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

  Widget leadStatusCard({required String title, required String count}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color(0xFFECF0F5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF37474F),
                letterSpacing: -0.54,
              ),
            ),
            Text(
              count,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF063466),
                letterSpacing: -0.54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
