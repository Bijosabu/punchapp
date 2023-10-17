
class OTPModel {
  int status;
  String userToken;
  String otp;

  OTPModel({required this.status, required this.userToken, required this.otp});

  factory OTPModel.fromJson(Map<String, dynamic> json) => OTPModel(
      status: json['Status'],
      userToken: json['UserToken'],
      otp: json['otp']
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['Status'] = status;
  //   data['UserToken'] = userToken;
  //   data['otp'] = otp;
  //   return data;
  // }
}