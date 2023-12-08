import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swamy_bloc_learn/cart/cart_page.dart';
import 'package:swamy_bloc_learn/home/bloc/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }
  Future<void> _refresh() async{
    homeBloc.add(HomeInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current)=> current is HomeActionSate,
      buildWhen: (previous,current) => current is !HomeActionSate,
      listener: (context, state) {
        if(state is HomeCartButtonClickedState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
        }
      },
      builder: (context, state) {
         switch (state.runtimeType) {
          case HomeLoadingState:
          return const Scaffold(body: SafeArea(
            child: Center(child: CircularProgressIndicator()),
          ));
           case HomeLoadingSuccessState:
             final successSate = state as HomeLoadingSuccessState;
             return Scaffold(
               appBar: AppBar(title: const Text('Groceries',style: TextStyle(color: Colors.white),),
                   backgroundColor: Colors.teal,
                   actions: [
                     IconButton(onPressed: (){
                       homeBloc.add(HomeCartEventClicked());
                     }, icon: const Icon(Icons.shopping_cart,color: Colors.white,))
                   ]),
               body:  SafeArea(child:
               RefreshIndicator(
                 onRefresh: (){
                   return _refresh();
                 },
                 child: Column(
                   children: [
                     ListView.builder(
                       shrinkWrap: true,
                       itemCount: successSate.productList.length,
                         itemBuilder: (context,index){
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                             child: Column(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Name: ${successSate.productList[index].name}'),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Price: ${successSate.productList[index].price}'),
                                 ),
                               ],
                             ),
                           ),
                         );
                     })
                   ],
                 ),
               )),
             );
           case HomeErrorState:
             return Text('Error found');
           default:
               return const SizedBox();
        }
      },
    );
  }
}

