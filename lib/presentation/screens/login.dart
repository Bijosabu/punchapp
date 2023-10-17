import 'package:docmehr/domain/models/userModel.dart';
import 'package:docmehr/domain/repositories/otpApiRepo.dart';
import 'package:docmehr/domain/repositories/userDataRepo.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../domain/models/otpModel.dart';
import '../../services/check_connectivity.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  static const routeName = 'login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _otpFocusNode = FocusNode();
  bool move2otp = false;
  String? otp;
  String? userToken;
  String? deviceId;

  @override
  void initState() {
    _getDeviceId();
    super.initState();
  }

  Future getOtp(String mobNum, String deviceId) async {
    OTPRepository instance = OTPRepository();
    String signature = await SmsAutoFill().getAppSignature;

    try {
      OTPModel response = await instance.getOTP(
          mobNum: mobNum, deviceId: deviceId, signature: signature);
      setState(() {
        otp = response.otp;
        userToken = response.userToken;
        move2otp = true;
      });
      print("---otp----$otp");
    } catch (e) {
      print("----Api calling error------${e.toString()}");
    }
  }

  Future getUserData(String userToken, String deviceId, String otp) async {
    UserRepository instance = UserRepository();

    try {
      User response = await instance.getUserData(
          userToken: userToken, deviceId: deviceId, otp: otp);
      print("---------h--------${response.status}");
      print("---------h--------${response.empCode}");
      print("---------h--------${response.empName}");
      print("---------h--------${response.deptName}");
      print("---------h--------${response.desigName}");
      print("---------h--------${response.empImage}");
      print("---------h--------${response.instName}");
      print("---------h--------${response.instAddress}");
      print("---------h--------${response.instPlace}");
      print("---------h--------${response.northLat}");
      print("---------h--------${response.westLong}");
      print("---------h--------${response.southLat}");
      print("---------h--------${response.eastLong}");
      print("---------h--------${response.empToken}");
      print("---------h--------${response.instId}");
      print("---------h--------${response.empId}");
      print("---------h--------${response.userId}");
      print("---------h--------${response.punchMethod}");
      await UserDatabase.instance.create(response);
    } catch (e) {
      print("----Api calling error------${e.toString()}");
    }
  }

  Future _navigation() async {
    _unFocus();
    if (!move2otp) {
      String value = phoneNumberController.text;
      if (value.isNotEmpty && value.length == 10) {
        String mobNum = phoneNumberController.text;
        String devId = deviceId!;
        await getOtp(mobNum, devId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid mobile number"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      String value = otpcontroller.text;
      if (otp == value) {
        String token = userToken!;
        String devId = deviceId!;
        String otpMsg = otp!;
        await getUserData(token, devId, otpMsg).then((value) async {
          await UserDatabase.instance.readData(1).then((User? user) {
            if (user != null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Login Successful"),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context).pushNamedAndRemoveUntil(
                  DashBoard.routeName, (route) => false);
            } else {
              setState(() => move2otp = false);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Login Failed"),
                backgroundColor: Colors.green,
              ));
            }
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid OTP"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  _unFocus() {
    if (_phoneNumberFocusNode.hasFocus) {
      _phoneNumberFocusNode.unfocus();
    }
    if (_otpFocusNode.hasFocus) {
      _otpFocusNode.unfocus();
    }
  }

  _getDeviceId() async => deviceId = await PlatformDeviceId.getDeviceId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocus,
      child: Scaffold(
          key: _scaffoldKey,
          body: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                      //padding: EdgeInsets.all(20.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                            // margin: const EdgeInsets.only(top: 30),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Colors.white,
                              //margin: const EdgeInsets.only(bottom: 30) ,
                              //elevation: 15,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Mask.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(
                                            top: 100, left: 30),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Welcome",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 39,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                              color: Color(0xff354592),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(left: 30),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Back",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 39,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                              color: Color(0xff354592),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 157,
                                        height: 1,
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 110),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff354592),
                                              width: 4),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(
                                            top: 80, left: 40),
                                        child: const Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            fontFamily: 'SFProText',
                                            color: Color(0xff354592),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      move2otp
                                          ? otpfield()
                                          : mobilenumberfield(),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 280, top: 20),
                                        child: FloatingActionButton(
                                          backgroundColor:
                                              const Color(0xff354592),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          elevation: 1,
                                          onPressed: () async {
                                            await CheckConnectivity()
                                                .check()
                                                .then((bool status) async {
                                              if (status) {
                                                await _navigation();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Connectivity issue"),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }
                                            });
                                          },
                                          child: const Icon(Icons.arrow_forward,
                                              color: Colors.white, size: 40),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (move2otp)
                                    GestureDetector(
                                      onTap: () async {
                                        String mobNum =
                                            phoneNumberController.text;
                                        String devId = deviceId!;
                                        await CheckConnectivity()
                                            .check()
                                            .then((bool status) async {
                                          if (status) {
                                            await getOtp(mobNum, devId);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Connectivity issue"),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        });
                                      },
                                      child: Align(
                                        alignment: const Alignment(0.05, 0.55),
                                        child: Container(
                                          //padding: EdgeInsets.only(right: 5,left: 5),
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff354592),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Resend OTP',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: const Text(
                                          "Version 2.0.2",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ))
                                ],
                              ),
                            )),
                      )),
                ],
              ),
            ),
          )),
    );
  }

  Widget mobilenumberfield() => Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          height: 40,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: phoneNumberController,
            focusNode: _phoneNumberFocusNode,
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter your mobile number',
              counterText: "",
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      );

  Widget otpfield() => Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          height: 40,
          child: TextFormField(
            controller: otpcontroller,
            focusNode: _otpFocusNode,
            maxLength: 5,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter the OTP",
              counterText: "",
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      );
}
