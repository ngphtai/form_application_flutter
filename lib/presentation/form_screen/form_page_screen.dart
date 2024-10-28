// ignore_for_file: use_super_parameters

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dsoft_form_application/presentation/form_screen/compoment/share_container.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FormPageScreen extends StatefulWidget {
  const FormPageScreen({Key? key}) : super(key: key);

  @override
  _FormPageScreenState createState() => _FormPageScreenState();
}

List<String> list = <String>[
  "Cầu thủ",
  "Cổ động viên",
  "Ban tổ chức",
  "Tài trợ",
  "Trọng tài"
];

class _FormPageScreenState extends State<FormPageScreen> {
  var selectedRadioValues = 1;
  bool isCheck1 = false;
  bool isCheck2 = false;
  bool isCheck3 = false;
  bool isCheck4 = false;
  bool isCheck5 = false;

  String? dropdownValue;

  // FocusNode dropdownFocusNode = FocusNode();
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const SharedAppBar(title: "Đăng ký tham gia giải bóng đá D-Soft"),
      backgroundColor: const Color(0xFFf7f7f7),
      body: Stack(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ShareContainer(
                  widget: Container(
                    color: const Color(0xFFf4f4f4),
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
                  textInputControl: null,
                  title: "Họ tên",
                ),
                ShareContainer(
                  widget: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFf4f4f4),
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
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RadioListTile(
                        title: const Text("Xuất sắc"),
                        value: 1,
                        groupValue: "to-chuc",
                        onChanged: (value) {
                          // selectedRadioValues = value as int;
                        },
                      ),
                      RadioListTile(
                        title: const Text("Tốt"),
                        value: 2,
                        groupValue: "to-chuc",
                        onChanged: (value) {
                          // selectedRadioValues = value as int;
                        },
                      ),
                      RadioListTile(
                        title: const Text("Trung bình"),
                        value: 3,
                        groupValue: "to-chuc",
                        onChanged: (value) {
                          // selectedRadioValues = value as int;
                        },
                      ),
                      RadioListTile(
                        title: const Text("Tệ"),
                        value: 4,
                        groupValue: "to-chuc",
                        onChanged: (value) {
                          // selectedRadioValues = value as int;
                        },
                      ),
                    ],
                  ),
                  textInputControl: null,
                  title:
                      "Bạn đánh giá mức độ tổ chức giải đấu năm nay như thế nào?",
                ),
                ShareContainer(
                  widget: Container(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          value: false,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            // isCheck1 = true;
                          },
                          title: const Text("Chất lượng sân bãi"),
                        ),
                        CheckboxListTile(
                          value: false,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            // isCheck2 = true;
                          },
                          title: const Text("Thời gian tổ chức"),
                        ),
                        CheckboxListTile(
                          value: false,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            // isCheck3 = true;
                          },
                          title: const Text("Ban tổ chức"),
                        ),
                        CheckboxListTile(
                          value: false,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            // isCheck4 = true;
                          },
                          title: const Text("Phần thưởng"),
                        ),
                        CheckboxListTile(
                          value: false,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            // isCheck5 = true;
                          },
                          title: const Text("Đội ngũ trọng tài"),
                        ),
                      ],
                    ),
                  ),
                  title:
                      "Những yếu tố nào dưới đây bạn nghĩ cần được cải thiện cho giải đấu năm sau? (Chọn nhiều đáp án nếu cần)",
                ),
                ShareContainer(
                  widget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: isFocused
                            ? Colors.red
                            : Colors
                                .grey, // Viền xám khi chưa chọn, viền đỏ khi chọn
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        // focusNode:
                        //     dropdownFocusNode, // Gán focusNode cho DropdownButton
                        value: dropdownValue,
                        isExpanded: true,
                        //HINT TEXT
                        hint: const Text(
                          "Lựa chọn",
                          style: TextStyle(color: Colors.grey),
                        ),

                        iconStyleData: const IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down)),

                        dropdownStyleData: DropdownStyleData(
                            width: size.width * 0.9,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color(0xff4f4f4f4))),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),

                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            // if (newValue == null) isFocused = false;
                          });
                        },
                      ),
                    ),
                  ),
                  title: "Bạn đã tham gia vào vai trò nào trong giải đấu",
                ),
                // //TODO pick file
                ShareContainer(
                  widget: widget,
                  title:
                      "Vui lòng tải lên hình ảnh hoặc video bạn muốn chia sẻ về giải đấu",
                ),
                ShareContainer(
                  widget: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color(0xFFf4f4f4f4)),
// child: ,
                  ),
                  title: "Ngày bạn tham gia trận đấu cuối cùng",
                ),
                const Gap(50)
              ],
            ),
          )),

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
                                  fontWeight: FontWeight.w600),
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
