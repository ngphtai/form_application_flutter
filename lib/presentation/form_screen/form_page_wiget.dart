import 'package:dsoft_form_application/common/extensions/conver_string_to_enum.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/bloc/form_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/custom_drop_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/pick_image_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/radio_question_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/share_container.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../common/enums/form_page_enums.dart';
import 'component/checkbox_button.dart';
import 'component/checkbox_button_bloc.dart';
import 'component/checkbox_question_button.dart';
import 'component/checkbox_question_button_bloc.dart';
import 'component/custom_drop_button_.dart';
import 'component/date_picker.dart';
import 'component/date_picker_bloc.dart';
import 'component/pick_image.dart';
import 'component/radio_button.dart';
import 'component/radio_button_bloc.dart';
import 'component/radio_question_button.dart';
import 'component/text_field_bloc.dart';
import 'component/text_field_customs.dart';
import 'component/time_picker_custom.dart';
import 'component/time_picker_customs_bloc.dart';

class FormPageWidget extends StatefulWidget {
  FormPageWidget({Key? key, required this.postId}) : super(key: key);
  final int postId;

  @override
  State<FormPageWidget> createState() => _FormPageWidgetState();
}

class _FormPageWidgetState extends State<FormPageWidget> {
  @override
  void initState() {
    super.initState();
    context.read<DetailPageBloc>().add(LoadDetailPost(widget.postId));
  }

  final DateTime? datePicker = null;

