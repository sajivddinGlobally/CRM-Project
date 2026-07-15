import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetClientProvider.dart';
import 'package:crm_app/screen/clients/addClientScreen.dart';
import 'package:crm_app/screen/clients/clientDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ClientScreen extends ConsumerStatefulWidget {
  const ClientScreen({super.key});

  @override
  ConsumerState<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends ConsumerState<ClientScreen> {

  final searchController = TextEditingController();
  
  List<dynamic> allClient = [];
  List<dynamic> filteredClient = [];
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(getClientProvider);
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
          "Client",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -10.w,
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
                  title: 'TOTAL CLIENTS',
                  count: (client.value?.data?.length ?? 0).toString(),
                ),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'ACTIVE CLIENTS', count: '74'),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'RENEWAL DUE', count: '12'),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              "CLIENTS LISTING",
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
            client.when(
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100.h),
                    itemCount: data.data?.length,
                    itemBuilder: (context, index) {
                      final client = data.data?[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              client?.clientName ??
                                                  "Rajesh Enterprises",
                                              style: GoogleFonts.inter(
                                                fontSize: 15.sp,
                                                color: Color(0xFF050A14),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.54,
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Container(
                                              width: 4.w,
                                              height: 4.w,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00B94A),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              "ACTIVE",
                                              style: GoogleFonts.inter(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF00B94A),
                                                letterSpacing: -0.54,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.more_horiz,
                                              color: const Color(0xFF063466),
                                              size: 25.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              InkWell(
                                borderRadius: BorderRadius.circular(10.r),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ClientDetailScreen(
                                        clientId: client!.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            client?.industry ??
                                                "GreenTech Innovations",
                                            style: GoogleFonts.inter(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF050A14),
                                              letterSpacing: -0.54,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            client?.planStartDate != null
                                                ? DateFormat(
                                                    'dd MMM yyyy',
                                                  ).format(
                                                    DateTime.parse(
                                                      client!.planStartDate
                                                          .toString(),
                                                    ),
                                                  )
                                                : "",
                                            style: GoogleFonts.inter(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF263238),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 10.w,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                          color: Color(0xFFD4E4F6),
                                        ),
                                        child: Text(
                                          "PREMIUM",
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF007AFF),
                                            letterSpacing: -0.54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
            CupertinoPageRoute(builder: (context) => AddClientScreen()),
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
                "Add New Clients",
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
