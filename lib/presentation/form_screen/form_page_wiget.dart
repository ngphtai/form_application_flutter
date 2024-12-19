import 'dart:io';
import 'package:dsoft_form_application/common/extensions/url_conver.dart';
import 'package:dsoft_form_application/shared/widget/dialog_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/common/extensions/conver_string_to_enum.dart';
import '/common/logger/app_logger.dart';
import '/data/model/entities/post_model_entity.dart';
import '/presentation/form_screen/component/bloc/checkbox_button_bloc.dart';
import '/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import '/presentation/form_screen/component/bloc/text_field_bloc.dart';
import '/presentation/form_screen/component/screen/form_widget.dart';
import '/presentation/form_screen/component/screen/loading_widget.dart';
import '/presentation/form_screen/component/screen/submit_button_widget.dart';
import '../../domain/models/item_model.dart';
import '../detail_screen/bloc/detail_page_bloc.dart';
import 'bloc/form_page_bloc.dart';
import 'component/bloc/custom_drop_button_bloc.dart';
import '../../core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../common/enums/form_page_enums.dart';
import 'component/bloc/date_picker_bloc.dart';
import 'component/bloc/rating_bloc.dart';
import 'component/bloc/time_picker_custom_bloc.dart';
import 'component/screen/check_bloc.dart';
import 'component/screen/form_app_bar.dart';
import 'component/screen/form_snake_bar.dart';
import 'component/screen/show_popup_loading.dart';

// ignore: must_be_immutable
class ReviewFormPageWidget extends StatelessWidget {
  ReviewFormPageWidget({super.key, required this.postId});
  final DateTime? datePicker = null;
  final String postId;
  bool checkValidToSubmit = true;
  bool blocAlreadyInit = false;
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
  Map<int, Cubit> ratingBloc = {};
  List<ItemModel>? answers;
  bool isHaveValid = false;
  String title = "";

