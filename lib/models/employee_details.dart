class EmployeeDetails {
  int? id;
  String firstName;
  String lastName;
  String address;
  String contactNumber;
  String designation;
  String email;
  String? profileImage;
  String? team;

  EmployeeDetails({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.contactNumber,
    required this.email,
    required this.designation,
    this.profileImage,
    this.team,
  });
}
