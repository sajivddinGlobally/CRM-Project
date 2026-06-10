import 'dart:io';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<Map<String, dynamic>> docs = [
    {"name": "Aadhar Card", "status": "verified", "file": File("dummy")},

    // {"name": "Aadhar Card", "status": "pending", "file": null},
    {"name": "PAN Card", "status": "pending", "file": null},

    {"name": "Employment Agreement", "status": "pending", "file": null},
  ];

  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        docs[index]["file"] = File(result.files.single.path!);
      });
    }
  }

  void openDoc(File file) {
    OpenFile.open(file.path);
  }

  int get uploadedCount => docs.where((e) => e["file"] != null).length;
  int get pendingCount => docs.where((e) => e["file"] == null).length;
  int get rejectedCount => docs.where((e) => e["status"] == "rejected").length;
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
          "Documents",
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
                leadStatusCard(title: 'UPLOADED', count: '04'),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'PENDING', count: '2'),
                SizedBox(width: 10.w),
                leadStatusCard(title: 'REJECTED', count: '1'),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              "REQUIRED DOCUMENTS LIST",
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF69818C),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: docs.length,
                itemBuilder: (_, index) {
                  final item = docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.transparent,
                      border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    item['status'] == "verified"
                                        ? Icons.verified
                                        : Icons.access_time_filled_rounded,
                                    color: item['status'] == "verified"
                                        ? Color(0xFF00B94A)
                                        : Color(0xFFB0C000),
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    item["status"],
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: item['status'] == "verified"
                                          ? Color(0xFF00B94A)
                                          : Color(0xFFB0C000),
                                      letterSpacing: -0.54,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                item["name"],
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF050A14),
                                  letterSpacing: -0.54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            if (item["file"] == null) {
                              pickFile(index);
                            } else {
                              openDoc(item["file"]);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 11.h,
                              horizontal: 20.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(0xFFE5F2FF),
                            ),
                            child: Text(
                              item["file"] == null ? "UPLOAD" : "VIEW",
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonBg,
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
          ],
        ),
      ),
    );
  }

  Widget _countBox(String title, String count) {
    return Container(
      height: 70,

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(title, style: const TextStyle(fontSize: 11)),

          const SizedBox(height: 5),

          Text(
            count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
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
