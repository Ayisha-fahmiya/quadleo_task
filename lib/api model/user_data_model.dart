import 'dart:convert';

GetUserDataApiModel getUserDataApiModelFromJson(String str) =>
    GetUserDataApiModel.fromJson(json.decode(str));

String getUserDataApiModelToJson(GetUserDataApiModel data) =>
    json.encode(data.toJson());

class GetUserDataApiModel {
  String message;
  bool status;
  Data data;

  GetUserDataApiModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory GetUserDataApiModel.fromJson(Map<String, dynamic> json) =>
      GetUserDataApiModel(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int id;
  String subscriberId;
  String lcoNo;
  String mobile;
  String countryCode;
  dynamic routeNo;
  String customerType;
  String areaName;
  String status;
  String currencyCode;
  DateTime joinDate;
  String address;
  int balance;
  int connections;
  String name;
  String customerImage;

  Datum({
    required this.id,
    required this.subscriberId,
    required this.lcoNo,
    required this.mobile,
    required this.countryCode,
    required this.routeNo,
    required this.customerType,
    required this.areaName,
    required this.status,
    required this.currencyCode,
    required this.joinDate,
    required this.address,
    required this.balance,
    required this.connections,
    required this.name,
    required this.customerImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        subscriberId: json["subscriber_id"],
        lcoNo: json["lco_no"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        routeNo: json["route_no"],
        customerType: json["customer_type"],
        areaName: json["area_name"],
        status: json["status"],
        currencyCode: json["currency_code"],
        joinDate: DateTime.parse(json["join_date"]),
        address: json["address"],
        balance: json["balance"],
        connections: json["connections"],
        name: json["name"],
        customerImage: json["customer_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscriber_id": subscriberId,
        "lco_no": lcoNo,
        "mobile": mobile,
        "country_code": countryCode,
        "route_no": routeNo,
        "customer_type": customerType,
        "area_name": areaName,
        "status": status,
        "currency_code": currencyCode,
        "join_date": joinDate.toIso8601String(),
        "address": address,
        "balance": balance,
        "connections": connections,
        "name": name,
        "customer_image": customerImage,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
