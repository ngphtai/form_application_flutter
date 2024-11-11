import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/data/model/entities/item_model_entity.dart';
import 'package:dsoft_form_application/data/model/entities/metadata_model_entity.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';
import 'package:hive/hive.dart';

import '../../../common/constant/constants.dart';

class HiveUtils {
  Future<void> initialize() async {
    AppLogger.instance.d("Start initialize hive local database");

    _registerAdapter();
    await _openLazyBoxes();
  }

  void _registerAdapter() {
    Hive.registerAdapter(MetadataModelEntityAdapter());
    Hive.registerAdapter(ItemModelEntityAdapter());
    Hive.registerAdapter(PostModelEntityAdapter());
    AppLogger.instance.e("Start register all of adapter hive local database");
  }

  Future<void> _openLazyBoxes() async {
    try {
      await Hive.openLazyBox<PostModelEntity>(LocalConstants.boxPostInfo);
      AppLogger.instance.e("Start open all of boxes hive local database");
    } catch (e) {
      AppLogger.instance.d("HAVE ERROR ON INIT LAZY BOX ${e.toString()}");
    }
  }

  LazyBox<T> getBox<T>(String nameOfBox) {
    return Hive.lazyBox<T>(nameOfBox);
  }

  Future<bool> isExistBox(String nameOfBox) {
    return Hive.boxExists(nameOfBox);
  }

  Future<bool> isExistAndNotEmpty<T>(String nameOfBox) async {
    await _openLazyBoxes();
    final box = getBox<T>(nameOfBox);
    final isExist = await isExistBox(nameOfBox);
    final isNotEmpty = box.isNotEmpty;
    return isNotEmpty && isExist;
  }
}
