class UserDefinition {
  int id;
  int companyId;
  String nameA;
  String nameE;
  String userName;
  String password;
  int? groupId;
  String tel;
  String email;
  String image;
  int isActive;
  int? requireChangePassword;
  int? typeRep;
  String ipDevice;

  UserDefinition({
    required this.id,
    required this.companyId,
    required this.nameA,
    required this.nameE,
    required this.userName,
    required this.password,
    required this.groupId,
    required this.tel,
    required this.email,
    required this.image,
    required this.isActive,
    required this.requireChangePassword,
    required this.typeRep,
    required this.ipDevice,
  });

  factory UserDefinition.fromJson(Map<String, dynamic> json) {
    return UserDefinition(
      id: json['Id'],
      companyId: json['CompanyId'],
      nameA: json['NameA'],
      nameE: json['NameE'],
      userName: json['UserName'],
      password: json['Password'],
      groupId: json['GroupID'],
      tel: json['Tel'] ?? '',
      email: json['Email'] ?? '',
      image: json['Image'] ?? '',
      isActive: json['IsActive'] ,
      requireChangePassword: json['RequireChangePassword'] ,
      typeRep: json['TypeRep'],
      ipDevice: json['IP_Device'] ?? '',
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'CompanyId': companyId,
      'NameA': nameA,
      'NameE': nameE,
      'UserName': userName,
      'Password': password,
      'GroupID': groupId,
      'Tel': tel,
      'Email': email,
      'Image': image,
      'IsActive': isActive,
      'RequireChangePassword': requireChangePassword,
      'TypeRep': typeRep,
      'IP_Device': ipDevice,
    };
    }
}
