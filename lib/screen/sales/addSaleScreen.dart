import 'dart:developer';
import 'dart:io';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/data/Model/GetProductIdModel.dart';
import 'package:crm_app/data/Provider/GetSaleDetilesProvider.dart';
import 'package:crm_app/data/Provider/GetSaleProvider.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddSaleScreen extends ConsumerStatefulWidget {
  final String? saleId;
  const AddSaleScreen({super.key, this.saleId});

  @override
  ConsumerState<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends ConsumerState<AddSaleScreen> {
  final noteContoller = TextEditingController();
  final reminderNoteController = TextEditingController();
  int? selectedProductId;
  List<Datum> products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
    _loadTicketData();
  }

  Future<void> getProducts() async {
    try {
      final service = ref.read(authServiceProvider);

      final response = await service.getProductIdData();

      setState(() {
        products = List<Datum>.from(response.data ?? []);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  final List<String> qtyList = ["1", "2", "3", "4", "5"];

  final List<String> paymentStatusList = ["Pending", "Paid", "Cancelled"];

  final List<String> paymentMethodList = ["Cash", "UPI", "Card", "Net Banking"];

  String? selectedProduct;
  String? selectedQty;
  String? selectedPaymentStatus;
  String? selectedPaymentMethod;

  bool isLoading = false;

  bool isUpdate = false;

  bool isReminder = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  TextEditingController noteController = TextEditingController();
  File? selectedFile;
  String? selectedFileName;

  String? getPaymentStatus(String? value) {
    switch (value?.toLowerCase()) {
      case "pending":
        return "Pending";
      case "paid":
        return "Paid";
      case "cancelled":
        return "Cancelled";
      default:
        return null;
    }
  }

  String? getPaymentMethod(String? value) {
    switch (value?.toLowerCase()) {
      case "cash":
        return "Cash";
      case "upi":
        return "UPI";
      case "card":
        return "Card";
      case "net banking":
        return "Net Banking";
      default:
        return null;
    }
  }

  void _loadTicketData() async {
    final ticketData = await ref.read(
      getSaleDetilesProvider(widget.saleId!).future,
    );
    final item = ticketData.data;
    if (item == null) return;

    final matchedProduct = products.cast<Datum?>().firstWhere(
      (e) => e?.itemName == item.productName,
      orElse: () => null,
    );

    setState(() {
      selectedProductId = matchedProduct?.id;
      selectedProduct = matchedProduct?.itemName;

      selectedQty = item.quantity;
      selectedPaymentStatus = getPaymentStatus(item.paymentStatus);
      selectedPaymentMethod = getPaymentMethod(item.paymentMethod);
      noteContoller.text = item.note ?? "";
      selectedFileName = item.image ?? "";
      isReminder = item.isSetFollow == 1;

      // if (item.date != null && item.date!.isNotEmpty) {
      //   selectedDate = DateTime.parse(item.date!);
      // }

      if (item.time != null && item.time!.isNotEmpty) {
        final time = item.time!.split(":");
        selectedTime = TimeOfDay(
          hour: int.parse(time[0]),
          minute: int.parse(time[1]),
        );
      }

      reminderNoteController.text = item.remeniderNote ?? "";
    });
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
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

  String? formatDateForApi(DateTime? date) {
    if (date == null) return null;
    return DateFormat("yyyy-MM-dd").format(date);
  }

  String? formatTimeForApi(TimeOfDay? time) {
    if (time == null) return null;

    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
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
          "Add Sale",
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
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 21.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Color(0xFFECF0F5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RK Enterprises Private Limited",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF050A14),
                        letterSpacing: -0.54,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Rajesh Kumar",
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
                          "+91 XXXXXXX",
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
              ),
              SizedBox(height: 30.h),
              Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
              SizedBox(height: 30.h),
              sectionTitle("PRODUCT DETAILS"),
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color.fromARGB(25, 0, 0, 0),
                    width: 1.w,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Datum>(
                    borderRadius: BorderRadius.circular(20.r),
                    value:
                        products
                            .where((e) => e.id == selectedProductId)
                            .isNotEmpty
                        ? products.firstWhere((e) => e.id == selectedProductId)
                        : null,

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
                    items: products.map<DropdownMenuItem<Datum>>((product) {
                      return DropdownMenuItem<Datum>(
                        value: product,
                        child: Text(
                          product.itemName ?? "",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF063466),
                            letterSpacing: -0.54,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Datum? value) {
                      setState(() {
                        selectedProduct = value?.itemName;
                        selectedProductId = value?.id;
                      });

                      log("Product Name : ${value?.itemName}");
                      log("Product Id : ${value?.id}");
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              customDropdown<String>(
                value: selectedQty,
                hint: "Select Qty",
                items: qtyList,
                onChanged: (value) {
                  setState(() {
                    selectedQty = value;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Color(0xFFE5F2FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "ADD NEW",
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF007AFF),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
              SizedBox(height: 30.h),
              sectionTitle("PAYMENT DETAILS"),
              SizedBox(height: 12.h),
              customDropdown<String>(
                value: selectedPaymentStatus,
                hint: "Select Payment Status",
                items: paymentStatusList,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentStatus = value;
                  });
                },
              ),
              SizedBox(height: 10.h),
              customDropdown<String>(
                value: selectedPaymentMethod,
                hint: "Select Payment Method",
                items: paymentMethodList,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
              SizedBox(height: 30.h),
              sectionTitle("ADD SALES NOTE"),
              SizedBox(height: 12.h),
              TextField(
                controller: noteContoller,
                keyboardType: TextInputType.streetAddress,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF263238),
                  letterSpacing: -0.1,
                ),
                maxLines: 4,
                decoration: InputDecoration(
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
              sectionTitle("UPLOAD DOCUMENT"),
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
              Divider(color: Color(0xFFE5E5E5), thickness: 1.w),
              SizedBox(height: 30.h),
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
                      controller: reminderNoteController,
                      keyboardType: TextInputType.streetAddress,
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
                    if (widget.saleId == null) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final service = ref.read(authServiceProvider);
                        final response = await service.addSaleData(
                          productName: selectedProductId.toString(),
                          quantity: selectedQty ?? "",
                          paymentStatus: selectedPaymentStatus ?? "",
                          paymentMethod: selectedPaymentMethod ?? "",
                          note: noteContoller.text.trim(),
                          image: selectedFile!,
                          date: formatDateForApi(selectedDate),
                          time: formatTimeForApi(selectedTime),
                          remeniderNote: reminderNoteController.text.trim(),
                          isSetFollow: isReminder ? 1 : 0,
                        );
                        if (response.status == true) {
                          log("Add Sale SuccessFull");
                          ref.invalidate(getSaleProvider);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBottomNav(),
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
                        final response = await service.updateSaleData(
                          saleId: widget.saleId ?? "",
                          productId: selectedProductId.toString(),
                          quantity: selectedQty ?? "",
                          paymentStatus: selectedPaymentStatus ?? "",
                          paymentMethod: selectedPaymentMethod ?? "",
                          note: noteContoller.text.trim(),
                          image: selectedFile!,
                        );
                        if (response.status == true) {
                          ref.invalidate(getSaleProvider);
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
                          widget.saleId == null ? "Save Sale" : "Update Sale",
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
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
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
