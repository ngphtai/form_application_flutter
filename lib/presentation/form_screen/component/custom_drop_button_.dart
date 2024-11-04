import 'package:flutter/material.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton(
      {Key? key,
      required this.listDropDown,
      this.isRequest = false,
      required this.isError,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomDropButtonState createState() => _CustomDropButtonState();
  final List<String> listDropDown;
  final bool? isRequest;
  final bool isError;
  final ValueChanged onChanged;
}

class _CustomDropButtonState extends State<CustomDropButton> {
  String? selectedValue;

  bool isDropdownVisible = false;

  // void _showOptionsBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     // sheet select
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             for (String item in widget.listDropDown)
  //               ListTile(
  //                 title: Text(item),
  //                 onTap: () {
  //                   setState(() {
  //                     selectedValue = item;
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // main
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownVisible = !isDropdownVisible;
            });
            widget.onChanged("");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.isRequest == true
                      ? !widget.isError
                          ? const Color(0xffe8e8e8)
                          : Colors.red
                      : const Color(0xffe8e8e8),
                  width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? 'Lựa chọn',
                  style: TextStyle(
                      color: selectedValue == null
                          ? const Color(0xff8C8C8C)
                          : Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Icon(isDropdownVisible
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: isDropdownVisible,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffe8e8e8), width: 1),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFf4f4f4),
            ),
            child: Column(
              children: widget.listDropDown.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      isDropdownVisible = false;
                    });
                    widget.onChanged(selectedValue); // check valid in here
                  },
                  child: Container(
                    width: size.width,
                    margin: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    child: Text(item),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
