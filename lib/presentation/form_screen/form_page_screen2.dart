import 'package:dsoft_form_application/core/styles/app_examples.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/checkbox_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/checkbox_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/checkbox_question_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/checkbox_question_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/custom_drop_button_bloc.dart';

import 'package:dsoft_form_application/presentation/form_screen/component/date_picker.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/date_picker_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/pick_image_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/radio_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/radio_question_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_question_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/share_container.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/custom_drop_button_.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/zzztext_field_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/zzztext_field_customs.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/time_picker_custom.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/time_picker_custom_bloc.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'component/pick_image.dart';

class FormPageScreen2 extends StatelessWidget {
  FormPageScreen2({Key? key, required this.post}) : super(key: key);
  final DateTime? datePicker = null;

  final List<bool> listValid = List.filled(10, false);

  final PostsModel post;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const SharedAppBar(title: "Đăng ký tham gia giải bóng đá D-Soft"),
      backgroundColor: const Color(0xFFf7f7f7),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // BlocProvider(
                //   create: (context) => TextFieldBLoc(),
                //   child: BlocBuilder<TextFieldBLoc, TextFieldState>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (true) {
                //         if (isValid is TextFieldValid) {
                //           listValid[0] = true;
                //         }
                //         if (isValid is TextFieldInValid ||
                //             isValid is TextFieldInit) {
                //           listValid[0] = false;
                //         }
                //       } else {
                //         listValid[0] = true;
                //       }
                //       return ShareContainer(
                //         widget: TextFieldCustoms(
                //           maxLine: 1,
                //           onChanged: (value) {
                //             context.read<TextFieldBLoc>().validate(value);
                //           },
                //           isError: isValid is TextFieldInit
                //               ? false
                //               : isValid is TextFieldValid
                //                   ? false
                //                   : true,
                //           isRequest: true,
                //         ),
                //         title: "Họ tên",
                //         isRequest: true,
                //       );
                //     },
                //   ),
                // ),
                // BlocProvider(
                //   create: (context) => TextFieldBLoc(),
                //   child: BlocBuilder<TextFieldBLoc, TextFieldState>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (false) {
                //         if (isValid is TextFieldValid) {
                //           listValid[0] = true;
                //         }
                //         if (isValid is TextFieldInValid ||
                //             isValid is TextFieldInit) {
                //           listValid[0] = false;
                //         }
                //       } else {
                //         listValid[1] = true;
                //       }
                //       return ShareContainer(
                //         widget: TextFieldCustoms(
                //           maxLine: 5,
                //           onChanged: (value) {
                //             context.read<TextFieldBLoc>().validate(value);
                //           },
                //           isError: isValid is TextFieldInit
                //               ? false
                //               : isValid is TextFieldValid
                //                   ? false
                //                   : true,
                //           // isRequest: true, //test
                //         ),
                //         title:
                //             "Chia sẻ cảm nhận của bạn về giải bóng đá năm nay",
                //       );
                //     },
                //   ),
                // ),

