import 'package:dsoft_form_application/core/styles/app_icons.dart';

import '../../core/styles/app_text_style.dart';
import '../../shared/widget/share_app_bar.dart';
import '/common/extensions/conver_string_to_enum.dart';
import '/common/logger/app_logger.dart';
import '/data/model/entities/post_model_entity.dart';
import '/presentation/form_screen/component/bloc/checkbox_button_bloc.dart';
import '/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import '/presentation/form_screen/component/bloc/text_field_bloc.dart';
import '/presentation/form_screen/component/screen/form_widget.dart';
import '/presentation/form_screen/component/screen/loading_widget.dart';
import '/presentation/form_screen/component/screen/submit_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
import 'component/screen/text_button.dart';

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

  @override
  Widget build(BuildContext context) {
    String? currentRoute = GoRouterState.of(context).name;
    return Scaffold(
      appBar: SharedAppBar(
        isForm: true,
        isReviewForm: currentRoute == Routers.reviewFormPage ? true : false,
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
              return BlocBuilder<FormPageBloc, FormPageState>(// load answer
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.post.itemModels.length,
                        itemBuilder: (context, index) {
                          return FormWidget(
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
                          );
                        },
                      ),
                    ),
                    if (currentRoute != Routers.reviewFormPage)
                      SizedBox(
                        height: 0.1.sh,
                      )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // ReturnButtonWidget(size: size), // button return
                                  BlocListener<FormPageBloc, FormPageState>(
                                    listener: (context, state) {
                                      if (state
                                          is FormPageSaveGoogleSheetSuccess) {
                                        String baseUrl = currentRoute ==
                                                Routers.formPage
                                            ? "/homePage/detailPage/$postId/formPage/successPage"
                                            : '/historyPage/detailPage/$postId/formPage/successPage';
                                        context.go(baseUrl);
                                      }
                                    },
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (state is DetailPageLoaded) {
                                          final PostModelEntity postEntity =
                                              state.post.toEntity();
                                          checkValidForEachElementInForm(
                                              postEntity);
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
                                            //        Map<String, dynamic> queryParams = {
                                            //   "title": state.post.metaData.title,
                                            //   "title2": state.post.metaData
                                            //       .confirmationMessage,
                                            //   "content": state.post.metaData
                                            //       .customClosedFormMessage
                                            // }; // handle with custom messange
                                            // String url = baseUrl.toUrl(queryParams);
                                            showDiaLogLoading(context);
                                          } else {
                                            showMessenger(context);
                                          }
                                        }
                                      },
                                      child:
                                          const SubmitButtonWidget(), // interface button
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10.h),
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
  void checkValidForEachElementInForm(PostModelEntity postEntity) {
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

// hiển thị thông báo gửi
  void showMessenger(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(checkValidToSubmit
            ? "Đã lưu thành công"
            : "Vui lòng điền đầy đủ thông tin"),
        backgroundColor:
            checkValidToSubmit ? Colors.green : const Color(0xffdb1e39),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
    bool isValid = true;
    for (var entry in textFieldsBloc.entries) {
      final key = entry.key;
      final textFieldBloc = entry.value as TextFieldBloc;
      final String? values = textFieldBloc.value;
      AppLogger.instance.i("submit values text field is $values");
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
    bool isValid = true;
    for (var entry in customDropBloc.entries) {
      final key = entry.key;
      final bloc = entry.value as CustomDropButtonBloc;
      final String value = bloc.state.isSelected;
      AppLogger.instance.i("submit value drop button is  $value");
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

  Future<dynamic> showDiaLogLoading(BuildContext originContext) {
    return showDialog(
        context: originContext,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 1.sw,
                height: 0.3.sh,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 100.w,
                        width: 100.w,
                        child: LoadingIndicator(
                            indicatorType: Indicator.circleStrokeSpin,
                            colors: const [Color(0xffdb1e39)],
                            strokeWidth: 4.0,
                            pathBackgroundColor: Colors.red[200],
                            backgroundColor: Colors.white),
                      ),
                    ]),
              ),
            ));
  }

  Future<dynamic> showDiaLog(BuildContext originContext) {
    return showDialog(
        context: originContext,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 1.sw,
                height: 0.3.sh,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(10),
                      Image.asset(
                        AppIcons.warning,
                        height: 60,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                      const Gap(10),
                      Text(
                        "Cảnh báo",
                        style: AppTextStyle.bold20,
                      ),
                      const Gap(10),
                      Text(
                        "Mọi thay đổi sẽ không được lưu.",
                        style:
                            AppTextStyle.regular14.copyWith(color: Colors.grey),
                      ),
                      Text(
                        "Bạn có chắc muốn thoát không?",
                        style:
                            AppTextStyle.regular14.copyWith(color: Colors.grey),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              originContext.pop();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(55, 10, 55, 10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFffffff),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                border: Border.all(
                                  color: const Color(0xffdb1e39),
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                  child: TextButtonCustom(
                                      text: "Huỷ", color: Color(0xffdb1e39))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              GoRouter.of(originContext).go(Routers.homePage);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(55, 10, 55, 10),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xffdb1e39),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: const Color(0xffdb1e39),
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                  child: TextButtonCustom(
                                      text: "Thoát", color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ));
  }
}
