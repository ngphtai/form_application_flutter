import 'dart:io';

import '../../shared/widget/share_app_bar.dart';
import '/presentation/history_screen/bloc/history_page_bloc.dart';
import '/presentation/history_screen/history_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPageScreen extends StatelessWidget {
  const HistoryPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryPageBloc(),
      child: SafeArea(
        top: false,
        bottom: Platform.isAndroid ? true : false,
        child: const Scaffold(
            appBar: SharedAppBar(),
            backgroundColor: Color(0xfff7f7f7),
            body: HistoryPageWidget()),
      ),
    );
  }
}
