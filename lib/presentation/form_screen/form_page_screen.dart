import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/bloc/form_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/form_page_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPageScreen extends StatefulWidget {
  const FormPageScreen({super.key, required this.postId});
  final String postId;
  @override
  _FormPageScreenState createState() => _FormPageScreenState();
}

class _FormPageScreenState extends State<FormPageScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FormPageBloc()),
        BlocProvider(create: (context) => DetailPageBloc())
      ],
      child: FormPageWidget(
        postId: int.parse(widget.postId),
      ),
    );
  }
}
