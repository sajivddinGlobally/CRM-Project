import 'dart:developer';
import 'dart:io';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/data/Provider/GetClientProvider.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddClientScreen extends ConsumerStatefulWidget {
  const AddClientScreen({super.key});

  @override
  ConsumerState<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends ConsumerState<AddClientScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final businessController = TextEditingController();
  bool isLoading = false;
  String? selectedIndustry;
  String? selectedCity;
  DateTime? selectedDate;
  final List<String> industryList = [
    "IT Services",
    "Real Estate",
    "Healthcare",
    "Education",
    "Finance",
    "Manufacturing",
    "Retail",
  ];

  final List<String> cityList = [
    "Surat",
    "Ahmedabad",
    "Mumbai",
    "Delhi",
    "Bangalore",
  ];
  String? selectedPlan;
  String? selectedDuration;
  String? selectedEmployee;

  final List<String> planList = [
    "Basic Plan",
    "Standard Plan",
    "Premium Plan",
    "Enterprise Plan",
  ];

  final List<String> durationList = [
    "1 Month",
    "3 Months",
    "6 Months",
    "12 Months",
  ];

  final List<String> employeeList = [
    "John Smith",
    "Rahul Sharma",
    "Aman Patel",
    "Priya Verma",
    "Neha Singh",
  ];
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
          "Add New Client",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                "BASIC INFORMATION",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              addClientForm(
                hintText: 'Enter client name',
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              addClientForm(
                hintText: 'Enter mobile number',
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: mobileController,
              ),
              addClientForm(
                hintText: 'Enter alternate contact',
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: contactController,
              ),
              addClientForm(
                hintText: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(height: 30.h),
              Text(
                "BUSINESS INFORMATION",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              addClientForm(
                hintText: 'Enter business/company name',
                keyboardType: TextInputType.name,
                controller: businessController,
              ),
              customDropdown(
                hint: "Select Industry Type",
                items: industryList,
                value: selectedIndustry,
                onChanged: (v) {
                  setState(() {
                    selectedIndustry = v;
                  });
                },
              ),
              customDropdown(
                hint: "Select City",
                items: cityList,
                value: selectedCity,
                onChanged: (v) {
                  setState(() {
                    selectedCity = v;
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "PRODUCT / PLAN INFO",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              customDropdown(
                hint: "Select Plan",
                items: planList,
                value: selectedPlan,
                onChanged: (v) {
                  setState(() {
                    selectedPlan = v;
                  });
                },
              ),
              SizedBox(height: 10.h),

              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.only(
                    left: 18.w,
                    right: 15.w,
                    bottom: 12.h,
                    top: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: Color.fromARGB(25, 0, 0, 0),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        selectedDate == null
                            ? "Select Date"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF063466),
                          letterSpacing: -0.1,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.date_range,
                        size: 20.sp,
                        color: const Color(0xFF063466),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              customDropdown(
                hint: "Select Plan Duration",
                items: durationList,
                value: selectedDuration,
                onChanged: (v) {
                  setState(() {
                    selectedDuration = v;
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "ACCOUNT MANAGER INFO",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              customDropdown(
                hint: "Assigned Employee",
                items: employeeList,
                value: selectedEmployee,
                onChanged: (v) {
                  setState(() {
                    selectedEmployee = v;
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "DOCUMENTS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
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
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    if (selectedFile == null) {
                      showErrorSnackBar("Please Select Document");
                    }
                    setState(() {
                      isLoading = false;
                    });
                    try {
                      final service = ref.read(authServiceProvider);
                      final response = await service.addNewClientData(
                        clientName: nameController.text.trim(),
                        primaryPhone: mobileController.text.trim(),
                        alternatePhone: contactController.text.trim(),
                        email: emailController.text.trim(),
                        businessName: businessController.text.trim(),
                        industry: selectedIndustry ?? "",
                        city: selectedCity ?? "",
                        plan: selectedPlan ?? "",
                        planStartDate: selectedDate,
                        planDuration: selectedDuration ?? "",
                        assignedTo: selectedEmployee ?? "",
                        document: selectedFile!,
                      );
                      if (response.status = true) {
                        ref.invalidate(getClientProvider);
                        log("Add New Client Successfull");
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
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Create Client",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: -0.54,
                          ),
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

  Widget addClientForm({
    required String hintText,
    required TextInputType keyboardType,
    int? maxLength,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF263238),
          letterSpacing: -0.1,
        ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 18.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Color.fromARGB(25, 0, 0, 0),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColors.buttonBg, width: 1.w),
          ),
          hint: Text(
            hintText,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7A7E93),
              letterSpacing: -0.54,
            ),
          ),
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
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
