// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
    bool? status;
    String? message;
    Data? data;

    GetProfileModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    int? userId;
    String? employeeId;
    String? fullName;
    DateTime? dob;
    String? gender;
    String? phone;
    String? alternatePhone;
    String? email;
    String? address;
    String? state;
    String? city;
    String? pincode;
    String? emergencyName;
    String? emergencyRelationship;
    String? emergencyPhone;
    String? aadharNumber;
    String? panNumber;
    String? bankAccountNumber;
    String? ifscCode;
    String? bankName;
    String? offerLetter;
    dynamic aadharCard;
    dynamic panCard;
    dynamic bankPassbook;
    String? designation;
    String? department;
    String? sale;
    String? employmentType;
    String? reportingManager;
    String? workLocation;
    DateTime? joiningDate;
    String? monthlySalary;
    String? incentiveStructure;
    String? incentiveDetails;
    String? monthlySalesTarget;
    String? loginEmail;
    String? biometricEnrolled;
    String? biometricDevice;
    String? biometricMethod;
    String? gpsTracking;
    String? trackingType;
    String? locationUpdateFrequency;
    String? fieldEmployee;
    String? markAttendanceVia;
    String? lateArrivalThreshold;
    String? overtimeTracking;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? companyName;

    Data({
        this.id,
        this.userId,
        this.employeeId,
        this.fullName,
        this.dob,
        this.sale,
        this.gender,
        this.phone,
        this.alternatePhone,
        this.email,
        this.address,
        this.state,
        this.city,
        this.pincode,
        this.emergencyName,
        this.emergencyRelationship,
        this.emergencyPhone,
        this.aadharNumber,
        this.panNumber,
        this.bankAccountNumber,
        this.ifscCode,
        this.bankName,
        this.offerLetter,
        this.aadharCard,
        this.panCard,
        this.bankPassbook,
        this.designation,
        this.department,
        this.employmentType,
        this.reportingManager,
        this.workLocation,
        this.joiningDate,
        this.monthlySalary,
        this.incentiveStructure,
        this.incentiveDetails,
        this.monthlySalesTarget,
        this.loginEmail,
        this.biometricEnrolled,
        this.biometricDevice,
        this.biometricMethod,
        this.gpsTracking,
        this.trackingType,
        this.locationUpdateFrequency,
        this.fieldEmployee,
        this.markAttendanceVia,
        this.lateArrivalThreshold,
        this.overtimeTracking,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.companyName,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        fullName: json["full_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        sale: json["sale"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        email: json["email"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        emergencyName: json["emergency_name"],
        emergencyRelationship: json["emergency_relationship"],
        emergencyPhone: json["emergency_phone"],
        aadharNumber: json["aadhar_number"],
        panNumber: json["pan_number"],
        bankAccountNumber: json["bank_account_number"],
        ifscCode: json["ifsc_code"],
        bankName: json["bank_name"],
        offerLetter: json["offer_letter"],
        aadharCard: json["aadhar_card"],
        panCard: json["pan_card"],
        bankPassbook: json["bank_passbook"],
        designation: json["designation"],
        department: json["department"],
        employmentType: json["employment_type"],
        reportingManager: json["reporting_manager"],
        workLocation: json["work_location"],
        joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
        monthlySalary: json["monthly_salary"],
        incentiveStructure: json["incentive_structure"],
        incentiveDetails: json["incentive_details"],
        monthlySalesTarget: json["monthly_sales_target"],
        loginEmail: json["login_email"],
        biometricEnrolled: json["biometric_enrolled"],
        biometricDevice: json["biometric_device"],
        biometricMethod: json["biometric_method"],
        gpsTracking: json["gps_tracking"],
        trackingType: json["tracking_type"],
        locationUpdateFrequency: json["location_update_frequency"],
        fieldEmployee: json["field_employee"],
        markAttendanceVia: json["mark_attendance_via"],
        lateArrivalThreshold: json["late_arrival_threshold"],
        overtimeTracking: json["overtime_tracking"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        companyName: json["company_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "full_name": fullName,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "email": email,
        "address": address,
        "state": state,
        "city": city,
        "pincode": pincode,
        "emergency_name": emergencyName,
        "emergency_relationship": emergencyRelationship,
        "emergency_phone": emergencyPhone,
        "aadhar_number": aadharNumber,
        "pan_number": panNumber,
        "bank_account_number": bankAccountNumber,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "offer_letter": offerLetter,
        "aadhar_card": aadharCard,
        "pan_card": panCard,
        "bank_passbook": bankPassbook,
        "designation": designation,
        "department": department,
        "employment_type": employmentType,
        "reporting_manager": reportingManager,
        "work_location": workLocation,
        "joining_date": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "monthly_salary": monthlySalary,
        "incentive_structure": incentiveStructure,
        "incentive_details": incentiveDetails,
        "monthly_sales_target": monthlySalesTarget,
        "login_email": loginEmail,
        "biometric_enrolled": biometricEnrolled,
        "biometric_device": biometricDevice,
        "biometric_method": biometricMethod,
        "gps_tracking": gpsTracking,
        "tracking_type": trackingType,
        "location_update_frequency": locationUpdateFrequency,
        "field_employee": fieldEmployee,
        "mark_attendance_via": markAttendanceVia,
        "late_arrival_threshold": lateArrivalThreshold,
        "overtime_tracking": overtimeTracking,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "company_name": companyName,
    };
}
