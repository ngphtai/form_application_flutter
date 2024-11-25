import 'package:dsoft_form_application/common/extensions/conver_string_to_enum.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/checkbox_button_bloc.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/date_picker.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/share_container.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/text_field_custom_without_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/enums/form_page_enums.dart';
import '../../../detail_screen/bloc/detail_page_bloc.dart';
import '../bloc/custom_drop_button_bloc.dart';
import '../bloc/date_picker_bloc.dart';
import '../bloc/radio_button_bloc.dart';
import '../bloc/rating_bloc.dart';
import '../bloc/text_field_bloc.dart';
import '../bloc/time_picker_custom_bloc.dart';
import '../checkbox_button.dart';
import '../custom_drop_button_.dart';
import '../radio_button.dart';

import '../rating.dart';
import '../time_picker_custom.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.textFieldsBloc,
    required this.answersControllers,
    required this.radioButtonsBloc,
    required this.checkBoxBloc,
    required this.customDropBloc,
    required this.timePickerBloc,
    required this.isError,
    required this.datePickerBloc,
    required this.state,
    required this.index,
    required this.ratingBloc,
  });

  final Map<int, Cubit> textFieldsBloc;
  final Map<int, TextEditingController> answersControllers;
  final Map<int, Cubit> radioButtonsBloc;
  final Map<int, Cubit> checkBoxBloc;
  final Map<int, Cubit> customDropBloc;
  final Map<int, Cubit> timePickerBloc;
  final Map<int, bool> isError;
  final Map<int, Cubit> datePickerBloc;
  final Map<int, Cubit> ratingBloc;
  final DetailPageLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isRequired = state.post.itemModels[index].isRequired ?? false;

    final item = state.post.itemModels[index];

    //Convert string to enum
    String jsonType = state.post.itemModels[index].type;

    FormType? formType = jsonType.toFormType();

    switch (formType) {
      //simple text
      case FormType.TEXT:
        {
          return ShareContainer(
              widget: TextFieldCustomWithBloc(
                  maxLine: 1,
                  textFieldBloc: textFieldsBloc[index] as TextFieldBloc,
                  textController:
                      answersControllers[item.index] ?? TextEditingController(),
                  isRequest: isRequired),
              title: item.title,
              isRequest: isRequired);
        }
      //multi text
      case FormType.PARAGRAPH_TEXT:
        {
          return ShareContainer(
            widget: TextFieldCustomWithBloc(
                maxLine: 5,
                textFieldBloc: textFieldsBloc[index] as TextFieldBloc,
                textController:
                    answersControllers[item.index] ?? TextEditingController(),
                isRequest: isRequired),
            title: item.title,
            isRequest: isRequired,
          );
        }
      case FormType.MULTIPLE_CHOICE:
        {
          return ShareContainer(
            widget: RadioButton(
              listRadio: item.choices ?? ["câu hỏi bị trống!"],
              nameGroup: item.title,
              isRequest: isRequired,
              radioButtonBloc: radioButtonsBloc[item.index] as RadioButtonBloc,
              controller:
                  answersControllers[item.index] ?? TextEditingController(),
            ),
            textInputControl: null,
            title: item.title,
            isRequest: isRequired,
          );
        }
      case FormType.CHECKBOX:
        {
          return BlocProvider(
            create: (context) => checkBoxBloc[item.index] as CheckboxButtonBloc,
            child: ShareContainer(
              widget: CheckboxButton(
                listCheckbox: item.choices ?? [],
                checkboxButtonBloc:
                    checkBoxBloc[item.index] as CheckboxButtonBloc,
                isRequest: isRequired,
                controller:
                    answersControllers[item.index] ?? TextEditingController(),
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
              title: item.title,
              listDropDown: item.choices ?? [],
              isRequest: isRequired,
              customDropButtonBloc:
                  customDropBloc[item.index] as CustomDropButtonBloc,
              controller:
                  answersControllers[item.index] ?? TextEditingController(),
            ),
            title: item.title,
            isRequest: isRequired,
          );
        }
      case FormType.TIME:
        {
          return BlocProvider<TimePickerCustomBloc>(
              create: (context) =>
                  timePickerBloc[item.index] as TimePickerCustomBloc,
              child: ShareContainer(
                widget: TimePickerCustom(
                  isRequest: true,
                  title: ("Chọn giờ"),
                  timePickerCustomBloc:
                      timePickerBloc[item.index] as TimePickerCustomBloc,
                  controller:
                      answersControllers[item.index] ?? TextEditingController(),
                ),
                title: item.title,
                isRequest: isRequired,
              ));
        }
      case FormType.DATE:
        {
          return BlocProvider(
            create: (context) => datePickerBloc[item.index] as DatePickerBloc,
            child: ShareContainer(
              widget: DatePicker(
                isError: isError[item.index] ?? false,
                isRequest: true,
                datePickerBloc: datePickerBloc[item.index] as DatePickerBloc,
                controller:
                    answersControllers[item.index] ?? TextEditingController(),
              ),
              title: item.title,
              isRequest: isRequired,
            ),
          );
        }
      case FormType.RATING:
        {
          return ShareContainer(
              title: item.title,
              isRequest: isRequired,
              widget: Rating(
                controller:
                    answersControllers[item.index] ?? TextEditingController(),
                ratingBloc: ratingBloc[item.index] as RatingBloc,
                isError: isError[item.index] ?? false,
                isRequest: isRequired,
              ));
        }
      default:
        return const SizedBox.shrink();
    }
  }
}
