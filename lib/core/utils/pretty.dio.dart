import 'dart:developer';
import 'package:crm_app/core/utils/key.dart';
import 'package:crm_app/core/utils/showMessage.dart';
import 'package:crm_app/screen/loginScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

bool isNavigating = false;

Dio callDio() {
  final dio = Dio();
  dio.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        var box = Hive.box("userdata");
        var token = box.get("token");

        log("Hive Form Token :- $token");

        options.headers.addAll({ 
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
        // Token ho to add karo
        if (token != null && token.toString().isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        // Token na ho to bhi request jane do
        handler.next(options);
      },
      onResponse: (response, handler) async {
        try {
          if (response.data is Map<String, dynamic>) {
            final data = response.data;

            if (data["status"] == false) {
              final message =
                  data["message"]?.toString() ?? "Something went wrong";

              log("API STATUS FALSE => $message");

              showErrorSnackBar(message);
            }
          }
        } catch (e) {
          log("Response Error: $e");
        }

        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        log("ERROR:- ${error.response?.data}");
        // Session Expired
        if (error.response?.statusCode == 401 && !isNavigating) {
          isNavigating = true;

          var box = Hive.box("userdata");

          if (navigatorKey.currentContext != null) {
            showErrorSnackBar("Session Expired, Please Login Again");
          }

          await box.clear();

          navigatorKey.currentState?.pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );

          isNavigating = false;
        }
        // Validation Error
        else if (error.response?.data != null) {
          final data = error.response!.data;

          String message = "Something went wrong";

          if (data is Map<String, dynamic>) {
            if (data["message"] != null &&
                data["message"].toString().isNotEmpty) {
              message = data["message"].toString();
            }

            if (data["errors"] is Map<String, dynamic>) {
              final errors = data["errors"] as Map<String, dynamic>;

              List<String> allErrors = [];

              errors.forEach((key, value) {
                if (value is List) {
                  allErrors.addAll(value.map((e) => e.toString()));
                }
              });

              if (allErrors.isNotEmpty) {
                message = allErrors.join("\n");
              }
            }
          }
          log("SNACKBAR MESSAGE => $message");
          showErrorSnackBar(message);
        }
        return handler.next(error);
      },
    ),
  );
  return dio;
}









// import 'dart:developer';
// import 'package:crm_app/core/utils/key.dart';
// import 'package:crm_app/screen/loginScreen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// bool isNavigating = false;

// Dio callDio() {
//   final dio = Dio();
//   dio.interceptors.add(
//     PrettyDioLogger(
//       requestBody: true,
//       responseBody: true,
//       requestHeader: true,
//       responseHeader: true,
//     ),
//   );

//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         var box = Hive.box("userdata");
//         var token = box.get("token");

//         log("Hive Form Token :- $token");

//         options.headers.addAll({
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         });

//         if (token != null && token.toString().isNotEmpty) {
//           options.headers["Authorization"] = "Bearer $token";
//           return handler.next(options);
//         }

//         // Login API ko allow karo
//         if (options.path.contains("/login")) {
//           return handler.next(options);
//         }

//         // Token nahi hai to Login page par bhejo
//         if (!isNavigating) {
//           isNavigating = true;

//           await box.clear();

//           Future.microtask(() {
//             navigatorKey.currentState?.pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const LoginScreen()),
//               (route) => false,
//             );

//             isNavigating = false;
//           });
//         }

//         return handler.reject(
//           DioException(
//             requestOptions: options,
//             error: "Token not found",
//             type: DioExceptionType.cancel,
//           ),
//         );
//       },
//       onResponse: (response, handler) async {
//         try {
//           if (response.data is Map<String, dynamic>) {
//             final data = response.data;

//             if (data["status"] == false) {
//               final message =
//                   data["message"]?.toString() ?? "Something went wrong";

//               log("API STATUS FALSE => $message");

//               showErrorSnackBar(message);
//             }
//           }
//         } catch (e) {
//           log("Response Error: $e");
//         }

//         return handler.next(response);
//       },
//       onError: (DioException error, handler) async {
//         log("ERROR: ${error.response?.data}");

//         // Session Expired
//         if (error.response?.statusCode == 401 && !isNavigating) {
//           isNavigating = true;

//           var box = Hive.box("userdata");

//           if (navigatorKey.currentContext != null) {
//             showErrorSnackBar("Session Expired, Please Login Again");
//           }

//           await box.clear();

//           navigatorKey.currentState?.pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const LoginScreen()),
//             (route) => false,
//           );

//           await Future.delayed(const Duration(seconds: 1));
//           isNavigating = false;
//         }
//         // Validation Error
//         else if (error.response?.data != null) {
//           final data = error.response!.data;

//           String message = "Something went wrong";

//           if (data is Map<String, dynamic>) {
//             if (data["message"] != null &&
//                 data["message"].toString().isNotEmpty) {
//               message = data["message"].toString();
//             }

//             if (data["errors"] is Map<String, dynamic>) {
//               final errors = data["errors"] as Map<String, dynamic>;

//               List<String> allErrors = [];

//               errors.forEach((key, value) {
//                 if (value is List) {
//                   allErrors.addAll(value.map((e) => e.toString()));
//                 }
//               });

//               if (allErrors.isNotEmpty) {
//                 message = allErrors.join("\n");
//               }
//             }
//           }

//           log("SNACKBAR MESSAGE => $message");
//           showErrorSnackBar(message);
//         }
//         return handler.next(error);
//       },
//     ),
//   );
//   return dio;
// }

// void showErrorSnackBar(String message) {
//   final context = navigatorKey.currentContext;
//   if (context == null) return;

//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(
//       SnackBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 4),
//         margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
//         content: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFF4F4),
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(color: const Color(0xFFFFD6D6)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8.w),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFFFE5E5),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.error_outline_rounded,
//                   color: Color(0xFFE53935),
//                   size: 20.sp,
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Text(
//                   message,
//                   style: GoogleFonts.inter(
//                     color: const Color(0xFF1F2937),
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                     height: 1.4,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
// }