import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/domain/use_cases/get_shared_string_list_usecase.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_list_usecase.dart';

part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  PrefsCubit({required this.getSharedStringListUseCase, required this.getSharedStringUseCase, required this.setSharedStringListUseCase}) : super(PrefsInitial());

  final GetSharedStringListUseCase getSharedStringListUseCase;
  final GetSharedStringUseCase getSharedStringUseCase;
  final SetSharedStringListUseCase setSharedStringListUseCase;

  List<String>? getStringList(String key){
    final favoritesList =  getSharedStringListUseCase.call(key);
    if(favoritesList != null){
      return favoritesList;
    } else {
      return <String>[];
    }
  }

  bool isFavorite(String id){
    final favoriteList = getSharedStringListUseCase.call('favorites');
    if(favoriteList != null){
      return favoriteList.contains(id);
    } else {
      return false;
    }
  }

  Future<void> setStringList(String key, List<String> value){
    return setSharedStringListUseCase.call(key, value);
  }
}
