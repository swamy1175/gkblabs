import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swamy_bloc_learn/cart/grocey_product_model.dart';
import 'package:swamy_bloc_learn/grocery_data.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeCartEventClicked>(homeCartClickedEvent);
    on<HomeInitialEvent>(homeInitialEvent);

  }
  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadingSuccessState(productList: GroceryData.groceryProducts.map((e) =>
        ProductModel(id: e['id'], name: e['name'], description: e['description'], price: e['price'], image: e['imageUrl'])).toList()));

  }
  FutureOr<void> homeCartClickedEvent(HomeCartEventClicked event, Emitter<HomeState> emit) {
    print('clicked swamy');
    emit(HomeCartButtonClickedState());
  }


}
