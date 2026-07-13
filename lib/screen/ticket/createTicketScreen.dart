import 'dart:developer';
import 'dart:io';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Provider/GetTicketDetailsProvider.dart';
import 'package:crm_app/data/Provider/GetTicketProvider.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTicketScreen extends ConsumerStatefulWidget {
  final String? ticketId;
  const CreateTicketScreen({super.key, this.ticketId});

  @override
  ConsumerState<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends ConsumerState<CreateTicketScreen> {
  bool isLoading = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final notesController = TextEditingController();
  String? selectCategory, selectPrity;
  final List<String> categoryList = [
    "Technical Issue",
    "Payment Issue",
    "Order Issue",
    "Product Issue",
    "Delivery Issue",
    "Account Issue",
    "Login / Signup Issue",
    "Refund Request",
    "App Bug Report",
    "Feature Request",
    "Other",
  ];
  final List<String> priorityList = ["Low", "Medium", "High", "Urgent"];
  File? selectedFile;
  String? selectedFileName;

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          selectedFile = File(file.path!);
          selectedFileName = file.name;
        });

        debugPrint("File Name: ${file.name}");
        debugPrint("File Path: ${file.path}");
      }
    } catch (e) {
      debugPrint("File Pick Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTicketData();
  }

  bool isUpdate = false;

  void _loadTicketData() async {
    final ticketData = await ref.read(
      getTicketDetailsProvider(widget.ticketId!).future,
    );
    final item = ticketData.data;
    if (item == null) return;

    setState(() {
      titleController.text = item.issueTitle ?? "";
      descriptionController.text = item.issueDescription ?? "";
      selectCategory = item.issueCategory ?? "";
      selectPrity = item.priority ?? "";
      selectedFileName = item.attachment ?? "";
      notesController.text = item.internalNote ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffBg,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
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
          "Create Ticket",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
            letterSpacing: -0.54,
          ),
        ),
        titleSpacing: -6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              sectionTitle("ISSUE DETAILS"),
              SizedBox(height: 12.h),
              TextField(
                controller: titleController,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF263238),
                  letterSpacing: -0.1,
                ),
                decoration: InputDecoration(
                  hint: Text(
                    "Title of the issue",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7A7E93),
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
              SizedBox(height: 10.h),
              TextField(
                controller: descriptionController,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF263238),
                  letterSpacing: -0.1,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  hint: Text(
                    "Describe the issue in detail…",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7A7E93),
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
              SizedBox(height: 10.h),
              customDropdown<String>(
                value: selectCategory,
                hint: "Select Category",
                items: categoryList,
                onChanged: (value) {
                  setState(() {
                    selectCategory = value;
                  });
                },
              ),
              SizedBox(height: 10.h),
              customDropdown<String>(
                value: selectPrity,
                hint: "Select Priority",
                items: priorityList,
                onChanged: (value) {
                  setState(() {
                    selectPrity = value;
                  });
                },
              ),
              SizedBox(height: 30.h),
              sectionTitle("ATTACHMENTS"),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: pickDocument,
                child: Container(
                  width: double.infinity,
                  height: 110.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(15.r),
                      dashPattern: [8, 4],
                      strokeWidth: 1.5,
                      color: const Color(0xFF007AFF),
                      padding: EdgeInsets.zero,
                    ),
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 110.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              size: 28.sp,
                              color: const Color(0xFF007AFF),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              selectedFileName ?? "Upload",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7A7E93),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              sectionTitle("INTERNAL NOTES"),
              SizedBox(height: 12.h),
              TextField(
                controller: notesController,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF263238),
                  letterSpacing: -0.1,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 12.h,
                    bottom: 12.h,
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
                  hint: Text(
                    "Add internal note…",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7A7E93),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(392.w, 56.h),
                  backgroundColor: AppColors.buttonBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                onPressed: () async {
                  if (widget.ticketId == null) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final service = ref.read(authServiceProvider);
                      final response = await service.createTicketData(
                        issueTitle: titleController.text.trim(),
                        issueDescription: descriptionController.text.trim(),
                        issueCategory: selectCategory ?? "",
                        priority: selectPrity ?? "",
                        attachment: selectedFile!,
                        internalNote: notesController.text.trim(),
                      );
                      if (response.status == true) {
                        ref.invalidate(getTicketProvider);
                        log("Create Ticket Successfull");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBottomNav(),
                          ),
                        );
                      }
                    } catch (e) {
                      setState(() => isLoading = false);
                    }
                  } else {
                    setState(() {
                      isUpdate = true;
                    });
                    try {
                      final service = ref.read(authServiceProvider);
                      final response = await service.updateTicketData(
                        ticketId: widget.ticketId ?? "",
                        issueTitle: titleController.text.trim(),
                        issueDescription: descriptionController.text.trim(),
                        issueCategory: selectCategory ?? "",
                        priority: selectPrity ?? "",
                        attachment: selectedFile,
                        internalNote: notesController.text.trim(),
                      );
                      if (response.status == true) {
                        ref.invalidate(getTicketProvider);
                        log("Create Ticket Successfull");
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      setState(() => isUpdate = false);
                    } finally {
                      setState(() {
                        isUpdate = false;
                      });
                    }
                  }
                },
                child: isLoading || isUpdate
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.ticketId == null
                            ? "Create Ticket"
                            : "Update Ticket",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonText,
                        ),
                      ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF69818C),
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
      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
}