                //TODO
                // BlocProvider(
                //   create: (context) => RadioButtonBloc(),
                //   child: BlocBuilder<RadioButtonBloc, bool>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (false) {
                //         listValid[2] = isValid;
                //       } else {
                //         listValid[2] = true;
                //       }
                //       return ShareContainer(
                //         widget: RadioButton(
                //           listRadio: AppExamples.listRadio,
                //           nameGroup: "to-chuc",
                //           onChanged: (value) {
                //             context
                //                 .read<RadioButtonBloc>()
                //                 .Validate(value as String);
                //           },
                //           isError: isValid == true ? false : true,
                //           // isRequest: true, // test
                //         ),
                //         textInputControl: null,
                //         title:
                //             "Bạn đánh giá mức độ tổ chức giải đấu năm nay như thế nào?",
                //       );
                //     },
                //   ),
                // ),
                // BlocProvider(
                //   create: (context) => CheckboxButtonBloc(),
                //   child: BlocBuilder<CheckboxButtonBloc, bool>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (false) {
                //         listValid[3] = isValid;
                //       } else {
                //         listValid[3] = true;
                //       }
                //       return ShareContainer(
                //         widget: CheckboxButton(
                //           listCheckbox: AppExamples.listCheckBox,
                //           onChanged: (value) {
                //             context.read<CheckboxButtonBloc>().validate(value);
                //           },
                //           // isRequest: true, //test
                //           isError: isValid == true ? false : true,
                //         ),
                //         title:
                //             "Những yếu tố nào dưới đây bạn nghĩ cần được cải thiện cho giải đấu năm sau? (Chọn nhiều đáp án nếu cần)",
                //       );
                //     },
                //   ),
                // ),
                // BlocProvider(
                //   create: (context) => CustomDropButtonBloc(),
                //   child: BlocBuilder<CustomDropButtonBloc, bool>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (true) {
                //         listValid[4] = isValid;
                //       } else {
                //         listValid[4] = true;
                //       }
                //       return ShareContainer(
                //         widget: CustomDropButton(
                //           listDropDown: AppExamples.listDropDown,
                //           onChanged: (value) {
                //             context
                //                 .read<CustomDropButtonBloc>()
                //                 .Validate(value);
                //           },
                //           isError: isValid == true ? false : true,
                //           isRequest: true,
                //         ),
                //         title: "Bạn đã tham gia vào vai trò nào trong giải đấu",
                //         isRequest: true,
                //       );
                //     },
                //   ),
                // ),
                BlocProvider(
                  create: (context) => PickImageBloc(),
                  child: BlocBuilder<PickImageBloc, bool>(
                    builder: (context, isValid) {
                      // if (isRequest = true)
                      if (false) {
                        listValid[5] = isValid;
                      } else {
                        listValid[5] = true;
                      }
                      return ShareContainer(
                        widget: PickImage(
                          isError: isValid == true ? false : true,
                          // isRequest: true, //test
                          onChanged: (value) {
                            context.read<PickImageBloc>().validate(value);
                          },
                        ),
                        title:
                            "Vui lòng tải lên hình ảnh hoặc video bạn muốn chia sẻ về giải đấu",
                      );
                    },
                  ),
                ),
                BlocProvider(
                  create: (context) => RadioQuestionButtonBloc(),
                  child: ShareContainer(
                    widget: RadioQuestionButton(
                      isRequest: true,
                      listQuestion: AppExamples.listQuestions,
                      onChanged: (value) {
                        if (value = true) {
                          listValid[6] = value;
                        } else {
                          listValid[6] = true;
                        }
                      },
                    ),
                    title: "Đánh giá các khía cạnh sau của giải đấu",
                    isRequest: true,
                  ),
                ),
                BlocProvider(
                  create: (context) => CheckboxQuestionButtonBloc(),
                  child: ShareContainer(
                    widget: CheckboxQuestionButton(
                      isRequest: true,
                      listCheckBox: AppExamples.listCheckBoxQuestions,
                      // onChanged: (value) {
                      //   //TODO fix that isRequested
                      //   // if (isRequest = true)
                      //   if (true) {
                      //     listValid[7] = false;
                      //   } else {
                      //     listValid[7] = true;
                      //   }
                      // },
                    ),
                    title:
                        "Bạn đã tham gia vào những sự kiện nào trong khuôn khổ giải đấu?(Chọn tất cả những gì áp dụng)",
                  ),
                ),
                // // BlocProvider(
                // //   create: (context) => DatePickerBloc(),
                // //   child: BlocBuilder<DatePickerBloc, bool>(
                // //     builder: (context, isValid) {
                // //       // if (isRequest = true)

                // //       if (true) {
                // //         listValid[8] = isValid;
                // //       } else {
                // //         listValid[8] = true;
                // //       }
                // //       return ShareContainer(
                // //         widget: DatePicker(
                // //           isError: isValid ? false : true,
                // //           isRequest: true,
                // //           onChanged: (value) {
                // //             if (value == null) {
                // //               context.read<DatePickerBloc>().Error(false);
                // //             } else {
                // //               context.read<DatePickerBloc>().validate(value);
                // //             }
                // //           },
                // //         ),
                // //         title: "Ngày bạn tham gia trận đấu cuối cùng",
                // //         isRequest: true,
                // //       );
                // //     },
                // //   ),
                // // ),
                // BlocProvider(
                //   create: (context) => TimePickerCustomBloc(),
                //   child: BlocBuilder<TimePickerCustomBloc, bool>(
                //     builder: (context, isValid) {
                //       // if (isRequest = true)
                //       if (false) {
                //         listValid[9] = isValid;
                //       } else {
                //         listValid[9] = true;
                //       }
                //       return ShareContainer(
                //         widget: TimePickerCustom(
                //           onChanged: (value) {
                //             context
                //                 .read<TimePickerCustomBloc>()
                //                 .validate(value);
                //           },
                //           isError: isValid ? false : true,
                //           // isRequest: true, //test
                //           title: ("Chọn giờ"),
                //         ),
                //         title:
                //             "Vui lòng nhập giờ mà bạn có mặt tại sân vào trận đấu cuối cùng",
                //       );
                //     },
                //   ),
                // ),
                const Gap(50)
              ],
            ),
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
