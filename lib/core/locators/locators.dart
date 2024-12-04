library all_locators;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../../common/constant/constants.dart';
import "../../common/services/network/custom_http_client.dart";
import '../../common/shared_prefs/theme_preference.dart';
import '../routing/app_router.dart';
import '/data/local/utils/hive_utils.dart';
import '/data/remote/posts_remote_data_resource.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/serviceables/posts_serviceable.dart';
import '/domain/usecases/fetch_posts_usecase.dart';
import '/domain/usecases/save_result_post_usecase.dart';

import '/presentation/home_screen/bloc/home_page_bloc.dart';
import '/presentation/splash_screen/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../common/services/permission_service.dart';

import '../../data/exceptions/remote_http_exceptions.dart';
import '../../data/local/post_local_data_source.dart';
import '../../domain/usecases/get_posts_from_local_usecase.dart';
import '../../domain/usecases/get_detail_post_usecase.dart';
import '../../domain/usecases/get_answer_from_local_usecase.dart';
import '../../domain/usecases/save_answer_to_google_sheet.dart';
import '../../shared/states/theme/theme_cubit.dart';

part 'app_router_locator.dart';
part 'blocs_locator.dart';
part 'cubits_locator.dart';
part 'data_source_locator.dart';

part 'hive_locator.dart';
part 'inject_locators.dart';

part 'repositories_locator.dart';
part 'serviceable_locator.dart';
part 'services_locator.dart';
part 'shared_preference_locator.dart';
part 'usecase_locator.dart';
part 'libs_locator.dart';
part 'errors_locator.dart';
