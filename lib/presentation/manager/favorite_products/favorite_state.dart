part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class RefreshProductCardState extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RefreshProductCardRemoveState extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}