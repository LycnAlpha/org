class Employee {
  int id;
  String employeeCode;
  String firstName;
  String lastName;
  String fullName;
  String dob;
  String personalIdNumber;
  String addressLine1;
  String addressLine2;
  String? addressLine3;
  String civilStatus;
  int desgnationId;
  String designationName;
  int departmentId;
  String departmentName;
  String employementStatus;
  String employementType;
  int probationPeriod;
  String epfEtfNumber;
  String appointedDate;
  String? resignedDate;
  String mobileNumber;
  String email;
  String emergencyContactPersonName;
  String emergencyContactPersonRelationship;
  String emergencyContactPersonContactNumber;
  int statusId;
  String statusDescription;
  bool isActive;
  bool isArchived;
  String? profileImage;

  Employee({
    required this.id,
    required this.employeeCode,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.dob,
    required this.personalIdNumber,
    required this.addressLine1,
    required this.addressLine2,
    this.addressLine3,
    required this.civilStatus,
    required this.desgnationId,
    required this.designationName,
    required this.departmentId,
    required this.departmentName,
    required this.employementStatus,
    required this.employementType,
    required this.probationPeriod,
    required this.epfEtfNumber,
    required this.appointedDate,
    this.resignedDate,
    required this.mobileNumber,
    required this.email,
    required this.emergencyContactPersonName,
    required this.emergencyContactPersonRelationship,
    required this.emergencyContactPersonContactNumber,
    required this.statusId,
    required this.statusDescription,
    required this.isActive,
    required this.isArchived,
    this.profileImage,
  });

  factory Employee.fromJson(dynamic json) {
    return Employee(
      id: json['uid'],
      employeeCode: json['employeeCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      dob: json['dateOfBirth'],
      personalIdNumber: json['personalIdNumber'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      addressLine3: json['addressLine3'],
      civilStatus: json['civilStatus'],
      desgnationId: json['designationId'],
      designationName: json['designationName'],
      departmentId: json['departmentId'],
      departmentName: json['departmentName'],
      employementStatus: json['employmentStatus'],
      employementType: json['employmentType'],
      probationPeriod: json['probationPeriod'],
      epfEtfNumber: json['epfEtfNumber'],
      appointedDate: json['appointedDate'],
      resignedDate: json['resignedDate'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      emergencyContactPersonName: json['emergencyContactPersonName'],
      emergencyContactPersonRelationship:
          json['emergencyContactPersonRelationship'],
      emergencyContactPersonContactNumber:
          json['emergencyContactPersonContactNumber'],
      statusId: json['statusId'],
      statusDescription: json['statusDescription'],
      isActive: json['active'],
      isArchived: json['archived'],
      profileImage: json['profileImage'],
    );
  }
}
