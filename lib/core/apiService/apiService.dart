import 'dart:developer';
import 'dart:io';
import 'package:crm_app/core/network/api.stateNetwork.dart';
import 'package:crm_app/data/Model/AddLeadBodyModel.dart';
import 'package:crm_app/data/Model/AddLeadResModel.dart';
import 'package:crm_app/data/Model/AddNewClientResModel.dart';
import 'package:crm_app/data/Model/AddSaleResModel.dart';
import 'package:crm_app/data/Model/ChangePasswordBodyModel.dart';
import 'package:crm_app/data/Model/ChangePasswordResModel.dart';
import 'package:crm_app/data/Model/CreatePasswordBodyModel.dart';
import 'package:crm_app/data/Model/CreatePasswordResModel.dart';
import 'package:crm_app/data/Model/CreateTicketResModel.dart';
import 'package:crm_app/data/Model/EditProfileResModel.dart';
import 'package:crm_app/data/Model/ForgotPasswordBodyModel.dart';
import 'package:crm_app/data/Model/ForgotPasswordResModel.dart';
import 'package:crm_app/data/Model/GetClientDetailsModel.dart';
import 'package:crm_app/data/Model/GetClientModel.dart';
import 'package:crm_app/data/Model/GetLeadModel.dart';
import 'package:crm_app/data/Model/GetProductIdModel.dart';
import 'package:crm_app/data/Model/GetProfileModel.dart';
import 'package:crm_app/data/Model/GetSaleDetilesModel.dart';
import 'package:crm_app/data/Model/GetSaleModel.dart';
import 'package:crm_app/data/Model/GetTicketDetailsModel.dart';
import 'package:crm_app/data/Model/GetTicketModel.dart';
import 'package:crm_app/data/Model/OtpVerifyBodyModel.dart';
import 'package:crm_app/data/Model/OtpVerifyResModel.dart';
import 'package:crm_app/data/Model/deleteNotificationModel.dart';
import 'package:crm_app/data/Model/getNotificationModel.dart';
import 'package:crm_app/data/Model/loginBodyModel.dart';
import 'package:crm_app/data/Model/loginResModel.dart';
import 'package:crm_app/data/Model/multipleDeleteNotificaionBodyModel.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/Model/AttendenceSummaryModel.dart';
import '../../data/Model/attendence_history_response.dart';
import '../../data/Model/check_body_model.dart';
import '../../data/Model/check_in_response_model.dart';
import '../../data/Model/check_out_respomse_model.dart';
import '../../data/Model/dashboard_response_model.dart';

class AuthService {
  final ApiStateNetwork api;

  AuthService(this.api);

