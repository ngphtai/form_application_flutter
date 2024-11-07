import 'dart:ffi';

import 'package:dsoft_form_application/app.dart';
import 'package:dsoft_form_application/common/extensions/conver_string_to_enum.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/domain/models/item_model.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/bloc/form_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/custom_drop_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/pick_image_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/radio_question_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/share_container.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/text_field_custom2.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/text_field_custom_without_bloc.dart';
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

  bool checkValidToSubmit = false;
  // khai báo danh sách bloc
  // Map<int, Cubit> textFieldsBloc = {};
  Map<int, TextEditingController> textEditControllers = {};
  Map<int, bool> isRequired = {};
  Map<int, bool> isError = {};
  Map<int, Cubit> radioButtonsBloc = {};
  Map<int, Cubit> customDropBloc = {};
  Map<int, Cubit> checkBoxBloc = {};
  Map<int, Cubit> radioQuestionBloc = {};
  Map<int, Cubit> pickImageBloc = {};
  Map<int, Cubit> checkboxQuestionBloc = {};
  Map<int, Cubit> datePickerBloc = {};
  Map<int, Cubit> timePickerBloc = {};
  Map<int, Cubit> dropdownBloc = {};

  bool isClosed = false;
  @override
  void dispose() {
    // textFieldsBloc;
    radioButtonsBloc;
    customDropBloc;
    checkBoxBloc;
    radioQuestionBloc;
    pickImageBloc;
    checkboxQuestionBloc;
    datePickerBloc;
    timePickerBloc;
    isClosed = true;
    print("close widget form page");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                initializeBlocs(state.post.itemModels);
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.post.itemModels.length,
                      itemBuilder: (context, index) {
                        bool isRequired =
                            state.post.itemModels[index].isRequired ?? false;

                        final item = state.post.itemModels[index];

                        //Convert string to enum
                        String jsonType = state.post.itemModels[index].type;

                        FormType? formType = jsonType.toFormType();

                        switch (formType) {
                          //simple text
                          case FormType.TEXT:
                            {
                              return ShareContainer(
                                  widget: TextFieldCustomWithoutBloc(
                                      maxLine: 1,
                                      isError:
                                          isError[item.index] as bool ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          if (isRequired &&
                                              textEditControllers[item.index]!
                                                  .text
                                                  .isNotEmpty) {
                                            isError[item.index] = false;
                                          } else {
                                            isError[item.index] = true;
                                          }
                                        });
                                      },
                                      textController:
                                          textEditControllers[item.index]!,
                                      isRequest: isRequired),
                                  title: item.title,
                                  isRequest: isRequired);
                            }
                          //multi text
                          case FormType.PARAGRAPH_TEXT:
                            {
                              return ShareContainer(
                                widget: TextFieldCustomWithoutBloc(
                                  maxLine: 1,
                                  isError:
                                      isError[item.index] as bool? ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      // Kiểm tra điều kiện để cập nhật isError
                                      if (isRequired && value.isNotEmpty) {
                                        isError[item.index] = false;
                                      } else {
                                        isError[item.index] = true;
                                      }
                                    });
                                  },
                                  textController:
                                      textEditControllers[item.index]!,
                                  isRequest: isRequired,
                                ),
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.MULTIPLE_CHOICE:
                            {
                              return ShareContainer(
                                widget: RadioButton(
                                  listRadio:
                                      item.choices ?? ["câu hỏi bị trống!"],
                                  nameGroup: item.title,
                                  isRequest: isRequired,
                                  isError: isError[item.index] ?? false,
                                  radioButtonBloc: radioButtonsBloc[item.index]
                                      as RadioButtonBloc,
                                ),
                                textInputControl: null,
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.CHECKBOX:
                            {
                              return ShareContainer(
                                widget: CheckboxButton(
                                  listCheckbox: item.choices ?? [],
                                  checkboxButtonBloc: checkBoxBloc[item.index]
                                      as CheckboxButtonBloc,
                                  isRequest: isRequired,
                                ),
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.LIST:
                            {
                              return ShareContainer(
                                widget: CustomDropButton(
                                  listDropDown: item.choices ?? ["có lỗi!"],
                                  isRequest: isRequired,
                                  customDropButtonBloc: dropdownBloc[item.index]
                                      as CustomDropButtonBloc,
                                ),
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.TIME:
                            {
                              return ShareContainer(
                                widget: TimePickerCustom(
                                  isRequest: isRequired,
                                  title: ("Chọn giờ"),
                                  timePickerCustomBloc:
                                      timePickerBloc[item.index]
                                          as TimePickerCustomBloc,
                                ),
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.DATE:
                            {
                              return ShareContainer(
                                widget: DatePicker(
                                  isRequest: true,
                                  datePickerBloc: datePickerBloc[item.index]
                                      as DatePickerBloc,
                                ),
                                title: item.title,
                                isRequest: isRequired,
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
              } else {
                return Text("loading");
              }
            },
          ),

          //Button action
          BlocBuilder<DetailPageBloc, DetailPageState>(
            builder: (context, state) {
              return Positioned(
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
                              if (state is DetailPageLoaded) {
                                state.post.itemModels.forEach((element) {});

                                checkValidToSubmit = true;
                                //Text
                                for (var entry in textEditControllers.entries) {
                                  final key = entry.key;
                                  final controller = entry.value;
                                  print(
                                      "key: $key, controller: ${controller.text}");
                                  if ((controller.text.isEmpty ||
                                          controller.text == "") &&
                                      (isRequired[key] == true)) {
                                    checkValidToSubmit = false;
                                    isError[key] = true;
                                    showMessenger(context);
                                    break;
                                  } else if (controller.text.isNotEmpty) {
                                    isError[key] = false;
                                    checkValidToSubmit = true;
                                  }
                                }

                                // radio box
                                for (var entry in radioButtonsBloc.entries) {
                                  final key = entry.key;
                                  final radioButtonsBloc = entry.value;
                                  if (radioButtonsBloc is RadioButtonBloc) {
                                    final String? values =
                                        radioButtonsBloc.values;

                                    if (values == null &&
                                        isRequired[key] == true) {
                                      radioButtonsBloc.validate("error");
                                      checkValidToSubmit = false;
                                      isError[key] = true;
                                      showMessenger(context);
                                      break;
                                    } else {
                                      checkValidToSubmit = true;
                                    }
                                  }
                                }

                                // In ra giá trị cuối cùng để kiểm tra
                                print(
                                    "Final checkValidToSubmit: $checkValidToSubmit");

                                // Hiển thị SnackBar dựa vào kết quả validate
                                showMessenger(context);
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
              );
            },
          ),
        ],
      ),
    );
  }

  void showMessenger(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(checkValidToSubmit
            ? "Đã lưu thành công"
            : "Vui lòng điền đầy đủ thông tin"),
        backgroundColor: checkValidToSubmit ? Colors.green : Colors.red,
      ),
    );
  }

  // bool validateAllBloc() {
  //   final List<Cubit> blocs = [
  //     ...textFieldsBloc.values,
  //     ...radioButtonsBloc.values,
  //     ...checkBoxBloc.values,
  //     ...datePickerBloc.values,
  //     ...timePickerBloc.values,
  //     ...dropdownBloc.values
  //   ];
  //   for (var bloc in blocs) {
  //     if (bloc.state != null) {
  //       return true; // Nếu có ít nhất một state có giá trị, trả về true
  //     }
  //   }

  //   return false; // Nếu tất cả các state đều là null, trả về false
  // }

  void initializeBlocs(List<ItemModel> items) {
    //Convert string to enum

    for (var item in items) {
      isError[item.index] = isError[item.index] ?? false;

      isRequired[item.index] = isRequired[item.index] ?? item.isRequired!;

      String jsonType = item.type;

      FormType? formType = jsonType.toFormType();
      switch (formType) {
        case FormType.TEXT:
          // textFieldsBloc[item.index] = TextFieldBLoc();
          textEditControllers[item.index] = TextEditingController();
          break;
        case FormType.PARAGRAPH_TEXT:
          // textFieldsBloc[item.index] = TextFieldBLoc();
          textEditControllers[item.index] = TextEditingController();
          break;
        case FormType.MULTIPLE_CHOICE:
          radioButtonsBloc[item.index] = RadioButtonBloc();
          break;
        case FormType.CHECKBOX:
          checkBoxBloc[item.index] = CheckboxButtonBloc();
          break;
        case FormType.DATE:
          datePickerBloc[item.index] = DatePickerBloc();
          break;
        case FormType.TIME:
          timePickerBloc[item.index] = TimePickerCustomBloc();
          break;
        case FormType.LIST:
          dropdownBloc[item.index] = CustomDropButtonBloc();
        // thiếu pick image, widget question
        case null:
          break;
      }
    }
    // AppLogger.instance.d("textFieldsBloc: $textFieldsBloc");
    // AppLogger.instance.d("radioButtonsBloc: $radioButtonsBloc");
    // AppLogger.instance.d("checkBoxBloc: $checkBoxBloc");
    // AppLogger.instance.d("datePickerBloc: $datePickerBloc");
    // AppLogger.instance.d("timePickerBloc: $timePickerBloc");
    // AppLogger.instance.d("dropdownBloc: $dropdownBloc");
    // AppLogger.instance.d("Build bloc success!");
  }
}
