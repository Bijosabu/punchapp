class UserInfoModel {
  final int status;
  final String empCode;
  final String empName;
  final String deptName;
  final String desigName;
  final String empImage;
  final String instName;
  final String instAddress;
  final String instPlace;
  final String northLat;
  final String westLong;
  final String southLat;
  final String eastLong;
  final String empToken;
  final int instId;
  final int empId;
  final int userId;
  final String punchMethod;

  UserInfoModel({
    required this.status,
    required this.empCode,
    required this.empName,
    required this.deptName,
    required this.desigName,
    required this.empImage,
    required this.instName,
    required this.instAddress,
    required this.instPlace,
    required this.northLat,
    required this.westLong,
    required this.southLat,
    required this.eastLong,
    required this.empToken,
    required this.instId,
    required this.empId,
    required this.userId,
    required this.punchMethod,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      status: json['Status'],
      empCode: json['empcode'],
      empName: json['empname'],
      deptName: json['deptname'],
      desigName: json['designame'],
      empImage: json['empimage'],
      instName: json['instname'],
      instAddress: json['instaddress'],
      instPlace: json['instplace'],
      northLat: json['northlat'],
      westLong: json['westlong'],
      southLat: json['southlat'],
      eastLong: json['eastlong'],
      empToken: json['emptoken'],
      instId: json['Inst_ID'],
      empId: json['Emp_Id'],
      userId: json['UserID'],
      punchMethod: json['punchmethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'empcode': empCode,
      'empname': empName,
      'deptname': deptName,
      'designame': desigName,
      'empimage': empImage,
      'instname': instName,
      'instaddress': instAddress,
      'instplace': instPlace,
      'northlat': northLat,
      'westlong': westLong,
      'southlat': southLat,
      'eastlong': eastLong,
      'emptoken': empToken,
      'Inst_ID': instId,
      'Emp_Id': empId,
      'UserID': userId,
      'punchmethod': punchMethod,
    };
  }
}
