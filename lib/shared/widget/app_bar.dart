import 'package:flutter/material.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:go_router/go_router.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const SharedAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (title != null) {
      return AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              context.pop(context);
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: 14,
                    ),
                    Text(
                      "Back",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: size.width * 0.102,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.white,
              height: 1.0,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.logo2, height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  )
                ],
              ),
            ],
          ));
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.white,
            height: 1.0,
          ),
        ),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AppIcons.logo,
            height: size.width * 0.25,
            width: size.width * 0.25,
          ),
        )),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 1); // AppBar height + bottom divider
}
