import 'package:bloc/bloc.dart';
import '/common/logger/app_logger.dart';
import '/core/locators/locators.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/meta_data_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<GetPost>(_getPostHomePage);
  }

  final _fetchPostSeviceable = diPostSeviceable;

  Future<void> _getPostHomePage(
      HomePageEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageLoading());

      final result = await _fetchPostSeviceable.fetchPostsFromRemote();

      result.fold(
        (error) => emit(HomePageLoadFailed()),
        (result) {
          emit(HomePageLoaded(result));
        },
      );
    } on Exception catch (e) {
      emit(HomePageLoadFailed());
      AppLogger.instance.e("message: ${e.toString()}");
    }
  }
}