  final List<bool> listValid = List.filled(10, false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SharedAppBar(
        title: context.select<DetailPageBloc, String>((bloc) {
          final state = bloc.state;
          return state is DetailPageLoaded
              ? state.post.metaData.title
              : ". . .";
        }),
      ),
      backgroundColor: const Color(0xFFf7f7f7),
      body: Stack(
        children: [
          BlocBuilder<DetailPageBloc, DetailPageState>(
            builder: (context, state) {
              print(state);
              if (state is DetailPageInitial || state is DetailPageLoading) {
                return Center(
                  child: Container(
                    color: Colors.white,
                    height: 50.w,
                    width: 50.w,
                    child: LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin,
                      colors: const [Colors.red],
                      strokeWidth: 4.0,
                      pathBackgroundColor: Colors.red[200],
                      backgroundColor: Color(0xfff4f4f4),
                    ),
                  ),
                );
              }
              if (state is DetailPageLoaded) {
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.post.itemModels.length,
                      itemBuilder: (context, index) {
                        bool isRequired =
                            state.post.itemModels[index].isRequired ?? false;

                        final item = state.post.itemModels[index];

                        String jsonType = state.post.itemModels[index].type;

                        FormType? formType = jsonType.toFormType();

                        switch (formType) {
                          //simple text
                          case FormType.TEXT:
                            {
                              return BlocProvider(
                                create: (context) => TextFieldBLoc(),
                                child:
                                    BlocBuilder<TextFieldBLoc, TextFieldState>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      if (isValid is TextFieldValid) {
                                        listValid[0] = true;
                                      }
                                      if (isValid is TextFieldInValid ||
                                          isValid is TextFieldInit) {
                                        listValid[0] = false;
                                      }
                                    } else {
                                      listValid[0] = true;
                                    }
                                    return ShareContainer(
                                      widget: TextFieldCustoms(
                                        MaxLine: 1,
                                        onChanged: (value) {
                                          context
                                              .read<TextFieldBLoc>()
                                              .validate(value);
                                        },
                                        isError: isValid is TextFieldInit
                                            ? false
                                            : isValid is TextFieldValid
                                                ? false
                                                : true,
                                        isRequest: isRequired,
                                      ),
                                      title: item.title,
                                      isRequest: isRequired,
                                    );
                                  },
                                ),
                              );
                            }
                          //multi text
                          case FormType.PARAGRAPH_TEXT:
                            {
                              return BlocProvider(
                                create: (context) => TextFieldBLoc(),
                                child:
                                    BlocBuilder<TextFieldBLoc, TextFieldState>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      if (isValid is TextFieldValid) {
                                        listValid[0] = true;
                                      }
                                      if (isValid is TextFieldInValid ||
                                          isValid is TextFieldInit) {
                                        listValid[0] = false;
                                      }
                                    } else {
                                      listValid[0] = true;
                                    }
                                    return ShareContainer(
                                      widget: TextFieldCustoms(
                                        MaxLine: 5,
                                        onChanged: (value) {
                                          context
                                              .read<TextFieldBLoc>()
                                              .validate(value);
                                        },
                                        isError: isValid is TextFieldInit
                                            ? false
                                            : isValid is TextFieldValid
                                                ? false
                                                : true,
                                        isRequest: isRequired,
                                      ),
                                      title: item.title,
                                      isRequest: isRequired,
                                    );
                                  },
                                ),
                              );
                            }
                          case FormType.MULTIPLE_CHOICE:
                            {
                              return BlocProvider(
                                create: (context) => RadioButtonBloc(),
                                child: BlocBuilder<RadioButtonBloc, bool>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      listValid[2] = isValid;
                                    } else {
                                      listValid[2] = true;
                                    }
                                    return ShareContainer(
                                      widget: RadioButton(
                                        listRadio: item.choices ??
                                            ["câu hỏi bị trống!"],
                                        nameGroup: item.title,
                                        onChanged: (value) {
                                          context
                                              .read<RadioButtonBloc>()
                                              .Validate(value as String);
                                        },
                                        isError: isValid == true ? false : true,
                                        isRequest: isRequired,
                                      ),
                                      textInputControl: null,
                                      title: item.title,
                                    );
                                  },
                                ),
                              );
                            }
                          case FormType.CHECKBOX:
                            {
                              return BlocProvider(
                                create: (context) => CheckboxButtonBloc(),
                                child: BlocBuilder<CheckboxButtonBloc, bool>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      listValid[3] = isValid;
                                    } else {
                                      listValid[3] = true;
                                    }
                                    return ShareContainer(
                                      widget: CheckboxButton(
                                        listCheckbox: item.choices ?? [],
                                        onChanged: (value) {
                                          context
                                              .read<CheckboxButtonBloc>()
                                              .validate(value);
                                        },
                                        isRequest: isRequired,
                                        isError: isValid == true ? false : true,
                                      ),
                                      title: item.title,
                                    );
                                  },
                                ),
                              );
                            }
                          case FormType.LIST:
                            {
                              return BlocProvider(
                                create: (context) => CustomDropButtonBloc(),
                                child: BlocBuilder<CustomDropButtonBloc, bool>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      listValid[4] = isValid;
                                    } else {
                                      listValid[4] = true;
                                    }
                                    return ShareContainer(
                                      widget: CustomDropButton(
                                        listDropDown:
                                            item.choices ?? ["có lỗi!"],
                                        onChanged: (value) {
                                          context
                                              .read<CustomDropButtonBloc>()
                                              .Validate(value);
                                        },
                                        isError: isValid == true ? false : true,
                                        isRequest: isRequired,
                                      ),
                                      title: item.title,
                                      isRequest: isRequired,
                                    );
                                  },
                                ),
                              );
                            }
                          case FormType.TIME:
                            {
                              return BlocProvider(
                                create: (context) => TimePickerCustomBloc(),
                                child: BlocBuilder<TimePickerCustomBloc, bool>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      listValid[9] = isValid;
                                    } else {
                                      listValid[9] = true;
                                    }
                                    return ShareContainer(
                                      widget: TimePickerCustom(
                                        onChanged: (value) {
                                          context
                                              .read<TimePickerCustomBloc>()
                                              .validate(value);
                                        },
                                        isError: isValid ? false : true,
                                        isRequest: isRequired,
                                        title: ("Chọn giờ"),
                                      ),
                                      title: item.title,
                                      isRequest: isRequired,
                                    );
                                  },
                                ),
                              );
                            }
                          case FormType.DATE:
                            {
                              return BlocProvider(
                                create: (context) => DatePickerBloc(),
                                child: BlocBuilder<DatePickerBloc, bool>(
                                  builder: (context, isValid) {
                                    if (isRequired = true) {
                                      listValid[8] = isValid;
                                    } else {
                                      listValid[8] = true;
                                    }
                                    return ShareContainer(
                                      widget: DatePicker(
                                        isError: isValid ? false : true,
                                        isRequest: true,
                                        onChanged: (value) {
                                          if (value == null) {
                                            context
                                                .read<DatePickerBloc>()
                                                .Error(false);
                                          } else {
                                            context
                                                .read<DatePickerBloc>()
                                                .validate(value);
                                          }
                                        },
                                      ),
                                      title: item.title,
                                      isRequest: isRequired,
                                    );
                                  },
                                ),
                              );
                            }
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ]);
              } else
                return Text("loading");
            },
          ),

          //Button action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFffffff),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Trở về",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (listValid.any((valid) => !valid)) {
                            // Show error message
                            print(listValid);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please fill in all fields correctly')),
                            );
                          } else {
                            // Proceed with submission
                            // Perform the submission logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Form submitted successfully!')),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Gửi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
