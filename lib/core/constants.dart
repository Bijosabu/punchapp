import 'package:flutter/material.dart';

class Asset {
  static const background = "assets/images/background.png";
  static const logoWithName = "assets/images/loyaltri_name.png";
}

class StringConstants {
  static const version = "Version 2.0.2";
}

class ApiConstants {
  Map<String, String> apiHeader = {
    'Content-Type': 'application/json',
    'API-Key': '525-777-777'
  };
  static const getOtp = "https://sqa.docme.online/bm-wfm/api/MobileNoVerify";
  static const getUserData =
      "https://sqa.docme.online/bm-wfm/api/MobileNoRegister";
}

const kH10 = SizedBox(
  height: 10,
);
const kH20 = SizedBox(
  height: 20,
);
const kH30 = SizedBox(
  height: 30,
);
const kH40 = SizedBox(
  height: 40,
);
const kH50 = SizedBox(
  height: 50,
);
