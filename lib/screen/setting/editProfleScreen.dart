import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/data/Provider/GetProfileProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfleScreen extends ConsumerStatefulWidget {
  const EditProfleScreen({super.key});

  @override
  ConsumerState<EditProfleScreen> createState() => _EditProfleScreenState();
}

class _EditProfleScreenState extends ConsumerState<EditProfleScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final saleController = TextEditingController();
  final departmentController = TextEditingController();
  final empController = TextEditingController();
  final contactController = TextEditingController();
  final dateController = TextEditingController();

  bool isLoading = false;
  DateTime? selectedDate;
  File? profileImage;
  String? image = "";
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  void showImage() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
              child: Text("Gallery"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
              child: Text("Camera"),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        );
      },
    );
  }

  String? selectGender;
  final List<String> genderList = ["Male", "Female", "Other"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfileData();
  }

  void loadProfileData() {
    ref.read(getProfileProvider).whenData((profileData) {
      final data = profileData.data;

      nameController.text = data?.fullName ?? "";
      phoneController.text = data?.phone ?? "";
      emailController.text = data?.email ?? "";
      saleController.text = data?.sale ?? "";
      departmentController.text = data?.department ?? "";
      empController.text = data?.employeeId ?? "";
      contactController.text = data?.emergencyPhone ?? "";
      image = data?.offerLetter ?? "";

      // Gender
      selectGender = data?.gender;

      // Date
      if (data?.dob != null) {
        selectedDate = data!.dob!;

        dateController.text =
            "${selectedDate!.day.toString().padLeft(2, '0')}/"
            "${selectedDate!.month.toString().padLeft(2, '0')}/"
            "${selectedDate!.year}";
      }

      setState(() {});
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
          "Edit Profile",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF063466),
          ),
        ),
        titleSpacing: -10.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                "PROFILE PHOTO",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 88.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.grey,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: profileImage != null
                          ? Image.file(
                              profileImage!,
                              fit: BoxFit.cover,
                              width: 88.w,
                              height: 90.h,
                            )
                          : (image != null && image!.isNotEmpty)
                          ? Image.network(
                              image!,
                              fit: BoxFit.cover,
                              width: 88.w,
                              height: 90.h,
                              // errorBuilder: (context, error, stackTrace) {
                              //   return const Center(
                              //     child: Icon(Icons.person_2_outlined),
                              //   );
                              // },
                            ) // : Image.network(
                          //     profileImage!.path,
                          //     fit: BoxFit.cover,
                          //     width: 88.w,
                          //     height: 90.h,
                          //     errorBuilder: (context, error, stackTrace) {
                          //       return Container(
                          //         width: 88.w,
                          //         height: 90.h,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(20.r),
                          //           color: Colors.grey,
                          //         ),
                          //         child: Center(
                          //           child: Icon(
                          //             Icons.person_2_outlined,
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          : Container(
                              width: 88.w,
                              height: 90.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showImage();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 11.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFFE5F2FF),
                      ),
                      child: Text(
                        "UPDATE PROFIEL IMAGE",
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonBg,
                          letterSpacing: -0.54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                "PERSONAL DETAILS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              _inputForm(
                hintText: "Enter Name",
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "+91-95555-89666",
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phoneController,
                enableEdit: false,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "Enter Email",
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                enableEdit: false,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "DD/MM/YYYY",
                controller: dateController,
                onTap: pickDate,
                readOnly: true,
              ),
              SizedBox(height: 10.h),
              customDropdown(
                hint: "Select Gender",
                items: genderList,
                value: selectGender,
                onChanged: (v) {
                  setState(() {
                    selectGender = v;
                  });
                },
              ),
              SizedBox(height: 30.h),
              Text(
                "PROFESSIONAL DETAILS",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              _inputForm(
                hintText: "Sales Executive",
                keyboardType: TextInputType.text,
                controller: saleController,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "Department",
                keyboardType: TextInputType.text,
                controller: departmentController,
              ),
              SizedBox(height: 10.h),
              _inputForm(
                hintText: "EMP-1024",
                keyboardType: TextInputType.text,
                controller: empController,
                enableEdit: false,
              ),
              SizedBox(height: 30.h),
              Text(
                "EMERGENCY CONTACT",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF69818C),
                ),
              ),
              SizedBox(height: 12.h),
              _inputForm(
                hintText: "+91-95555-89666",
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: contactController,
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

                    try {
                      final service = ref.read(authServiceProvider);
                      final response = await service.editProfileData(
                        fullName: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                        date: selectedDate,
                        gender: selectGender,
                        sales: saleController.text.trim(),
                        department: departmentController.text.trim(),
                        employeeId: empController.text.trim(),
                        contact: contactController.text.trim(),
                        offerLetter: profileImage,
                      );
                      if (response.status == true) {
                        log("Update Profile Successfull");
                        ref.invalidate(getProfileProvider);
                        Navigator.pop(context);
                      }
                    } on DioException catch (e) {
                      setState(() => isLoading = false);
                      showErrorSnackBar(
                        e.response?.data.toString() ?? "Network Error",
                      );
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
                          "Save Changes",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: -0.54,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputForm({
    required String hintText,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    bool enableEdit = true,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return AbsorbPointer(
      absorbing: !enableEdit,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF263238),
          letterSpacing: -0.1,
        ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 18.h,
          ),
          hint: Text(
            hintText,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7A7E93),
            ),
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
              fontWeight: FontWeight.w400,
              color: Color(0xFF7A7E93),
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF263238),
                  letterSpacing: -0.1,
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
