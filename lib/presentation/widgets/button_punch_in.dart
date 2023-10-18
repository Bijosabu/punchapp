import 'package:docmehr/application/blocs/punch/punch_event.dart';
import 'package:docmehr/core/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../application/blocs/punch/punch_bloc.dart';
import '../../application/blocs/userData/user_bloc.dart';
import '../../application/blocs/userData/user_state.dart';
import '../../services/shared_preference.dart';

class ButtonPunchIn extends StatefulWidget {
  const ButtonPunchIn({super.key});

  @override
  State<ButtonPunchIn> createState() => _ButtonPunchInState();
}

class _ButtonPunchInState extends State<ButtonPunchIn> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height > 700 ? _height * 0.6 : _height * 0.7,
      padding: const EdgeInsets.only(left: 50, right: 50, top: 8, bottom: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xff354592),
          ));
        } else if (state is UserLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  state.user.empName.toString(),
                  style: GoogleFonts.poppins(
                    color: const Color(0xff354592),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  state.user.desigName.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          borderSide: BorderSide(color: Color(0xff354592))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          borderSide: BorderSide(color: Color(0xff354592))),
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Color(0xff354592),
                      ),
                      hintText: 'Please Enter the Location',
                      hintStyle: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFB7C6D8),
                      ),
                    ),
                    maxLines: 1,
                    controller: _locationController,
                  ),
                ),
                const SizedBox(height: 1),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Remarks',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB7C6D8),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xff354592))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xff354592))),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 2,
                  controller: _remarkController,
                ),
                GestureDetector(
                  onTap: () async {
                    String loc = _locationController.text;
                    String remark = _remarkController.text;
                    if (loc.isNotEmpty && remark.isNotEmpty) {
                      await SharedPrefs()
                          .setPunchState(PunchingState.punchInRunning);
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<PunchBloc>(context)
                          .add(UserPunchIn(loc: loc, remark: remark));
                      // await SharedPrefs()
                      //     .setPunchState(PunchingState.punchInRunning);
                      // context
                      //     .read<PunchBloc>()
                      //     .add(UserPunchIn(loc: loc, remark: remark));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: _width * 0.50,
                    height: _height * 0.20,
                    decoration: const BoxDecoration(
                      color: Color(0xff0de880),
                      borderRadius: BorderRadius.all(
                        Radius.circular(45.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Center(
                                child: Image.asset(
                          "assets/images/fingerprint.png",
                          fit: BoxFit.fill,
                          height: 70,
                        ))),
                        Text(
                          "CHECK IN",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 2,
                  ),
                  child: Text(
                    'Ready to check in',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // BlocBuilder<PunchBloc, PunchState>(builder: (context, state) {
                //   if (state is CurrentState) {
                //     return Text(state.punch.toString());
                //   } else {
                //     return const Center(child: Text('Something went wrong.'));
                //   }
                // })
              ],
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      }),
    );
  }
}
