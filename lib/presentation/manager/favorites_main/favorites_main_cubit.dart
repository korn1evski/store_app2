import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_main_state.dart';

class FavoritesMainCubit extends Cubit<FavoritesMainState> {
  FavoritesMainCubit() : super(FavoritesMainInitial());

  void refreshProductAdded(){
    emit(RefreshProductAdded());
  }

  void refreshProductRemoved(){
    emit(RefreshProductRemoved());
  }
}
