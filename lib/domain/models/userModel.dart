

const String tableUser = 'user';

class UserFields {
  static final List<String> values = [
    /// Add all fields
  id,
  status,
  empCode,
  empName,
  deptName,
  desigName,
  empImage,
  instName,
  instAddress,
  instPlace,
  northLat,
  westLong,
  southLat,
  eastLong,
  empToken,
  instId,
  empId,
  userId,
  punchMethod
  ];

  static const String id = '_id';
  static const String status = 'Status';
  static const String empCode = 'empcode';
  static const String empName = 'empname';
  static const String deptName = 'deptname';
  static const String desigName = 'designame';
  static const String empImage = 'empimage';
  static const String instName = 'instname';
  static const String instAddress = 'instaddress';
  static const String instPlace = 'instplace';
  static const String northLat = 'northlat';
  static const String westLong = 'westlong';
  static const String southLat = 'southlat';
  static const String eastLong = 'eastlong';
  static const String empToken = 'emptoken';
  static const String instId = 'Inst_ID';
  static const String empId = 'Emp_Id';
  static const String userId = 'UserID';
  static const String punchMethod = 'punchmethod';
}

class User {
  final int? id;
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

  const User({
    this.id,
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

  User copy({
    int? id,
    int? status,
    String? empCode,
    String? empName,
    String? deptName,
    String? desigName,
    String? empImage,
    String? instName,
    String? instAddress,
    String? instPlace,
    String? northLat,
    String? westLong,
    String? southLat,
    String? eastLong,
    String? empToken,
    int? instId,
    int? empId,
    int? userId,
    String? punchMethod,
  }) =>
      User(
        id: id ?? this.id,
        status: status ?? this.status,
        empCode: empCode ?? this.empCode,
        empName: empName ?? this.empName,
        deptName: deptName ?? this.deptName,
        desigName: desigName ?? this.desigName,
        empImage: empImage ?? this.empImage,
        instName: instName ?? this.instName,
        instAddress: instAddress ?? this.instAddress,
        instPlace: instPlace ?? this.instPlace,
        northLat: northLat ?? this.northLat,
        westLong: westLong ?? this.westLong,
        southLat: southLat ?? this.southLat,
        eastLong: eastLong ?? this.eastLong,
        empToken: empToken ?? this.empToken,
        instId: instId ?? this.instId,
        empId: empId ?? this.empId,
        userId: userId ?? this.userId,
        punchMethod: punchMethod ?? this.punchMethod,
      );

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UserFields.id] as int? ?? 1,
    status: json[UserFields.status] as int,
    empCode: json[UserFields.empCode] as String,
    empName: json[UserFields.empName] as String,
    deptName: json[UserFields.deptName] as String,
    desigName: json[UserFields.desigName] as String,
    empImage: json[UserFields.empImage] as String,
    instName: json[UserFields.instName] as String,
    instAddress: json[UserFields.instAddress] as String,
    instPlace: json[UserFields.instPlace] as String,
    northLat: json[UserFields.northLat] as String,
    westLong: json[UserFields.westLong] as String,
    southLat: json[UserFields.southLat] as String,
    eastLong: json[UserFields.eastLong] as String,
    empToken: json[UserFields.empToken] as String,
    instId: json[UserFields.instId] as int,
    empId: json[UserFields.empId] as int,
    userId: json[UserFields.userId] as int,
    punchMethod: json[UserFields.punchMethod] as String,
  );

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.status: status,
    UserFields.empCode: empCode,
    UserFields.empName: empName,
    UserFields.deptName: deptName,
    UserFields.desigName: desigName,
    UserFields.empImage: empImage,
    UserFields.instName: instName,
    UserFields.instAddress: instAddress,
    UserFields.instPlace: instPlace,
    UserFields.northLat: northLat,
    UserFields.westLong: westLong,
    UserFields.southLat: southLat,
    UserFields.eastLong: eastLong,
    UserFields.empToken: empToken,
    UserFields.instId: instId,
    UserFields.empId: empId,
    UserFields.userId: userId,
    UserFields.punchMethod: punchMethod,
  };
}

