import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit({required this.getProductByIdUseCase}) : super(DetailPageInitial());
  final GetProductByIdUseCase getProductByIdUseCase;

  void loading(){
    emit(LoadingDetailState());
  }

  void getProduct(int id) async{
    var product = await getProductByIdUseCase.call(id);
    emit(ProductLoadedState(product: product));
  }
}
