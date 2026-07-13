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
import 'package:crm_app/data/Model/GetFollowUpReminderModel.dart';
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
import 'package:crm_app/data/Model/leadDetailsModel.dart';
import 'package:crm_app/data/Model/leadUpdateBodyModel.dart';
import 'package:crm_app/data/Model/leadUpdateResModel.dart';
import 'package:crm_app/data/Model/loginBodyModel.dart';
import 'package:crm_app/data/Model/loginResModel.dart';
import 'package:crm_app/data/Model/markDoneFollowUpModel.dart';
import 'package:crm_app/data/Model/markReadResModel.dart';
import 'package:crm_app/data/Model/multipleDeleteNotificaionBodyModel.dart';
import 'package:crm_app/data/Model/rescheduleFollowUpBodyModel.dart';
import 'package:crm_app/data/Model/rescheduleFollowUpResModel.dart';
import 'package:crm_app/data/Model/unreadCountModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/Model/AttendenceSummaryModel.dart';
import '../../data/Model/attendence_history_response.dart';
import '../../data/Model/check_body_model.dart';
import '../../data/Model/check_in_response_model.dart';
import '../../data/Model/check_out_respomse_model.dart';
import '../../data/Model/dashboard_response_model.dart';

part 'api.stateNetwork.g.dart';

@RestApi(baseUrl: "https://zylviontech.gwsstaging.com")
abstract class ApiStateNetwork {
  factory ApiStateNetwork(Dio dio, {String baseUrl}) = _ApiStateNetwork;

  @POST("/api/auth/login")
  Future<LoginResModel> login(@Body() LoginBodyModel body);

  @POST("/api/auth/forgot-password")
  Future<ForgotPasswordResModel> forgotPassword(
    @Body() ForgotPasswordBodyModel body,
  );

  @POST("/api/auth/verify-otp")
  Future<OtpVerifyResModel> otpVerify(@Body() OtpVerifyBodyModel body);

  @POST("/api/auth/reset-password")
  Future<CreatePasswordResModel> createPassword(
    @Body() CreatePasswordBodyModel body,
  );
  @MultiPart()
  @POST("/api/auth/add-sales")
  Future<AddSaleResModel> addSale(
    @Part(name: "product_id") String productId,
    @Part(name: "quantity") String quantity,
    @Part(name: "payment_status") String paymentStatus,
    @Part(name: "payment_method") String paymentMethod,
    @Part(name: "note") String note,
    @Part(name: "date") String? date,
    @Part(name: "time") String? time,
    @Part(name: "remenider_note") String? remeniderNote,
    @Part(name: "image") MultipartFile? image,
    @Part(name: "is_setFollow") int? isSetFollow,
  );

  @MultiPart()
  @POST("/api/auth/add-ticket")
  Future<CreateTicketResModel> createTicket(
    @Part(name: "issue_title") String issueTitle,
    @Part(name: "issue_description") String issueDescription,
    @Part(name: "issue_category") String issueCategory,
    @Part(name: "priority") String priority,
    @Part(name: "attachment") MultipartFile attachment,
    @Part(name: "internal_note") String internalNote,
  );

  @MultiPart()
  @POST("/api/auth/add-client")
  Future<AddNewClientResModel> addNewClient(
    @Part(name: "client_name") String clientName,
    @Part(name: "primary_phone") String primaryPhone,
    @Part(name: "alternate_phone") String alternatePhone,
    @Part(name: "email") String email,
    @Part(name: "business_name") String businessName,
    @Part(name: "industry") String industry,
    @Part(name: "city") String city,
    @Part(name: "plan") String plan,
    @Part(name: "plan_start_date") String? planStartDate,
    @Part(name: "plan_duration") String planDuration,
    @Part(name: "assigned_to") String assignedTo,
    @Part(name: "document") MultipartFile? document,
  );

  @GET("/api/auth/sales/{id}")
  Future<GetSaleDetilesModel> getSaleDetiles(@Path('id') String id);

  @POST("/api/auth/change-password")
  Future<ChangePasswordResModel> changePassword(
    @Body() ChangePasswordBodyModel body,
  );

  @GET("/api/auth/sales")
  Future<GetSaleModel> getSale();

  @GET("/api/auth/tickets")
  Future<GetTicketModel> getTicket();

  @GET("/api/auth/tickets/{id}")
  Future<GetTicketDetailsModel> getTicketDetails(@Path('id') String id);

  @GET("/api/auth/clients")
  Future<GetClientModel> getClient();

  @GET("/api/auth/clients/{id}")
  Future<GetClienDetailsModel> getClientDetails(@Path('id') String id);

  @GET("/api/auth/profile")
  Future<GetProfileModel> getProfile();

