import 'dart:math';

import '/common/constant/constants.dart';
import '/core/locators/locators.dart';
import '/data/model/entities/post_model_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../common/logger/app_logger.dart';

abstract class PostLocalDataSource {
  Future<bool> savePost(PostModelEntity post);
  Future<List<PostModelEntity>?> getPostsLocal();

  Future<PostModelEntity?> getAnswers(String id);
  Future<bool> deletePostLocal(int id);
}

class PostLocalDataSourceImpl extends PostLocalDataSource {
  PostLocalDataSourceImpl() {
    initState();
  }

  final _hiveUtils = diHiveUtils;
  late final LazyBox<PostModelEntity>? _postEntityBox;

  void initState() {
    _postEntityBox =
        _hiveUtils.getBox<PostModelEntity>(LocalConstants.boxPostInfo);
  }

  @override
  Future<bool> savePost(PostModelEntity post) async {
    try {
      // final bool? result = _postEntityBox?.containsKey(post.metaData.id);
      // if (result! == false) {
      //   await _postEntityBox!.put(post.metaData.id, post);
      //   AppLogger.instance.e("Posts is saved in local device");
      //   return true;
      // } else {
      //   AppLogger.instance.e("Posts was saved in local device!!!!!");
      //   return true;
      // }

      //handle temporary to get new id
      String id = "${post.metaData.id} ${Random().nextInt(100)}";
      post.metaData.id = id;
      await _postEntityBox!.put(id, post);
      AppLogger.instance.i("Posts is saved in local device");
      return true;
    } catch (e) {
      debugPrint("HAVE ERROR IN PUT DATA TO BOX ${e.toString()}");
      return false;
    }
  }

  @override
  Future<List<PostModelEntity>> getPostsLocal() async {
    final isExist = await _hiveUtils
        .isExistAndNotEmpty<PostModelEntity>(LocalConstants.boxPostInfo);
    if (!isExist) return [];

    if (_postEntityBox != null) {
      final keys = _postEntityBox.keys;

      // use Future.wait to get value for each key
      final posts = await Future.wait(
        keys.map((key) {
          // _postEntityBox.delete(key);
          return _postEntityBox.get(key);
        }),
      );

      posts.sort((a, b) {
        final updateAtA = a?.metaData.updateAt;
        final updateAtB = b?.metaData.updateAt;
        if (updateAtA == null && updateAtB == null) {
          return 0;
        } else if (updateAtA == null) {
          return -1;
        } else if (updateAtB == null) {
          return 1;
        } else {
          return updateAtB.compareTo(updateAtA);
        }
      });

      // filter to remove element which is null (if it have that)
      return posts
          .where((post) => post != null)
          .cast<PostModelEntity>()
          .toList();
    } else {
      throw Exception("PostEntityBox has not been initialized.");
    }
  }

  @override
  Future<PostModelEntity?> getAnswers(String id) async {
    final isExist = await _hiveUtils
        .isExistAndNotEmpty<PostModelEntity>(LocalConstants.boxPostInfo);
    if (!isExist) return null;

    if (_postEntityBox != null) {
      // final keys = _postEntityBox.keys;

      final PostModelEntity? post = await _postEntityBox.get(id);

      return post;
    } else {
      throw Exception("PostEntityBox has not been initialized.");
    }
  }

  @override
  Future<bool> deletePostLocal(int id) async {
    final isExist = await _hiveUtils
        .isExistAndNotEmpty<PostModelEntity>(LocalConstants.boxPostInfo);
    if (isExist && _postEntityBox != null) {
      _postEntityBox.delete(id);
      AppLogger.instance.d("Post is deleted in local device");
      return true;
    } else {
      throw Exception("PostEntityBox has not been initialized or isEmpty.");
    }
  }
}
