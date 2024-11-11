import 'dart:ffi';

import 'package:dsoft_form_application/app.dart';
import 'package:dsoft_form_application/common/extensions/conver_string_to_enum.dart';
import 'package:dsoft_form_application/common/extensions/url_conver.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';
import 'package:dsoft_form_application/domain/models/item_model.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/bloc/form_page_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/custom_drop_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/pick_image_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_question_button_bloc.dart';
import '../../core/routing/route_path.dart';
import 'component/share_container.dart';
import 'component/text_field_custom_without_bloc.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../common/enums/form_page_enums.dart';
import 'component/checkbox_button.dart';
import 'component/bloc/checkbox_button_bloc.dart';
import 'component/checkbox_question_button.dart';
import 'component/bloc/checkbox_question_button_bloc.dart';
import 'component/custom_drop_button_.dart';
import 'component/date_picker.dart';
import 'component/bloc/date_picker_bloc.dart';
import 'component/pick_image.dart';
import 'component/radio_button.dart';
import 'component/bloc/radio_button_bloc.dart';
import 'component/radio_question_button.dart';

import 'component/time_picker_custom.dart';
import 'component/bloc/time_picker_custom_bloc.dart';

// ignore: must_be_immutable
class FormPageWidget extends StatelessWidget {
  FormPageWidget({Key? key, required this.postId}) : super(key: key);

  final DateTime? datePicker = null;
  final int postId;
  bool checkValidToSubmit = true;
  // khai báo danh sách bloc
  // Map<int, Cubit> textFieldsBloc = {};
  Map<int, TextEditingController> textEditControllers = {};
  Map<int, bool?> isRequired = {};
  Map<int, bool> isError = {};
  Map<int, Cubit> radioButtonsBloc = {};
  Map<int, Cubit> customDropBloc = {};
  Map<int, Cubit> checkBoxBloc = {};
  Map<int, Cubit> radioQuestionBloc = {};
  Map<int, Cubit> pickImageBloc = {};
  Map<int, Cubit> checkboxQuestionBloc = {};
  Map<int, Cubit> datePickerBloc = {};
  Map<int, Cubit> timePickerBloc = {};

