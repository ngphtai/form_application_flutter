import 'package:bloc/bloc.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/models/post_model.dart';

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
      print("error to fetch API: ${e.toString}");
    }
  }
}
