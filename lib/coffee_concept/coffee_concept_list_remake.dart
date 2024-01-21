import 'package:flutter/material.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/model/coffee.dart';

const _initialPage = 8.0;

class CoffeeConceptListRemake extends StatefulWidget {
  CoffeeConceptListRemake({Key? key}) : super(key: key);

  @override
  State<CoffeeConceptListRemake> createState() => _CoffeeConceptListRemakeState();
}

class _CoffeeConceptListRemakeState extends State<CoffeeConceptListRemake> {

  double _currentPage = _initialPage;

  final _pageCoffeeController = PageController(
      viewportFraction: 0.3,
      initialPage: _initialPage.toInt()
  );

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageCoffeeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: coffees.length,
            controller: _pageCoffeeController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final coffee = coffees[index];

              final result = _currentPage - index;

              final value = result * 0.4;

              final matrix = Matrix4.identity();
              matrix.scale(value);

              print(matrix);

              return Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: Image.asset(
                  coffee.image,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
