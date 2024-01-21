import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/model/coffee.dart';

class CoffeeConceptDetail extends StatelessWidget {
  const CoffeeConceptDetail({Key? key, required this.coffee}) : super(key: key);
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .2),
            child: Hero(
              tag: "text_${coffee.name}",
              child: Material(
                child: Text(
                  coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: size.height * .4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(
                      coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * .05,
                  bottom: 0,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-100 * value, (240 * value)),
                        child: child,
                      );
                    },
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      '\$${coffee.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        shadows: [BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 20,
                        )],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
