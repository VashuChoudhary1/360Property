import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController circleToRectController;
  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;
  late Animation<BorderRadius?> borderRadiusAnimation; // fixed type

  late AnimationController houseController;
  late Animation<Offset> houseAnimation;

  late AnimationController logo360Controller;
  late Animation<Offset> logo360Animation;

  @override
  void initState() {
    super.initState();

    circleToRectController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    houseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    logo360Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      widthAnimation = Tween<double>(begin: 20.0, end: size.width).animate(
        CurvedAnimation(parent: circleToRectController, curve: Curves.easeOut),
      );

      heightAnimation = Tween<double>(begin: 20.0, end: size.height).animate(
        CurvedAnimation(parent: circleToRectController, curve: Curves.easeOut),
      );

      borderRadiusAnimation = BorderRadiusTween(
        begin: BorderRadius.circular(100),
        end: BorderRadius.circular(0),
      ).animate(
        CurvedAnimation(parent: circleToRectController, curve: Curves.easeOut),
      );

      houseAnimation = Tween<Offset>(
        begin: const Offset(0, 2),
        end: const Offset(0, 0),
      ).animate(
          CurvedAnimation(parent: houseController, curve: Curves.easeOut));

      logo360Animation = Tween<Offset>(
        begin: const Offset(2, 0),
        end: const Offset(0, 0),
      ).animate(
          CurvedAnimation(parent: logo360Controller, curve: Curves.easeOut));

      circleToRectController.forward().whenComplete(() {
        houseController.forward();
      });

      houseController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          logo360Controller.forward();
        }
      });

      setState(() {});
    });
  }

  @override
  void dispose() {
    circleToRectController.dispose();
    houseController.dispose();
    logo360Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (circleToRectController.isDismissed) {
      return const SizedBox();
    }

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [circleToRectController, houseController, logo360Controller]),
        builder: (context, child) {
          return Stack(
            children: [
              // Red background expanding
              Center(
                child: Container(
                  width: widthAnimation.value,
                  height: heightAnimation.value,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000),
                    borderRadius: borderRadiusAnimation.value,
                  ),
                ),
              ),

              if (circleToRectController.status == AnimationStatus.completed)
                SlideTransition(
                  position: houseAnimation,
                  child: Center(
                    child: Image.asset(
                      'assets/home_logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              if (houseController.status == AnimationStatus.completed)
                SlideTransition(
                  position: logo360Animation,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Image.asset(
                        'assets/360_logo.png',
                        width: 150,
                        height: 80,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
