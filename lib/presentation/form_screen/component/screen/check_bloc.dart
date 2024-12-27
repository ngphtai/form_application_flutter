import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/entities/post_model_entity.dart';

bool checkBloc<T>({
  required Map<int, Cubit<dynamic>> blocMap,
  required PostModelEntity postEntity,
  required bool Function(Cubit<dynamic> bloc, int key) validateBloc,
  required void Function(Cubit<dynamic> bloc, int key) handleError,
  required dynamic Function(Cubit<dynamic> bloc)? getValue,
}) {
  bool isValid = true;

  for (var entry in blocMap.entries) {
    final key = entry.key;
    final bloc = entry.value;

    // Kiểm tra giá trị và xử lý lỗi nếu cần
    if (!validateBloc(bloc, key)) {
      handleError(bloc, key);
      isValid = false;
    } else {
      final value = getValue?.call(bloc) ?? "";
      postEntity.items[key].result ??= [""];
      postEntity.items[key].result![0] = value;
    }
  }

  return isValid;
}