  Future<LoginResModel> loginData({
    required String employeeId,
    required String password,
  }) async {
    try {
      final response = await api.login(
        LoginBodyModel(employeeId: employeeId, password: password),
      );

      if (response.status == true) {
        log(response.message ?? "Login Success");
        var box = Hive.box("userdata");
        await box.put("token", response.data!.token.toString());
        await box.put("employeeId", response.data!.employeeId);
        await box.put("fullName", response.data!.fullName);
        return response;
      } else {
        throw Exception(response.message ?? "Login Failed");
      }
    } catch (e, st) {
      log("LOGIN ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<ForgotPasswordResModel> forgotPasswordData({
    required String email,
  }) async {
    try {
      final response = await api.forgotPassword(
        ForgotPasswordBodyModel(email: email),
      );
      if (response.status == true) {
        log(response.message ?? "OTP Send Successfull");
        return response;
      } else {
        throw Exception(response.message ?? "OTP Not Send");
      }
    } catch (e, st) {
      log("OTP ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<OtpVerifyResModel> OtpVerifyData({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await api.otpVerify(
        OtpVerifyBodyModel(email: email, otp: otp),
      );
      if (response.status == true) {
        log(response.message ?? "OTP Verify Successfull");
        return response;
      } else {
        throw Exception(response.message ?? "OTP Verify Not Successfull");
      }
    } catch (e, st) {
      log("VERIFY ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<CreatePasswordResModel> CreatePasswordData({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await api.createPassword(
        CreatePasswordBodyModel(
          email: email,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      );
      if (response.status == true) {
        log(response.message ?? "New Password Gerate");
        return response;
      } else {
        throw Exception(response.message ?? "New Password Not Genrate");
      }
    } catch (e, st) {
      log("VERIFY ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<AddSaleResModel> AddSaleData({
    required String productName,
    required String quantity,
    required String paymentStatus,
    required String paymentMethod,
    required String note,
    required File image,
    DateTime? date,
    String? time,
    String? remeniderNote,
  }) async {
    try {
      final imageFile = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      final response = await api.addSale(
        productName,
        quantity,
        paymentStatus,
        paymentMethod,
        note,
        date?.toIso8601String(),
        time,
        remeniderNote,
        imageFile,
      );
      if (response.status == true) {
        return response;
      } else {
        throw Exception(response.message);
      }
    } catch (e, st) {
      log("VERIFY ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<CreateTicketResModel> createTicketData({
    required String issueTitle,
    required String issueDescription,
    required String issueCategory,
    required String priority,
    required File attachment,
    required String internalNote,
  }) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        attachment.path,
        filename: attachment.path.split('/').last,
      );

      final response = await api.createTicket(
        issueTitle,
        issueDescription,
        issueCategory,
        priority,
        multipartFile,
        internalNote,
      );

      if (response.status == true) {
        log(response.message ?? "Create Ticket Successful");
        return response;
      } else {
        throw Exception(response.message ?? "Ticket Not Created");
      }
    } catch (e, st) {
      log("CREATE TICKET ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<AddNewClientResModel> addNewClientData({
    required String clientName,
    required String primaryPhone,
    required String alternatePhone,
    required String email,
    required String businessName,
    required String industry,
    required String city,
    required String plan,
    DateTime? planStartDate,
    required String planDuration,
    required String assignedTo,
    File? document,
  }) async {
    try {
      MultipartFile? documentFile;

      if (document != null) {
        documentFile = await MultipartFile.fromFile(
          document.path,
          filename: document.path.split('/').last,
        );
      }

      final response = await api.addNewClient(
        clientName,
        primaryPhone,
        alternatePhone,
        email,
        businessName,
        industry,
        city,
        plan,
        planStartDate?.toIso8601String(),
        planDuration,
        assignedTo,
        documentFile,
      );

      if (response.status == true) {
        log(response.message ?? "Add New Client Successful");
        return response;
      } else {
        throw Exception(response.message ?? "Add New Client Not Successful");
      }
    } catch (e, st) {
      log("ADD CLIENT ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<ChangePasswordResModel> ChangePasswordData({
    required String newPassword,
    required String confirmPassword,
    required String oldPassword,
  }) async {
    try {
      final response = await api.changePassword(
        ChangePasswordBodyModel(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
          oldPassword: oldPassword
        ),
      );
      if (response.status == true) {
        log(response.message ?? "Change Password Successfull");
        return response;
      } else {
        throw Exception(response.message ?? "Chnage Password Not Successfull");
      }
    } catch (e, st) {
      log("VERIFY ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<EditProfileResModel> editProfileData({
    required String fullName,
    required String phone,
    String? email,
    DateTime? date,
    String? gender,
    String? sales,
    String? department,
    String? employeeId,
    String? contact,
    File? offerLetter,
  }) async {
    try {
      MultipartFile? imageFile;

      if (offerLetter != null) {
        imageFile = await MultipartFile.fromFile(
          offerLetter.path,
          filename: offerLetter.path.split('/').last,
        );
      }

      final response = await api.editProfile(
        fullName,
        phone,
        email,
        date?.toIso8601String(),
        gender,
        sales,
        department,
        employeeId,
        contact,
        imageFile,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetSaleDetilesModel> getSaleDetailsData({required String id}) async {
    try {
      final response = await api.getSaleDetiles(id);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetSaleModel> getSaleData() async {
    try {
      final response = await api.getSale();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetTicketModel> getTicketData() async {
    try {
      final response = await api.getTicket();
      return response;
    } catch (e, st) {
      log(st.toString());
      throw Exception(e.toString());
    }
  }

  Future<GetTicketDetailsModel> getTicketDetailsData({
    required String id,
  }) async {
    try {
      final response = await api.getTicketDetails(id);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetClientModel> getClientData() async {
    try {
      final response = await api.getClient();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetClienDetailsModel> getClientDetailsData({
    required String id,
  }) async {
    try {
      final response = await api.getClientDetails(id);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetProfileModel> getProfileData() async {
    try {
      final response = await api.getProfile();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductIdModel> getProductIdData() async {
    try {
      final response = await api.getProductId();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddLeadResModel> addLeadData({
    required String leadName,
    required String mobileNumber,
    String? alternateContact,
    String? email,
    String? businessName,
    String? industryType,
    String? city,
    String? budgetRange,
    String? leadSource,
    String? priority,
    String? reminderDate,
    String? reminderNote,
    String? reminderTime,
  }) async {
    try {
      final response = await api.addLead(
        AddLeadBodyModel(
          leadName: leadName,
          mobileNumber: mobileNumber,
          alternateContact: alternateContact,
          email: email,
          businessName: businessName,
          industryType: industryType,
          city: city,
          budgetRange: budgetRange,
          leadSource: leadSource,
          priority: priority,
          reminderDate: reminderDate,
          reminderNote: reminderNote,
          reminderTime: reminderTime,
        ),
      );
      if (response.status == true) {
        log(response.message ?? "Add Lead Successfull");
        return response;
      } else {
        throw Exception(response.message ?? "Add Lead Not Successfull");
      }
    } catch (e, st) {
      log("VERIFY ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<GetLeadModel> getLeadData() async {
    try {
      final response = await api.getLead();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DashboardResponseModel> getDashboardData() async {
    try {
      final response = await api.getDashboard();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AttendenceHistoryResponse> getAttendenceHistory() async {
    try {
      final response = await api.getAttendenceHistory();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AttendenceSummaryResponse> getAttendenceSummary() async {
    try {
      final response = await api.getAttendenceSummary();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CheckInResponseModel> checkIn({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await api.checkIn(
        CheckBodyModel(latitude: latitude, longitude: longitude),
      );
      if (response.status == true) {
        return response;
      } else {
        throw Exception(response.message ?? "");
      }
    } catch (e, st) {
      rethrow;
    }
  }

  Future<CheckOutResponseModel> checkOut({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await api.checkOut(
        CheckBodyModel(latitude: latitude, longitude: longitude),
      );
      if (response.status == true) {
        return response;
      } else {
        throw Exception(response.message ?? "");
      }
    } catch (e, st) {
      rethrow;
    }
  }

  Future<GetNotficationModel> getAllNotification() async {
    try {
      final res = await api.getNotification();

      if (res.status == true) {
        log(res.message ?? "Notifications fetched successfully");
        return res;
      } else {
        throw Exception(res.message ?? "Failed to fetch notifications");
      }
    } catch (e, st) {
      log("NOTIFICATION ERROR => $e");
      log("STACK TRACE => $st");
      rethrow;
    }
  }

  Future<bool> deleteNotification({required String id}) async {
    try {
      final res = await api.deleteNotification(id);
      if (res.status == true) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> markReadNotification({required String id}) async {
    try {
      final res = await api.markReadNorification(id);
      if (res.status == true) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> markAllReadNotification() async {
    try {
      final res = await api.markAllReadNotificaion();
      if (res.status == true) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> multipleDeleteNotificaion({required List<int> ids}) async {
    try {
      final body = MultipleDeleteNotificationBodyModel(ids: ids);
      final res = await api.multipleDeleteNotification(body);
      if (res.status == true) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
