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
      child: Scaffold(
          appBar: SharedAppBar(),
          backgroundColor: const Color(0xfff7f7f7),
          body: const HistoryPageWidget()),
    );
  }
}
