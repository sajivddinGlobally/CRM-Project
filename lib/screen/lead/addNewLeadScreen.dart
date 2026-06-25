import 'dart:developer';

import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddnewLeadScreen extends ConsumerStatefulWidget {
  const AddnewLeadScreen({super.key});

  @override
  ConsumerState<AddnewLeadScreen> createState() => _AddnewLeadScreenState();
}

class _AddnewLeadScreenState extends ConsumerState<AddnewLeadScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final businessController = TextEditingController();
  final reminderController = TextEditingController();

  String? selectedIndustry;
  String? selectedCity;
  String? selectedProduct;
  String? selectedBudget;
  String? selectedSource;
  String? selectedPriority;

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

  final List<String> productList = [
    "CRM Software",
    "ERP Solution",
    "Website Development",
    "Mobile App Development",
  ];

  final List<String> budgetList = [
    "Below ₹10,000",
    "₹10,000 - ₹50,000",
    "₹50,000 - ₹1 Lakh",
    "Above ₹1 Lakh",
  ];

  final List<String> sourceList = [
    "Website",
    "Facebook",
    "Instagram",
    "Google Ads",
    "Referral",
  ];

  final List<String> priorityList = ["High", "Medium", "Low"];
  bool isReminder = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;
  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
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
          "Add New Lead",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: 0,
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
              formField(
                hintText: 'Enter lead name',
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              formField(
                hintText: 'Enter mobile number',
                keyboardType: TextInputType.number,
                controller: mobileController,
                maxLength: 10,
              ),
              formField(
                hintText: 'Enter alternate contact',
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: contactController,
              ),
              formField(
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
              formField(
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
                "REQUIREMENT DETAILS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              customDropdown(
                hint: "Select Budget Range",
                items: budgetList,
                value: selectedBudget,
                onChanged: (v) {
                  setState(() {
                    selectedBudget = v;
                  });
                },
              ),
              customDropdown(
                hint: "Select Lead Source",
                items: sourceList,
                value: selectedSource,
                onChanged: (v) {
                  setState(() {
                    selectedSource = v;
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "LEAD PRIORITY",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              customDropdown(
                hint: "Select Priority",
                items: priorityList,
                value: selectedPriority,
                onChanged: (v) {
                  setState(() {
                    selectedPriority = v;
                  });
                },
              ),
              SizedBox(height: 30.h),
              Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: isReminder,
                        onChanged: (value) {
                          setState(() {
                            isReminder = value!;
                          });
                        },
                        activeColor: const Color(0xFF007AFF),
                        side: BorderSide(color: Color(0xFF69818C)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "SET FOLLOW-UP REMINDER",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF69818C),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (isReminder)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
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
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7A7E93),
                                    ),
                                  ),
                                  Spacer(),
                                  VerticalDivider(
                                    color: Color.fromARGB(25, 0, 0, 0),
                                  ),
                                  Icon(
                                    Icons.date_range,
                                    size: 20.sp,
                                    color: const Color(0xFF7A7E93),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                setState(() {
                                  selectedTime = pickedTime;
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedTime == null
                                        ? "Select Time"
                                        : selectedTime!.format(context),
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7A7E93),
                                    ),
                                  ),
                                  Spacer(),
                                  VerticalDivider(
                                    color: Color.fromARGB(25, 0, 0, 0),
                                  ),
                                  Icon(
                                    Icons.access_time_outlined,
                                    size: 20.sp,
                                    color: const Color(0xFF7A7E93),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      maxLines: 4,
                      controller: reminderController,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF263238),
                        letterSpacing: -0.1,
                      ),
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
                          "Reminder Note",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7A7E93),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFE5F2FF),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          "SAVE REMINDER",
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF007AFF),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    setState(() {
                      isLoading = true;
                    });
                    
                  },
                  child: Text(
                    "Save Sale",
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

  Widget formField({
    required String hintText,
    required TextInputType keyboardType,
    int? maxLength,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
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
          isDense: true,
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
