import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/custom_drop_button_bloc.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton({
    Key? key,
    required this.listDropDown,
    this.isRequest = false,
    required this.customDropButtonBloc,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomDropButtonState createState() => _CustomDropButtonState();
  final List<String> listDropDown;
  final bool? isRequest;
  final TextEditingController controller;
  final CustomDropButtonBloc customDropButtonBloc;
}

class _CustomDropButtonState extends State<CustomDropButton>
    with AutomaticKeepAliveClientMixin {
  String? selectedValue;
  bool isDropdownVisible = false;
  bool isClose = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // main
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => widget.customDropButtonBloc,
        child: BlocBuilder<CustomDropButtonBloc, CustomDropButtonState>(
            builder: (context, state) {
          // handle get answer and set answer to default
          if (widget.controller.text.isNotEmpty && !isClose) {
            String value = widget.controller.text;
            context.read<CustomDropButtonBloc>().validate(value);
            selectedValue = value;
            isClose = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDropdownVisible = !isDropdownVisible;
                  });
                  context.read<CustomDropButtonBloc>().validate("");
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.isRequest == true
                            ? !state.isError
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
                    border:
                        Border.all(color: const Color(0xffe8e8e8), width: 1),
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
                            if (selectedValue != null) {
                              state.isError = false;
                            } else if (selectedValue == null) {
                              state.isError = true;
                            }
                            print(selectedValue);
                            context
                                .read<CustomDropButtonBloc>()
                                .validate(selectedValue!);
                          });
                        },
                        child: Container(
                          width: size.width,
                          margin: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 8),
                          child: Text(item),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
