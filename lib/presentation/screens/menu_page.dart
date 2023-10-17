import 'package:auto_size_text/auto_size_text.dart';
import 'package:docmehr/presentation/screens/login.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/drawer_model.dart';
import '../../core/constants.dart';

class MenuPage extends StatefulWidget {
  final DrawerItem? currentitem;
  final ValueChanged<DrawerItem>? onSelected;
  const MenuPage({super.key, this.currentitem, this.onSelected});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFF0F4FF),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 55,
                          right: 140,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 80,
                              margin: const EdgeInsets.only(left: 22),
                              // color: Colors.red,
                              child: Image.asset(
                                Asset.logoWithName,
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: const Alignment(0, 0),
                              child: Text(
                                StringConstants.version,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff354592),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...DrawerItems.all.map(buildMenuItem).toList(),

                  //Spacer(),
                ],
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F4FF),
                        shape: const RoundedRectangleBorder()),
                    onPressed: () {
                      showWarn(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Logout",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 100),
                        const Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(DrawerItem item) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(right: 20, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: ListTileTheme(
          selectedTileColor: Colors.white,
          dense: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: ListTile(
                selected: item == widget.currentitem,
                minLeadingWidth: 20,
                leading: Icon(
                  item.Icon,
                  color: item == widget.currentitem
                      ? const Color(0xff354592)
                      : Colors.black,
                ),
                title: AutoSizeText(
                  item.title,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    //fontSize: 14
                  ),
                ),
                onTap: () => widget.onSelected!(item)),
          ),
        ),
      ),
    );
  }

  Future<bool?> showWarn(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Icon(
            Icons.error_outline,
            color: Colors.yellow,
            size: 60,
          ),
          content: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                  child: Text(
                "Are you sure to log out?",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ))),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF3392BE),
                      elevation: 0),
                  onPressed: () async {
                    await UserDatabase.instance.delete(1).then((_) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Login.routeName, (route) => false);
                    });
                  },
                  child: const Text(
                    "Yes",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF3392BE).withOpacity(0.5),
                      elevation: 0),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    "No",
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
