import 'package:dsoft_form_application/common/extensions/conver_string_to_enum.dart';
import 'package:dsoft_form_application/common/extensions/url_conver.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/checkbox_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/text_field_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/form_widget.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/loading_widget.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/return_button_widget.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/submit_button_widget.dart';
import '../../domain/models/item_model.dart';
import '../detail_screen/bloc/detail_page_bloc.dart';
import 'bloc/form_page_bloc.dart';
import 'component/bloc/custom_drop_button_bloc.dart';
import '../../core/routing/route_path.dart';
import '../../shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../common/enums/form_page_enums.dart';
import 'component/bloc/date_picker_bloc.dart';
import 'component/bloc/time_picker_custom_bloc.dart';

// ignore: must_be_immutable
class FormPageWidget extends StatelessWidget {
  FormPageWidget({super.key, required this.postId});
  final DateTime? datePicker = null;
  final int postId;
  bool checkValidToSubmit = true;
  // khai báo danh sách bloc
  Map<int, TextEditingController> answersControllers = {};
  Map<int, bool?> isRequired = {};
  Map<int, bool> isError = {};
  Map<int, Cubit> textFieldsBloc = {};
  Map<int, Cubit> radioButtonsBloc = {};
  Map<int, Cubit> customDropBloc = {};
  Map<int, Cubit> checkBoxBloc = {};
  Map<int, Cubit> radioQuestionBloc = {};
  Map<int, Cubit> pickImageBloc = {};
  Map<int, Cubit> checkboxQuestionBloc = {};
  Map<int, Cubit> datePickerBloc = {};
  Map<int, Cubit> timePickerBloc = {};
  List<ItemModel>? answers;
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
            if (state is DetailPageInitial || state is DetailPageLoading) {
              return const LoadingWidget();
            }
            if (state is DetailPageLoaded) {
              initializeBlocs(state.post.itemModels);
              return BlocBuilder<FormPageBloc, FormPageState>(
                  builder: (context, stateAnswers) {
                if (stateAnswers is FormPageInitial) {
                  String idMetaDataPost = state.post.metaData.id;
                  context
                      .read<FormPageBloc>()
                      .add(LoadAnswerLocal(idMetaDataPost));
                }
                if (stateAnswers is FormPageLoaded &&
                    GoRouterState.of(context).name == Routers.reviewFormPage) {
                  List<ItemModel>? answers = stateAnswers.post?.itemModels;
                  if (answers != null) {
                    answersControllers.forEach((key, value) {
                      if (answers[key].result?[0] != null) {
                        int length = answers[key].result?.length ?? 0;
                        if (length > 1) {
                          value.text = answers[key].result.toString();
                        } else {
                          value.text = answers[key].result?[0] ?? "";
                        }
                      }

                      print(value.text);
                    });
                  }
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.post.itemModels.length,
                        itemBuilder: (context, index) {
                          return FormWidget(
                              textFieldsBloc: textFieldsBloc,
                              answersControllers: answersControllers,
                              radioButtonsBloc: radioButtonsBloc,
                              checkBoxBloc: checkBoxBloc,
                              customDropBloc: customDropBloc,
                              timePickerBloc: timePickerBloc,
                              isError: isError,
                              datePickerBloc: datePickerBloc,
                              state: state,
                              index: index);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                  // );
                ); // xoá o day
              });
            }
            return const Text("");
          }),
          //Button action
          BlocBuilder<FormPageBloc, FormPageState>(
            builder: (context, formState) {
              if (formState is FormPageLoading) {
                return const Positioned(
                    bottom: 0, left: 0, right: 0, child: LoadingWidget());
              } else {
                return BlocBuilder<DetailPageBloc, DetailPageState>(
                  builder: (context, state) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            color: const Color(0xFFffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ReturnButtonWidget(size: size), // button return

                                GestureDetector(
                                  // button submit
                                  onTap: () async {
                                    if (state is DetailPageLoaded) {
                                      final PostModelEntity postEntity =
                                          state.post.toEntity();
                                      //check validate form
                                      checkValid(postEntity);
                                      // Hiển thị thông báo dựa trên kết quả
                                      if (checkValidToSubmit) {
                                        //save to local
                                        context
                                            .read<FormPageBloc>()
                                            .add(SaveForm((postEntity)));
                                        // save to google form
                                        context.read<FormPageBloc>().add(
                                            SaveAnswerToGoogleSheet(
                                                (postEntity.toDomain())));
                                        //route to success page
                                        String baseUrl =
                                            "${Routers.homePage}/${Routers.detailPage}/$postId/${Routers.formPage}/${Routers.successPage}";
                                        Map<String, dynamic> queryParams = {
                                          "title": state.post.metaData.title,
                                          "title2": state.post.metaData
                                              .confirmationMessage,
                                          "content": state.post.metaData
                                              .customClosedFormMessage
                                        };
                                        String url = baseUrl.toUrl(queryParams);
                                        context.go(url);

                                        showMessenger(context);
                                      } else {
                                        showMessenger(context);
                                      }
                                    }
                                  },
                                  child: SubmitButtonWidget(
                                      size: size), // interface button
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // check validate in form
  void checkValid(PostModelEntity postEntity) {
    final List<bool> listValid = List.filled(6, true);
    listValid[0] = checkTextFieldsBloc(postEntity);
    listValid[1] = checkRadioButtonsBloc(postEntity);
    listValid[2] = checkCheckBoxBloc(postEntity);
    listValid[3] = checkCustomDropBloc(postEntity);
    listValid[4] = checkTimePickerBloc(postEntity);
    listValid[5] = checkDatePickerBloc(postEntity);
    checkValidToSubmit = true;
    for (var element in listValid) {
      if (element == false) {
        checkValidToSubmit = false;
        break;
      }
    }
  }

// hiển thị thông báo gửi
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

  // Khởi tạo các mảng chứa các giá trị bloc và controller
  void initializeBlocs(List<ItemModel> items) {
    //Convert string to enum
    for (var item in items) {
      isError[item.index] = isError[item.index] ?? false;
      isRequired[item.index] = (isRequired[item.index] ?? item.isRequired);
      FormType? formType = item.type.toFormType();
      answersControllers[item.index] = TextEditingController();
      switch (formType) {
        case FormType.TEXT || FormType.PARAGRAPH_TEXT:
          textFieldsBloc[item.index] = TextFieldBloc();
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
          break;
        // thiếu pick image, widget question
        case null:
          break;
      }
    }
  }

  bool checkTextFieldsBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in textFieldsBloc.entries) {
      final key = entry.key;
      final textFieldBloc = entry.value as TextFieldBloc;
      final String? values = textFieldBloc.value;
      print("submit values radio is $values");
      if (values == null && isRequired[key] == true) {
        textFieldBloc.setError();
        isValid = false;
      } else {
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = values ?? "";
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
        final String? values = radioButtonsBloc.value;
        print("submit values radio is $values");
        if (values == null && isRequired[key] == true) {
          radioButtonsBloc.setError();
          isValid = false;
        } else {
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
      final List<String> values = checkBoxBloc.values;
      print("submit value checkbox is  $values");
      if (isRequired[key] == true && values.isEmpty) {
        checkBoxBloc.setError();
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
