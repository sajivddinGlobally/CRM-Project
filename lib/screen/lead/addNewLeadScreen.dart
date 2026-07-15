import 'dart:developer';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/data/Provider/GetLeadFollowUpReminderProvider.dart';
import 'package:crm_app/data/Provider/GetLeadProvider.dart';
import 'package:crm_app/data/Provider/GetProductIdProvider.dart';
import 'package:crm_app/data/Provider/leadDetailsProvider.dart';
import 'package:crm_app/data/Provider/leadFilterProvider.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddnewLeadScreen extends ConsumerStatefulWidget {
  final String? leadId;
  const AddnewLeadScreen({super.key, this.leadId});

  @override
  ConsumerState<AddnewLeadScreen> createState() => _AddnewLeadScreenState();
}

class _AddnewLeadScreenState extends ConsumerState<AddnewLeadScreen> {
  final _addLeadFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final businessController = TextEditingController();
  final reminderController = TextEditingController();

  String? selectedIndustry;
  String? selectedCity;
  int? selectedProductId;
  String? selectedBudget;
  String? selectedSource;
  String? selectedPriority;

  final List<String> industryList = [
    "Technology",
    "IT Services",
    "Real Estate",
    "Healthcare",
    "Education",
    "Finance",
    "Manufacturing",
    "Retail",
  ];

  final List<String> cityList = [
    "Jaipur",
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
    "100,000 - 150,000",
    "Below ₹10,000",
    "₹10,000 - ₹50,000",
    "₹50,000 - ₹1 Lakh",
    "Above ₹1 Lakh",
  ];

  final List<String> sourceList = [
    "Direct Traffic",
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
  bool isUpdate = false;

  String? formatDateForApi(DateTime? date) {
    if (date == null) return null;
    return DateFormat("yyyy-MM-dd").format(date);
  }

  String? formatTimeForApi(TimeOfDay? time) {
    if (time == null) return null;

    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null && widget.leadId!.isNotEmpty) {
      _loadLead();
    }
  }

  String? oldReminderDate;
  String? oldReminderTime;

