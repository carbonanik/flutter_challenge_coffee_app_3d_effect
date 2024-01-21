import 'package:flutter/material.dart';

// const _initialPage = 8.0;
//
// class CoffeeBLoC {
//   final pageCoffeeController = PageController(
//       viewportFraction: 0.3,
//       initialPage: _initialPage.toInt()
//   );
//
//   final pageTextController = PageController(
//       initialPage: _initialPage.toInt()
//   );
//   final currentPage = ValueNotifier<double>(_initialPage);
//   final textPage = ValueNotifier<double>(_initialPage);
//
//   void _coffeeScrollListener() {
//       currentPage.value = pageCoffeeController.page!;
//   }
//
//   void _textScrollListener() {
//     textPage.value = pageTextController.page!;
//   }
//
//   void init(){
//     pageCoffeeController.addListener(_coffeeScrollListener);
//     pageTextController.addListener(_textScrollListener);
//   }
//
//   void dispose(){
//     pageCoffeeController.removeListener(_coffeeScrollListener);
//     pageTextController.removeListener(_textScrollListener);
//     pageCoffeeController.dispose();
//     pageTextController.dispose();
//   }
// }
//
//
// class CoffeeProvider extends InheritedWidget {
//   CoffeeProvider({required this.bloc, required super.child});
//
//   final CoffeeBLoC bloc;
//
//   static CoffeeProvider? of(BuildContext context) => context.findAncestorWidgetOfExactType<CoffeeProvider>();
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
//
// }