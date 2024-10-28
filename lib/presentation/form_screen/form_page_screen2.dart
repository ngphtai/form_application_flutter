import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/core/styles/app_examples.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/checkbox_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/checkbox_question_button.dart';

import 'package:dsoft_form_application/presentation/form_screen/compoment/date_picker.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/radio_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/radio_question_button.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/share_container.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/custom_drop_button_.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/time_picker_custom.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'compoment/pick_image.dart';

// ignore: must_be_immutable
class FormPageScreen2 extends StatelessWidget {
  FormPageScreen2({Key? key}) : super(key: key);
  final DateTime? datePicker = null;

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
                ShareContainer(
                  widget: Container(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xfff4f4f4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.fromBorderSide(
                          BorderSide(color: Color(0xffe8e8e8), width: 1)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Lựa chọn",
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  title: "Họ tên",
                  isRequest: true,
                ),
                ShareContainer(
                  widget: Container(
                    padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                    decoration: const BoxDecoration(
                      color: Color(0xfff4f4f4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.fromBorderSide(
                          BorderSide(color: Color(0xffe8e8e8), width: 1)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Lựa chọn",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 10)),
                      maxLines: 5,
                    ),
                  ),
                  title: "Chia sẻ cảm nhận của bạn về giải bóng đá năm nay",
                ),
                ShareContainer(
                  widget: RadioButton(
                    listRadio: AppExamples.listRadio,
                    nameGroup: "to-chuc",
                    onChanged: (value) {},
                  ),
                  textInputControl: null,
                  title:
                      "Bạn đánh giá mức độ tổ chức giải đấu năm nay như thế nào?",
                ),
                ShareContainer(
                  widget: CheckboxButton(
                      listCheckbox: AppExamples.listCheckBox,
                      onChanged: (value) {}),
                  title:
                      "Những yếu tố nào dưới đây bạn nghĩ cần được cải thiện cho giải đấu năm sau? (Chọn nhiều đáp án nếu cần)",
                ),
                ShareContainer(
                  widget: CustomDropButton(
                    listDropDown: AppExamples.listDropDown,
                    // onChanged: (value) {},
                  ),
                  title: "Bạn đã tham gia vào vai trò nào trong giải đấu",
                  isRequest: true,
                ),
                const ShareContainer(
                  widget: PickImage(),
                  title:
                      "Vui lòng tải lên hình ảnh hoặc video bạn muốn chia sẻ về giải đấu",
                ),
                ShareContainer(
                  widget: RadioQuestionButton(
                    listQuestion: AppExamples.listQuestions,
                    onChanged: (value) {},
                  ),
                  title: "Đánh giá các khía cạnh sau của giải đấu",
                  isRequest: true,
                ),
                ShareContainer(
                  widget: CheckboxQuestionButton(
                    listCheckBox: AppExamples.listCheckBoxQuestions,
                    onChanged: (value) {},
                  ),
                  title:
                      "Bạn đã tham gia vào những sự kiện nào trong khuôn khổ giải đấu?(Chọn tất cả những gì áp dụng)",
                ),
                const ShareContainer(
                  widget: DatePicker(),
                  title: "Ngày bạn tham gia trận đấu cuối cùng",
                  isRequest: true,
                ),
                const ShareContainer(
                  widget: TimePickerCustom(
                    title: ("Chọn giờ"),
                  ),
                  title:
                      "Vui lòng nhập giờ mà bạn có mặt tại sân vào trận đấu cuối cùng",
                ),
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
                          context
                              .go('/homePage/detailPage/formPage/successPage');
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