  @override
  Widget build(BuildContext context) {
    String? currentRoute = GoRouterState.of(context).name;
    final ScrollController scrollController = ScrollController();
    context.select<DetailPageBloc, String>(
      (bloc) {
        final state = bloc.state;
        if (state is DetailPageLoaded) {
          title = state.post.metaData.title;
        }
        return state is DetailPageLoaded ? title : ". . .";
      },
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) return;
        await onPop(context, currentRoute ?? "");
      },
      child: SafeArea(
        top: false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: formAppBar(context, currentRoute, onPop, title),
          backgroundColor: const Color(0xFFf7f7f7),
          body: Stack(
            children: [
              BlocBuilder<DetailPageBloc, DetailPageState>(// load post detail
                  builder: (context, state) {
                if (state is DetailPageInitial) {
                  final bloc = context.read<DetailPageBloc>();
                  switch (currentRoute) {
                    case Routers.formPage:
                      bloc.add(LoadDetailPost(postId));
                      break;
                    case Routers.reviewFormPage:
                      bloc.add(LoadDetailPostLocal(postId));
                      break;
                    default:
                      break;
                  }
                  return const LoadingWidget();
                }
                if (state is DetailPageLoaded) {
                  if (!blocAlreadyInit) {
                    initializeBlocs(state.post.itemModels);
                    blocAlreadyInit = true;
                  }
                  return BlocBuilder<FormPageBloc, FormPageState>(
                      // load answer
                      builder: (context, stateAnswers) {
                    if (stateAnswers is FormPageInitial) {
                      String idMetaDataPost = state.post.metaData.id;
                      context
                          .read<FormPageBloc>()
                          .add(LoadAnswerLocal(idMetaDataPost));
                    }
                    if (stateAnswers is FormPageLoaded &&
                        currentRoute == Routers.reviewFormPage) {
                      List<ItemModel>? answers =
                          stateAnswers.post?.itemModels ?? [];
                      // lấy kết quả đã điền
                      if (answers.isNotEmpty) {
                        answersControllers.forEach((key, value) {
                          if (answers[key].result != null &&
                              answers[key].result!.isNotEmpty) {
                            int length = answers[key].result?.length ?? 0;
                            if (length > 1) {
                              value.text = answers[key].result.toString();
                            } else {
                              value.text = answers[key].result![0];
                            }
                          }
                        });
                      }
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.05.sh),
                            child: ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: state.post.itemModels.length + 1,
                              itemBuilder: (context, index) {
                                if (index == state.post.itemModels.length) {
                                  return Container(
                                    height: 0.02.sh,
                                    color: Colors.transparent,
                                  );
                                }
                                return AbsorbPointer(
                                  absorbing:
                                      currentRoute == Routers.reviewFormPage
                                          ? true
                                          : false,
                                  child: FormWidget(
                                    key: ValueKey(index),
                                    textFieldsBloc: textFieldsBloc,
                                    answersControllers: answersControllers,
                                    radioButtonsBloc: radioButtonsBloc,
                                    checkBoxBloc: checkBoxBloc,
                                    customDropBloc: customDropBloc,
                                    timePickerBloc: timePickerBloc,
                                    isError: isError,
                                    datePickerBloc: datePickerBloc,
                                    state: state,
                                    index: index,
                                    ratingBloc: ratingBloc,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  });
                }
                return const Text("");
              }),
              //Button action
              if (currentRoute != Routers.reviewFormPage)
                BlocBuilder<FormPageBloc, FormPageState>(
                  builder: (context, formState) {
                    final bloc = context.read<FormPageBloc>();
                    return BlocBuilder<DetailPageBloc, DetailPageState>(
                      builder: (context, detailState) {
                        return Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                color: const Color(0xFFffffff),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BlocListener<FormPageBloc, FormPageState>(
                                      listener: (context, state) {
                                        AppLogger.instance.d(state.toString());
                                        if (state is FormPageSaveSuccess) {
                                          String baseUrl =
                                              "/homePage/detailPage/$postId/formPage/successPage";
                                          final param = {
                                            "title": title,
                                          };
                                          final url = baseUrl.toUrl(param);
                                          context.go(url);
                                        } else if (state
                                            is FormPageSaveGoogleSheetFailed) {
                                          String baseUrl =
                                              "/homePage/detailPage/$postId/formPage/failPage";
                                          context.go(baseUrl, extra: title);
                                        }
                                      },
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (detailState is DetailPageLoaded) {
                                            final PostModelEntity postEntity =
                                                detailState.post.toEntity();
                                            checkValidForEachElementInForm(
                                                postEntity);
                                            // Hiển thị thông báo dựa trên kết quả
                                            if (checkValidToSubmit) {
                                              showDiaLogLoading(context);
                                              // save to google form
                                              bloc.add(SaveAnswerToGoogleSheet(
                                                  (postEntity)));
                                            } else {
                                              showMessenger(
                                                  context, checkValidToSubmit);
                                            }
                                          }
                                          await FirebaseAnalytics.instance
                                              .logEvent(
                                                  name: "tap_submit_button");
                                        },
                                        child:
                                            const SubmitButtonWidget(), // interface button
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
        ),
      ),
    );
  }

  Future<void> onPop(BuildContext context, String currentRouter) async {
    if (currentRouter == Routers.formPage) {
      final check = await checkValidWhenGetOutAnyTime();
      // ignore: unrelated_type_equality_checks
      if (check == true) {
        // ignore: use_build_context_synchronously
        final result = await showDiaLogToExist(context);
        if (result == true) {
          // ignore: use_build_context_synchronously
          context.pop(context);
        }
      } else {
        // ignore: use_build_context_synchronously
        context.pop(context);
      }
    } else {
      context.pop(context);
    }
  }

  // check validate in form
  void checkValidForEachElementInForm(PostModelEntity postEntity) {
    postEntity.metaData.updateAt = DateTime.now();
    final List<bool> listValid = List.filled(7, true);
    listValid[0] = checkTextFieldsBloc(postEntity);
    listValid[1] = checkRadioButtonsBloc(postEntity);
    listValid[2] = checkCheckBoxBloc(postEntity);
    listValid[3] = checkCustomDropBloc(postEntity);
    listValid[4] = checkTimePickerBloc(postEntity);
    listValid[5] = checkDatePickerBloc(postEntity);
    listValid[6] = checkRatingBloc(postEntity);
    checkValidToSubmit = true;
    for (var element in listValid) {
      if (element == false) {
        checkValidToSubmit = false;
        break;
      }
    }
  }

  // Khởi tạo các mảng chứa các giá trị bloc và controller
  void initializeBlocs(List<ItemModel> items) {
    for (var item in items) {
      //Convert string to enum
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
        case FormType.RATING:
          ratingBloc[item.index] = RatingBloc();
          break;
        case null:
          break;
      }
    }
  }

  bool checkTextFieldsBloc(PostModelEntity postEntity) {
    return checkBloc<TextFieldBloc>(
      blocMap: textFieldsBloc,
      postEntity: postEntity,
      validateBloc: (bloc, key) {
        bloc = bloc as TextFieldBloc;
        return bloc.value != null || isRequired[key] != true;
      },
      handleError: (bloc, _) {
        bloc = bloc as TextFieldBloc;
        return bloc.setError();
      },
      getValue: (bloc) => (bloc as TextFieldBloc).value,
    );
  }

  bool checkRadioButtonsBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in radioButtonsBloc.entries) {
      final key = entry.key;
      final radioButtonsBloc = entry.value;
      if (radioButtonsBloc is RadioButtonBloc) {
        final String? values = radioButtonsBloc.value;
        AppLogger.instance.i("submit values radio is $values");
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
      AppLogger.instance.i("submit value checkbox is  $values");
      if (isRequired[key] == true && values.isEmpty) {
        checkBoxBloc.setError();
        isValid = false;
        AppLogger.instance.i(checkBoxBloc.state.toString());
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result = values;
      }
    }
    return isValid;
  }

  bool checkCustomDropBloc(PostModelEntity postEntity) {
    return checkBloc<CustomDropButtonBloc>(
      blocMap: customDropBloc,
      postEntity: postEntity,
      validateBloc: (bloc, key) {
        bloc = bloc as CustomDropButtonBloc;
        return bloc.getValue != null || isRequired[key] != true;
      },
      handleError: (bloc, _) {
        bloc = bloc as CustomDropButtonBloc;
        return bloc.isError();
      },
      getValue: (bloc) => (bloc as CustomDropButtonBloc).getValue,
    );
  }

  bool checkTimePickerBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in timePickerBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as TimePickerCustomBloc;
      final String? value = bloc.getTime;
      AppLogger.instance.i("submit Time picker $value");
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
      AppLogger.instance.i("submit date picker is $value");
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

  bool checkRatingBloc(PostModelEntity postEntity) {
    bool isValid = true;
    for (var entry in ratingBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as RatingBloc;
      final int? value = bloc.value;
      AppLogger.instance.i("submit rating is $value");
      if (value == null && isRequired[key] == true) {
        bloc.setError();
        isValid = false;
      } else {
        isError[key] = false;
        postEntity.items[key].result ??= [""];
        postEntity.items[key].result![0] = value.toString();
      }
    }
    return isValid;
  }

  Future<bool> checkValidWhenGetOutAnyTime() {
    for (var entry in textFieldsBloc.entries) {
      final bloc = entry.value as TextFieldBloc;
      if (bloc.value != null) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in radioButtonsBloc.entries) {
      final bloc = entry.value as RadioButtonBloc;
      if (bloc.value != null) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in customDropBloc.entries) {
      final bloc = entry.value as CustomDropButtonBloc;

      if (bloc.isSelected != null) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in checkBoxBloc.entries) {
      final bloc = entry.value as CheckboxButtonBloc;
      if (bloc.values.isNotEmpty) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in timePickerBloc.entries) {
      final bloc = entry.value as TimePickerCustomBloc;
      if (bloc.getTime != "") {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in datePickerBloc.entries) {
      final bloc = entry.value as DatePickerBloc;
      if (bloc.getValue != null) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    for (var entry in ratingBloc.entries) {
      final bloc = entry.value as RatingBloc;
      if (bloc.value != null) {
        isHaveValid = true;
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}