  bool isClosed = false;
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
                                        print(value);
                                        if (isRequired &&
                                            textEditControllers[item.index]!
                                                .text
                                                .isNotEmpty) {
                                          isError[item.index] = false;
                                        } else {
                                          isError[item.index] = true;
                                        }
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
                                  maxLine: 5,
                                  isError:
                                      isError[item.index] as bool? ?? false,
                                  onChanged: (value) {
                                    // Kiểm tra điều kiện để cập nhật isError
                                    if (isRequired && value.isNotEmpty) {
                                      isError[item.index] = false;
                                    } else {
                                      isError[item.index] = true;
                                    }
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
                              return BlocProvider(
                                create: (context) => checkBoxBloc[item.index]
                                    as CheckboxButtonBloc,
                                child: ShareContainer(
                                  widget: CheckboxButton(
                                    listCheckbox: item.choices ?? [],
                                    checkboxButtonBloc: checkBoxBloc[item.index]
                                        as CheckboxButtonBloc,
                                    isRequest: isRequired,
                                    isError: isError[item.index] ?? false,
                                  ),
                                  title: item.title,
                                  isRequest: isRequired,
                                ),
                              );
                            }
                          case FormType.LIST:
                            {
                              return ShareContainer(
                                widget: CustomDropButton(
                                  listDropDown: item.choices ?? [],
                                  isRequest: isRequired,
                                  customDropButtonBloc:
                                      customDropBloc[item.index]
                                          as CustomDropButtonBloc,
                                ),
                                title: item.title,
                                isRequest: isRequired,
                              );
                            }
                          case FormType.TIME:
                            {
                              return BlocProvider<TimePickerCustomBloc>(
                                  create: (context) =>
                                      timePickerBloc[item.index]
                                          as TimePickerCustomBloc,
                                  child: ShareContainer(
                                    widget: TimePickerCustom(
                                      isRequest: true,
                                      title: ("Chọn giờ"),
                                      timePickerCustomBloc:
                                          timePickerBloc[item.index]
                                              as TimePickerCustomBloc,
                                      isError: isError[item.index] ?? false,
                                    ),
                                    title: item.title,
                                    isRequest: isRequired,
                                  ));
                            }
                          case FormType.DATE:
                            {
                              return BlocProvider(
                                create: (context) => datePickerBloc[item.index]
                                    as DatePickerBloc,
                                child: ShareContainer(
                                  widget: DatePicker(
                                    isError: isError[item.index] ?? false,
                                    isRequest: true,
                                    datePickerBloc: datePickerBloc[item.index]
                                        as DatePickerBloc,
                                  ),
                                  title: item.title,
                                  isRequest: isRequired,
                                ),
                              );
                            }
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ]);
              } else {
                return const Text("");
              }
            },
          ),

          //Button action
          BlocBuilder<FormPageBloc, FormPageState>(
            builder: (context, formState) {
              print(formState);
              return BlocBuilder<DetailPageBloc, DetailPageState>(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
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
                                    final PostModelEntity postEntity =
                                        state.post.toEntity();
                                    checkValidToSubmit =
                                        checkTextControllers(postEntity);

                                    checkValidToSubmit = checkValidToSubmit &&
                                        checkRadioButtonsBloc(postEntity);

                                    checkValidToSubmit = checkValidToSubmit &&
                                        checkCheckBoxBloc(postEntity);

                                    checkValidToSubmit = checkValidToSubmit &&
                                        checkCustomDropBloc(postEntity);

                                    checkValidToSubmit = checkValidToSubmit &&
                                        checkTimePickerBloc(postEntity);

                                    checkValidToSubmit = checkValidToSubmit &&
                                        checkDatePickerBloc(postEntity);

                                    // Hiển thị thông báo dựa trên kết quả
                                    if (checkValidToSubmit) {
                                      context
                                          .read<FormPageBloc>()
                                          .add(SaveForm((postEntity)));

                                      String baseUrl =
                                          "${Routers.homePage}/${Routers.detailPage}/$postId/${Routers.formPage}/${Routers.successPage}";
                                      Map<String, dynamic> queryParams = {
                                        "title": state.post.metaData.title,
                                        "title2": state
                                            .post.metaData.confirmationMessage,
                                        "content": state.post.metaData
                                            .customClosedFormMessage
                                      };
                                      String url = baseUrl.toUrl(queryParams);
                                      context.go(url);

                                      showMessenger(context);
                                    }
                                  } else {
                                    showMessenger(context);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
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

  void initializeBlocs(List<ItemModel> items) {
    //Convert string to enum
    for (var item in items) {
      isError[item.index] = isError[item.index] ?? false;

      isRequired[item.index] = (isRequired[item.index] ?? item.isRequired);

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
          customDropBloc[item.index] = CustomDropButtonBloc();

        // thiếu pick image, widget question
        case null:
          break;
      }
    }
  }

  bool checkTextControllers(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in textEditControllers.entries) {
      final key = entry.key;
      final controller = entry.value;
      print("controller ${controller.text}");
      if ((controller.text.isEmpty || controller.text == "") &&
          isRequired[key] == true) {
        isError[key] = true;
        isValid = false;
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = controller.text;
        // print("result ${postEntity.items[key].result![0]}");
      }
    }
    return isValid;
  }

  bool checkRadioButtonsBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in radioButtonsBloc.entries) {
      final key = entry.key;
      final radioButtonsBloc = entry.value;
      if (radioButtonsBloc is RadioButtonBloc) {
        final String? values = radioButtonsBloc.values;
        print("submit values radio is $values");
        if (values == null && isRequired[key] == true) {
          radioButtonsBloc.validate("");
          isError[key] = true;
          isValid = false;
        } else {
          isError[key] = false;
          postEntity.items[key].result ??= [""];
          postEntity.items[key].result![0] = values ?? "";
        }
      }
    }
    return isValid;
  }

  bool checkCheckBoxBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in checkBoxBloc.entries) {
      final key = entry.key;
      final checkBoxBloc = entry.value as CheckboxButtonBloc;
      final List<String> values = checkBoxBloc.getValue();
      print("submit value checkbox is  $values");
      if (isRequired[key] == true && values == []) {
        isError[key] = true;
        checkBoxBloc.validate(["error"]);
        isValid = false;
        print(checkBoxBloc.state);
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result = values;
      }
    }
    return isValid;
  }

  bool checkCustomDropBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in customDropBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as CustomDropButtonBloc;
      final String value = bloc.state.isSelected;
      print("submit value drop button is  $value");
      if (value.isEmpty && isRequired[key] == true) {
        bloc.validate('');
        bloc.state.isError = true;
        isValid = false;
      } else {
        bloc.state.isError = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = value;
      }
    }
    return isValid;
  }

  bool checkTimePickerBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in timePickerBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as TimePickerCustomBloc;
      final String? value = bloc.getState;
      print("submit Time picker $value");
      if ((value?.isEmpty ?? true) && isRequired[key] == true) {
        isError[key] = true;
        bloc.changeValue("false");
        isValid = false;
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = value.toString();
      }
    }
    return isValid;
  }

  bool checkDatePickerBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in datePickerBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as DatePickerBloc;
      final DateTime? value = bloc.getValue;
      print("submit date picker is $value");
      if (value == null && isRequired[key] == true) {
        bloc.validate(null);
        isError[key] = true;
        isValid = false;
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = value.toString();
      }
    }
    return isValid;
  }
}
