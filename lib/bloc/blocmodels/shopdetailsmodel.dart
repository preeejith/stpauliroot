class ShopDetailedModel {
  bool? status;
  int? statusCode;

  Data? data;
  List<Null>? users;
  List<Services>? services;
  String? message;

  ShopDetailedModel(
      {this.status,
      this.statusCode,
      this.data,
      this.users,
      this.services,
      this.message});

  ShopDetailedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['users'] != null) {
      users = <Null>[];
      json['users'].forEach((v) {
        // users!.add(new Null.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (users != null) {
      // data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? sId;
  String? description;
  List<double>? location;
  bool? isVerified;
  num? averageRating;
  num? totalRating;
  int? noOfCustomers;
  int? documentsUploaded;
  List<Null>? images;
  String? onlineStatus;
  String? status;
  int? phoneNo;
  UserId? userId;
  BusinessCategory? businessCategory;
  String? createDate;
  String? updateDate;
  int? iV;
  String? addressLine1;
  String? addressLine2;
  String? businessName;
  String? cityName;
  int? pincode;
  String? uniqueCode;
  String? businessBoard;
  String? vistingCard;
  String? logo;

  Data(
      {this.sId,
      this.description,
      this.location,
      this.isVerified,
      this.averageRating,
      this.totalRating,
      this.noOfCustomers,
      this.documentsUploaded,
      this.images,
      this.onlineStatus,
      this.status,
      this.phoneNo,
      this.userId,
      this.businessCategory,
      this.createDate,
      this.updateDate,
      this.iV,
      this.addressLine1,
      this.addressLine2,
      this.businessName,
      this.cityName,
      this.pincode,
      this.uniqueCode,
      this.businessBoard,
      this.vistingCard,
      this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    location = json['location'].cast<double>();
    isVerified = json['is_verified'];
    averageRating = json['average_rating'];
    totalRating = json['total_rating'];
    noOfCustomers = json['no_of_customers'];
    documentsUploaded = json['documents_uploaded'];
    if (json['images'] != null) {
      images = <Null>[];
      json['images'].forEach((v) {
        // images!.add(new Null.fromJson(v));
      });
    }
    onlineStatus = json['online_status'];
    status = json['status'];
    phoneNo = json['phone_no'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    businessCategory = json['business_category'] != null
        ? BusinessCategory.fromJson(json['business_category'])
        : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    businessName = json['business_name'];
    cityName = json['city_name'];
    pincode = json['pincode'];
    uniqueCode = json['unique_code'];
    businessBoard = json['business_board'];
    vistingCard = json['visting_card'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['location'] = location;
    data['is_verified'] = isVerified;
    data['average_rating'] = averageRating;
    data['total_rating'] = totalRating;
    data['no_of_customers'] = noOfCustomers;
    data['documents_uploaded'] = documentsUploaded;
    if (images != null) {
      // data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['online_status'] = onlineStatus;
    data['status'] = status;
    data['phone_no'] = phoneNo;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (businessCategory != null) {
      data['business_category'] = businessCategory!.toJson();
    }
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['business_name'] = businessName;
    data['city_name'] = cityName;
    data['pincode'] = pincode;
    data['unique_code'] = uniqueCode;
    data['business_board'] = businessBoard;
    data['visting_card'] = vistingCard;
    data['logo'] = logo;
    return data;
  }
}

class UserId {
  String? sId;
  String? userType;
  String? phoneNo;
  int? level;
  String? emailId;
  String? userName;

  UserId(
      {this.sId,
      this.userType,
      this.phoneNo,
      this.level,
      this.emailId,
      this.userName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    level = json['level'];
    emailId = json['email_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_type'] = userType;
    data['phone_no'] = phoneNo;
    data['level'] = level;
    data['email_id'] = emailId;
    data['user_name'] = userName;
    return data;
  }
}

class BusinessCategory {
  String? sId;
  String? businessName;

  BusinessCategory({this.sId, this.businessName});

  BusinessCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['business_name'] = businessName;
    return data;
  }
}

class Services {
  List<Null>? isDaywise;
  String? sId;
  int? amount;
  int? discountAmount;
  int? taxPercentage;
  List<String>? availableDays;
  bool? serviceShowToCustomers;
  num? averageRating;
  num? totalRating;
  String? slotType;
  String? status;
  String? userId;
  String? partnerId;
  ServiceCategoryId? serviceCategoryId;
  String? businessCategory;
  String? description;
  String? createDate;
  String? updateDate;
  int? iV;

  Services(
      {this.isDaywise,
      this.sId,
      this.amount,
      this.discountAmount,
      this.taxPercentage,
      this.availableDays,
      this.serviceShowToCustomers,
      this.averageRating,
      this.totalRating,
      this.slotType,
      this.status,
      this.userId,
      this.partnerId,
      this.serviceCategoryId,
      this.businessCategory,
      this.description,
      this.createDate,
      this.updateDate,
      this.iV});

  Services.fromJson(Map<String, dynamic> json) {
    if (json['isDaywise'] != null) {
      isDaywise = <Null>[];
      json['isDaywise'].forEach((v) {
        // isDaywise!.add(new Null.fromJson(v));
      });
    }
    sId = json['_id'];
    amount = json['amount'];
    discountAmount = json['discount_amount'];
    taxPercentage = json['tax_percentage'];
    availableDays = json['available_days'].cast<String>();
    serviceShowToCustomers = json['service_show_to_customers'];
    averageRating = json['average_rating'];
    totalRating = json['total_rating'];
    slotType = json['slot_type'];
    status = json['status'];
    userId = json['user_id'];
    partnerId = json['partner_id'];
    serviceCategoryId = json['service_category_id'] != null
        ? ServiceCategoryId.fromJson(json['service_category_id'])
        : null;
    businessCategory = json['business_category'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (isDaywise != null) {
      // data['isDaywise'] = this.isDaywise!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['amount'] = amount;
    data['discount_amount'] = discountAmount;
    data['tax_percentage'] = taxPercentage;
    data['available_days'] = availableDays;
    data['service_show_to_customers'] = serviceShowToCustomers;
    data['average_rating'] = averageRating;
    data['total_rating'] = totalRating;
    data['slot_type'] = slotType;
    data['status'] = status;
    data['user_id'] = userId;
    data['partner_id'] = partnerId;
    if (serviceCategoryId != null) {
      data['service_category_id'] = serviceCategoryId!.toJson();
    }
    data['business_category'] = businessCategory;
    data['description'] = description;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
  }
}

class ServiceCategoryId {
  String? sId;
  String? isUpdated;
  int? sortingOrder;
  bool? visibleToPartnerOnly;
  String? status;
  String? businessCategory;
  String? serviceName;
  String? description;
  String? createDate;
  String? updateDate;
  int? iV;
  String? photo;

  ServiceCategoryId(
      {this.sId,
      this.isUpdated,
      this.sortingOrder,
      this.visibleToPartnerOnly,
      this.status,
      this.businessCategory,
      this.serviceName,
      this.description,
      this.createDate,
      this.updateDate,
      this.iV,
      this.photo});

  ServiceCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isUpdated = json['is_updated'];
    sortingOrder = json['sorting_order'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
    status = json['status'];
    businessCategory = json['business_category'];
    serviceName = json['service_name'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_updated'] = isUpdated;
    data['sorting_order'] = sortingOrder;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    data['status'] = status;
    data['business_category'] = businessCategory;
    data['service_name'] = serviceName;
    data['description'] = description;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['photo'] = photo;
    return data;
  }
}