  Future<void> _loadLead() async {
    try {
      final value = await ref.read(leadDetailsProvider(widget.leadId!).future);

      final item = value.data;

      if (item == null) return;

      setState(() {
        nameController.text = item.leadName ?? "";
        mobileController.text = item.mobileNumber ?? "";
        contactController.text = item.alternateContact ?? "";
        emailController.text = item.email ?? "";
        businessController.text = item.businessName ?? "";
        selectedIndustry = item.industryType;
        selectedCity = item.city;
        selectedBudget = item.budgetRange;
        selectedSource = item.leadSource;
        selectedPriority = item.priority;

        selectedProductId = item.interestedProductId ?? 0;

        /// Reminder
        isReminder = item.issetFollow == 1;

        if (item.reminderDate != null && item.reminderDate!.isNotEmpty) {
          selectedDate = DateTime.parse(item.reminderDate!);
        }

        if (item.reminderTime != null && item.reminderTime!.isNotEmpty) {
          final time = item.reminderTime!.split(":");

          selectedTime = TimeOfDay(
            hour: int.parse(time[0]),
            minute: int.parse(time[1]),
          );
        }
        oldReminderDate = item.reminderDate;
        oldReminderTime = item.reminderTime;

        reminderController.text = item.reminderNote ?? "";
      });
    } catch (e) {
      log("Lead Details Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    log("lead Id ${widget.leadId}");
    final productState = ref.watch(productIdProvider);
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
      body: Form(
        key: _addLeadFormKey,
        child: SingleChildScrollView(
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                formField(
                  hintText: 'Enter mobile number',
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter mobile number";
                    }

                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
                      return "Please enter a valid mobile number";
                    }

                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email";
                    }
                    if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value.trim())) {
                      return "Please enter a valid email";
                    }

                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter business/company name";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return "Please select industry type";
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null) {
                      return "Please select city";
                    }
                    return null;
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
                productState.when(
                  data: (data) {
                    final item = data.data;
                    return DropdownButtonFormField(
                      value: item!.any((e) => e.id == selectedProductId)
                          ? selectedProductId
                          : null,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 16.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(25, 0, 0, 0),
                            width: 1.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(
                            color: AppColors.buttonBg,
                            width: 1.w,
                          ),
                        ),
                      ),
                      hint: Text(
                        "Select Product",
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
                      items: item?.map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.itemName ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF063466),
                              letterSpacing: -0.54,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProductId = value;
                        });
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(child: Text("Something went wrong"));
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(color: AppColors.buttonBg),
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
                  validator: (value) {
                    if (value == null) {
                      return "Please select budget range";
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null) {
                      return "Please select lead source";
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null) {
                      return "Please select priority";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
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
                            _addLeadFormKey.currentState?.validate();
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
                                        color: selectedDate == null
                                            ? Color(0xFF7A7E93)
                                            : Color(0xFF263238),
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
                                        color: selectedTime == null
                                            ? Color(0xFF7A7E93)
                                            : Color(0xFF263238),
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
                      TextFormField(
                        maxLines: 4,
                        controller: reminderController,
                        validator: (value) {
                          if (isReminder &&
                              (value == null || value.trim().isEmpty)) {
                            return "Please enter reminder note";
                          }
                          return null;
                        },
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF263238),
                          letterSpacing: -0.1,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.w,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.w,
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
                      if (widget.leadId == null) {
                        if (!_addLeadFormKey.currentState!.validate()) {
                          return;
                        }

                        if (isReminder) {
                          if (selectedDate == null) {
                            showErrorSnackBar("Please select reminder date");
                            return;
                          }

                          if (selectedTime == null) {
                            showErrorSnackBar("Please select reminder time");
                            return;
                          }
                        }
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final service = ref.read(authServiceProvider);
                          final response = await service.addLeadData(
                            leadName: nameController.text.trim(),
                            mobileNumber: mobileController.text.trim(),
                            email: emailController.text.trim(),
                            alternateContact: contactController.text.trim(),
                            businessName: businessController.text.trim(),
                            industryType: selectedIndustry ?? "",
                            city: selectedCity ?? "",
                            budgetRange: selectedBudget ?? "",
                            leadSource: selectedSource ?? "",
                            priority: selectedPriority ?? "",
                            reminderNote: reminderController.text.trim(),
                            isetFollow: isReminder ? 1 : 0,
                            reminderDate: formatDateForApi(selectedDate),
                            reminderTime: formatTimeForApi(selectedTime),
                            interestedProductId: selectedProductId,
                          );
                          if (response.status == true) {
                            ref.invalidate(leadProvider);
                            ref.invalidate(getLeadFollowUpReminderProvider);
                            ref.invalidate(leadFilterProvider("new"));
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyBottomNav(),
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } else {
                        if (!_addLeadFormKey.currentState!.validate()) {
                          return;
                        }

                        if (isReminder) {
                          if (selectedDate == null && oldReminderDate == null) {
                            showErrorSnackBar("Please select reminder date");
                            return;
                          }

                          if (selectedTime == null && oldReminderTime == null) {
                            showErrorSnackBar("Please select reminder time");
                            return;
                          }
                        }
                        setState(() {
                          isUpdate = true;
                        });
                        try {
                          final service = ref.read(authServiceProvider);
                          final res = await service.updateLead(
                            leadId: widget.leadId,
                            leadName: nameController.text.trim(),
                            mobileNumber: mobileController.text.trim(),
                            email: emailController.text.trim(),
                            alternateContact: contactController.text.trim(),
                            businessName: businessController.text.trim(),
                            industryType: selectedIndustry ?? "",
                            city: selectedCity ?? "",
                            budgetRange: selectedBudget ?? "",
                            leadSource: selectedSource ?? "",
                            priority: selectedPriority ?? "",
                            issetFollow: isReminder ? 1 : 0,
                            reminderDate: isReminder
                                ? (selectedDate != null
                                      ? formatDateForApi(selectedDate)
                                      : oldReminderDate)
                                : null,

                            reminderTime: isReminder
                                ? (selectedTime != null
                                      ? formatTimeForApi(selectedTime)
                                      : oldReminderTime)
                                : null,

                            reminderNote: isReminder
                                ? reminderController.text.trim()
                                : null,
                            interestedProductId: selectedProductId,
                          );
                          if (res.status == true) {
                            setState(() {
                              isUpdate = false;
                            });
                            ref.invalidate(leadProvider);
                            ref.invalidate(leadDetailsProvider(widget.leadId!));
                            ref.invalidate(getLeadFollowUpReminderProvider);
                            Navigator.pop(context, true);
                          }
                        } catch (e) {
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
                            widget.leadId == null ? "Save Lead" : "Update Lead",
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
      ),
    );
  }

  Widget formField({
    required String hintText,
    required TextInputType keyboardType,
    int? maxLength,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
        validator: validator,
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF263238),
          letterSpacing: -0.1,
        ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
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
    String? Function(T?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: DropdownButtonFormField<T>(
        value: value,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 16.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: const Color.fromARGB(25, 0, 0, 0),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColors.buttonBg, width: 1.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
        ),
        borderRadius: BorderRadius.circular(20.r),
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
    );
  }
}
