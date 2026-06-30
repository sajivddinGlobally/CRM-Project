// To parse this JSON data, do
//
//     final dashboardResponseModel = dashboardResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardResponseModel dashboardResponseModelFromJson(String str) => DashboardResponseModel.fromJson(json.decode(str));

String dashboardResponseModelToJson(DashboardResponseModel data) => json.encode(data.toJson());

class DashboardResponseModel {
  bool? status;
  String? message;
  Data? data;

  DashboardResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) => DashboardResponseModel(
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
  Employee? employee;
  Sales? sales;
  Leads? leads;
  Tickets? tickets;
  Clients? clients;

  Data({
    this.employee,
    this.sales,
    this.leads,
    this.tickets,
    this.clients,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    sales: json["sales"] == null ? null : Sales.fromJson(json["sales"]),
    leads: json["leads"] == null ? null : Leads.fromJson(json["leads"]),
    tickets: json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
    clients: json["clients"] == null ? null : Clients.fromJson(json["clients"]),
  );

  Map<String, dynamic> toJson() => {
    "employee": employee?.toJson(),
    "sales": sales?.toJson(),
    "leads": leads?.toJson(),
    "tickets": tickets?.toJson(),
    "clients": clients?.toJson(),
  };
}

class Clients {
  int? total;
  int? active;

  Clients({
    this.total,
    this.active,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
    total: json["total"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "active": active,
  };
}

class Employee {
  int? id;
  String? employeeId;
  String? fullName;
  String? designation;
  String? department;
  String? monthlySalesTarget;
  String? companyName;

  Employee({
    this.id,
    this.employeeId,
    this.fullName,
    this.designation,
    this.department,
    this.monthlySalesTarget,
    this.companyName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    employeeId: json["employee_id"],
    fullName: json["full_name"],
    designation: json["designation"],
    department: json["department"],
    monthlySalesTarget: json["monthly_sales_target"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "full_name": fullName,
    "designation": designation,
    "department": department,
    "monthly_sales_target": monthlySalesTarget,
    "company_name": companyName,
  };
}

class Leads {
  int? total;
  int? pending;
  int? converted;
  int? lost;

  Leads({
    this.total,
    this.pending,
    this.converted,
    this.lost,
  });

  factory Leads.fromJson(Map<String, dynamic> json) => Leads(
    total: json["total"],
    pending: json["pending"],
    converted: json["converted"],
    lost: json["lost"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "pending": pending,
    "converted": converted,
    "lost": lost,
  };
}

class Sales {
  int? totalSalesCount;
  int? totalSalesValue;
  int? target;
  double? achievementPercentage;

  Sales({
    this.totalSalesCount,
    this.totalSalesValue,
    this.target,
    this.achievementPercentage,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
    totalSalesCount: json["total_sales_count"],
    totalSalesValue: json["total_sales_value"],
    target: json["target"],
    achievementPercentage: json["achievement_percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "total_sales_count": totalSalesCount,
    "total_sales_value": totalSalesValue,
    "target": target,
    "achievement_percentage": achievementPercentage,
  };
}

class Tickets {
  int? total;
  int? open;
  int? inProgress;
  int? resolved;
  int? closed;

  Tickets({
    this.total,
    this.open,
    this.inProgress,
    this.resolved,
    this.closed,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
    total: json["total"],
    open: json["open"],
    inProgress: json["in_progress"],
    resolved: json["resolved"],
    closed: json["closed"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "open": open,
    "in_progress": inProgress,
    "resolved": resolved,
    "closed": closed,
  };
}
