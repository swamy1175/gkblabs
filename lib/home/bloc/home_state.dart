part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionSate extends HomeState{}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {

}
class HomeLoadingSuccessState extends HomeState {
  final List<ProductModel> productList;
  HomeLoadingSuccessState({required this.productList});

}
class HomeErrorState extends HomeState {

}

class HomeCartButtonClickedState extends HomeActionSate {}
