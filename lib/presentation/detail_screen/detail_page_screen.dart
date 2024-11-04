import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/presentation/detail_screen/child_detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageScreen extends StatefulWidget {
  const DetailPageScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;
  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailPageBloc(),
        child: ChildDetailPageScreen(postId: widget.postId));
  }
}
