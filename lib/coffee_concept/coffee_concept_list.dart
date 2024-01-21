import 'package:flutter/material.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/coffee_concept/coffee_concept_detail.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/model/coffee.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({Key? key}) : super(key: key);

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.3,
    initialPage: _initialPage.toInt()
  );

  final _pageTextController = PageController(
    initialPage: _initialPage.toInt()
  );
  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  void _textScrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_textScrollListener);
    _pageCoffeeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    offset: Offset.zero,
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length + 1,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    _pageTextController.animateToPage(
                      value,
                      duration: _duration,
                      curve: Curves.easeOut,
                    );
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final Coffee coffee = coffees[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: CoffeeConceptDetail(coffee: coffee),
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(0.0, MediaQuery.of(context).size.height / 2.6 * (1 - value).abs())
                          ..scale(value),
                        child: Opacity(
                          opacity: opacity,
                          child: Hero(
                              tag: coffee.name,
                              child: Image.asset(coffee.image, fit: BoxFit.fitHeight)),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, -100 * value),
                    child: child,
                  );
                },
                duration: _duration,
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                            itemCount: coffees.length,
                            controller: _pageTextController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final opacity = (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                              return Opacity(
                                opacity: opacity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                                  child: Hero(
                                    tag: "text_${coffees[index].name}",
                                  child: Material(

                                      child: Text(
                                        coffees[index].name,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                    const SizedBox(height: 15),
                    AnimatedSwitcher(
                        duration: _duration,
                        child: Text(
                          "\$${coffees.tryGet(_currentPage.toInt())?.price.toStringAsFixed(2)??" :)"}",
                          key: Key(coffees.tryGet(_currentPage.toInt())?.name??""),
                          style: const TextStyle(fontSize: 30),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) =>
      index < 0 || index >= length ? null : this[index];
}
