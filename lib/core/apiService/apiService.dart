import 'dart:developer' show log;
import 'dart:io';
import 'package:crm_app/core/network/api.stateNetwork.dart';
import 'package:crm_app/data/Model/AddLeadBodyModel.dart';
import 'package:crm_app/data/Model/AddLeadResModel.dart';
// import 'package:crm_app/data/Model/AddNewClientBodyModel.dart';
import 'package:crm_app/data/Model/AddNewClientResModel.dart';
// import 'package:crm_app/data/Model/AddSaleBodyModel.dart';
import 'package:crm_app/data/Model/AddSaleResModel.dart';
import 'package:crm_app/data/Model/ChangePasswordBodyModel.dart';
import 'package:crm_app/data/Model/ChangePasswordResModel.dart';
import 'package:crm_app/data/Model/CreatePasswordBodyModel.dart';
import 'package:crm_app/data/Model/CreatePasswordResModel.dart';
// import 'package:crm_app/data/Model/CreateTicketBodyModel.dart';
import 'package:crm_app/data/Model/CreateTicketResModel.dart';
// import 'package:crm_app/data/Model/EditProfileBodyModel.dart';
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
import 'package:crm_app/data/Model/loginBodyModel.dart';
import 'package:crm_app/data/Model/loginResModel.dart';
import 'package:dio/dio.dart';
// import 'package:crm_app/screen/loginScreen.dart';
// import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:retrofit/retrofit.dart';

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
  }) async {
    try {
      final response = await api.changePassword(
        ChangePasswordBodyModel(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
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
    String? sale,
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
        sale,
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

  Future<GetSaleDetilesModel> getSaleDetailsData() async {
    try {
      final response = await api.getSaleDetiles();
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
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetTicketDetailsModel> getTicketDetailsData() async {
    try {
      final response = await api.getTicketDetails();
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

  Future<GetClienDetailsModel> getClientDetailsData() async {
    try {
      final response = await api.getClientDetails();
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
  required  String leadName,
  required String mobileNumber,
  String? alternateContact,
  String? email,
  String? businessName,
  String? industryType,
  String? city,
  String? budgetRange,
  String? leadSource,
  String? priority,
  DateTime? reminderDate,
  String? reminderNote,
  String? reminderTime,
  }) async{
    try{
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
          reminderTime: reminderTime
        )
      );
       if (response.status == true) {
        log(response.message ?? "Add Lead Successfull");
        return response;
      } else {
        throw Exception(response.message ?? "Add Lead Not Successfull");
      }
    }catch (e, st) {
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
}