  @MultiPart()
  @POST("/api/auth/profile/update")
  Future<EditProfileResModel> editProfile(
    @Part(name: "full_name") String fullName,
    @Part(name: "phone") String phone,
    @Part(name: "email") String? email,
    @Part(name: "dob") String? dob,
    @Part(name: "gender") String? gender,
    @Part(name: "sales_executive") String? sales,
    @Part(name: "department") String? department,
    @Part(name: "employee_id") String? employeeId,
    @Part(name: "emergency_phone") String? emergencyPhone,
    @Part(name: "offer_letter") MultipartFile? offerLetter,
  );

  @GET("/api/auth/products")
  Future<ProductIdModel> getProductId();

  @POST("/api/auth/leads/store")
  Future<AddLeadResModel> addLead(@Body() AddLeadBodyModel body);

  @GET("/api/auth/leads")
  Future<GetLeadModel> getLead();

  @GET("/api/auth/dashboard")
  Future<DashboardResponseModel> getDashboard();

  @GET("/api/auth/attendance/history")
  Future<AttendenceHistoryResponse> getAttendenceHistory();

  @GET("/api/auth/attendance/summary")
  Future<AttendenceSummaryResponse> getAttendenceSummary();

  @POST("/api/auth/attendance/check-in")
  Future<CheckInResponseModel> checkIn(@Body() CheckBodyModel body);

  @POST("/api/auth/attendance/check-out")
  Future<CheckOutResponseModel> checkOut(@Body() CheckBodyModel body);

  @GET("/api/auth/notifications")
  Future<GetNotficationModel> getNotification();

  @GET("/api/auth/notifications/unread-count")
  Future<UnreadCountModel> unreadCount();

  @DELETE("/api/auth/notifications/delete/{id}")
  Future<DeleteNotificationModel> deleteNotification(@Path('id') String id);

  @POST("/api/auth/notifications/mark-read/{id}")
  Future<MarkReadResModel> markReadNorification(@Path('id') String id);

  @POST("/api/auth/notifications/mark-all-read")
  Future<MarkReadResModel> markAllReadNotificaion();

  @DELETE("/api/auth/notifications/clear-all")
  Future<DeleteNotificationModel> multipleDeleteNotification(
    @Body() MultipleDeleteNotificationBodyModel body,
  );

  @GET("/api/auth/leads/{id}")
  Future<LeadDetailsModel> leadDetails(@Path('id') String id);

  @POST("/api/auth/leads/update/{id}")
  Future<LeadUpdateResModel> leadUpdate(
    @Path('id') String id,
    @Body() LeadUpdateBodyModel body,
  );

  @DELETE("/api/auth/leads/delete/{id}")
  Future<DeleteNotificationModel> leadDelete(@Path('id') String id);

  @DELETE("/api/auth/clients/delete/{id}")
  Future<DeleteNotificationModel> clientDelete(@Path('id') String id);

  @DELETE("/api/auth/tickets/delete/{id}")
  Future<DeleteNotificationModel> ticketDelete(@Path('id') String id);

  @MultiPart()
  @POST("/api/auth/tickets/update/{id}")
  Future<CreateTicketResModel> updateTicket(
    @Path('id') String id,
    @Part(name: "issue_title") String issueTitle,
    @Part(name: "issue_description") String issueDescription,
    @Part(name: "issue_category") String issueCategory,
    @Part(name: "priority") String priority,
    @Part(name: "attachment") MultipartFile? attachment,
    @Part(name: "internal_note") String internalNote,
  );

  @DELETE("/api/auth/sales/delete/{id}")
  Future<DeleteNotificationModel> saleDelete(@Path('id') String id);

  @MultiPart()
  @POST("/api/auth/sales/update/{id}")
  Future<AddSaleResModel> updateSale(
    @Path("id") String id,
    @Part(name: "product_id") String issuetitle,
    @Part(name: "quantity") String quantity,
    @Part(name: "payment_status") String paymentstatus,
    @Part(name: "payment_method") String paymentmethod,
    @Part(name: "note") String note,
    @Part(name: "image") MultipartFile? image,
  );
  @GET("/api/auth/follow-up-reminders")
  Future<GetFollowUpReminderModel> getLeadFollowUpReminder();

  @POST("/api/auth/follow-up-mark-done/{id}")
  Future<MarkDoneFollowUpModel> markDoneFolloUp(@Path('id') String id);

  @POST("/api/auth/re-schedule follow-up/{id}")
  Future<RescheduleFollowUpResModel> rescheduleFollowUp(
    @Path('id') String id,
    @Body() RescheduleFollowUpBodyModel body,
  );
}
