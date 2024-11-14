library all_locators;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/common/services/network/custom_http_client.dart';
import 'package:dsoft_form_application/common/shared_prefs/theme_preference.dart';
import 'package:dsoft_form_application/core/routing/app_router.dart';
import 'package:dsoft_form_application/data/local/utils/hive_utils.dart';
import 'package:dsoft_form_application/data/remote/posts_remote_data_resource.dart';
import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/serviceables/posts_serviceable.dart';
import 'package:dsoft_form_application/domain/usecases/fetch_posts_usecase.dart';
import 'package:dsoft_form_application/domain/usecases/save_result_post_usecase.dart';

import 'package:dsoft_form_application/presentation/home_screen/bloc/home_page_bloc.dart';
import 'package:dsoft_form_application/presentation/splash_screen/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../common/services/permission_service.dart';

import '../../data/exceptions/remote_http_exceptions.dart';
import '../../data/local/post_local_data_source.dart';
import '../../domain/usecases/get_posts_from_local_usecase.dart';
import '../../domain/usecases/get_detail_post_usecase.dart';
import '../../domain/usecases/get_answer_from_local_usecase.dart';
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
