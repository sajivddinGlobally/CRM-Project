import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffBg,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.scaffBg,
        foregroundColor: Color(0xFF263238),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/SvgImage/resetPasswordImage.svg",
                    width: 295.w,
                    height: 263.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 0,
                  right: 0,
                  child: Divider(color: Color(0xFF263238), thickness: 1.w),
                ),
              ],
            ),
            SizedBox(height: 80.h),
            Text(
              "Create a new password",
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262833),
                letterSpacing: -0.54,
              ),
            ),
            Text(
              "Your new password must be different from your\n previous password.",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5F6480),
                letterSpacing: -0.54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 29.h),
            Divider(
              color: AppColors.buttonBg,
              thickness: 4.h,
              indent: 100,
              endIndent: 100,
              radius: BorderRadius.circular(40.r),
            ),
            SizedBox(height: 30.h),
            _inputForm(hintText: "Enter new password"),
            SizedBox(height: 10.h),
            _inputForm(hintText: "Confirm new password"),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(392.w, 56.h),
                backgroundColor: AppColors.buttonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Reset Password",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buttonText,
                ),
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _inputForm({required String hintText}) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF263238),
          letterSpacing: -0.1,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25.w,
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
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Color.fromARGB(25, 0, 0, 0),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.buttonBg, width: 1.w),
          ),
        ),
      ),
    );
  }
}
