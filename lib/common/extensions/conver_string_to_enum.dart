import '../enums/form_page_enums.dart';

extension FormTypeExtension on String {
  FormType? toFormType() {
    return FormType.values.cast<FormType?>().firstWhere(
          (e) => e.toString().split('.').last == this,
          orElse: () => null,
        );
  }
}
