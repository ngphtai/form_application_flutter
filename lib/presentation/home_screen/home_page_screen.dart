import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';
import 'components/post_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(),
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
          child: Column(children: [
        GestureDetector(
            onTap: () =>
                context.push("${Routers.homePage}/${Routers.detailPage}"),
            child: const PostWidget())
      ])),
    );
  }
}
