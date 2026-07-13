import 'dart:async';
import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/core/constant/appColors.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/screen/forgot/createPasswordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  final String email;
  const OtpVerifyScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  int secondRemaining = 30;
  Timer? timer;
  bool isLoading = false;
  String otp = "";

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() async {
    secondRemaining = 30;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondRemaining--;
        });
      }
    });
  }

  bool isResend = false;

  Future<void> resendOTP() async {
    setState(() {
      isResend = true;
    });

    try {
      final service = ref.read(authServiceProvider);
      final response = await service.forgotPasswordData(email: widget.email);
      if (response.status = true) {
        showSuccessSnackBar("Resend OTP Sucessfull");
        startTimer();
      }
    } catch (e) {
      setState(() => isResend = false);
    } finally {
      setState(() {
        isResend = false;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
                    "assets/SvgImage/verifyOtpImage.svg",
                    width: 295.w,
                    height: 263.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: Divider(color: Color(0xFF263238), thickness: 1.w),
                ),
              ],
            ),
            SizedBox(height: 80.h),
            Text(
              "Enter verification code",
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262833),
                letterSpacing: -0.54,
              ),
            ),
            Text(
              "Enter the 6-digit code sent to example@gmail.com",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5F6480),
                letterSpacing: -0.54,
              ),
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
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: OtpPinField(
                key: _otpPinFieldController,
                fieldWidth: 57.w,
                fieldHeight: 56.h,
                otpPinFieldDecoration:
                    OtpPinFieldDecoration.defaultPinBoxDecoration,
                otpPinFieldStyle: OtpPinFieldStyle(
                  activeFieldBorderColor: AppColors.buttonBg,
                  defaultFieldBorderColor: Color.fromARGB(25, 0, 0, 0),
                  fieldBorderWidth: 1.5.w,
                  fieldPadding: 0,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                maxLength: 6,
                onSubmit: (text) {
                  otp = text;
                },
                onChange: (text) {
                  otp = text;
                },
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
                setState(() {
                  isLoading = true;
                });

                try {
                  final service = ref.read(authServiceProvider);
                  final response = await service.OtpVerifyData(
                    email: widget.email,
                    otp: otp,
                  );
                  if (response.status = true) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            CreatePasswordScreen(email: widget.email),
                      ),
                    );
                  } else {
                    _otpPinFieldController.currentState?.clearOtp();
                    setState(() {
                      otp = "";
                      isLoading = false;
                    });
                  }
                } catch (e) {
                  _otpPinFieldController.currentState?.clearOtp();
                  setState(() {
                    otp = "";
                    isLoading = false;
                  });
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
                      "Verify Code",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonText,
                      ),
                    ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: secondRemaining == 0
                  ? () {
                      resendOTP();
                    }
                  : null,
              child: Container(
                width: 392.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonOpacity,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: isResend
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                            strokeWidth: 1.5,
                          ),
                        )
                      : Text(
                          secondRemaining == 0
                              ? "Resend Code"
                              : "Resend in $secondRemaining sec",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttonBg,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
