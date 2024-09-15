import 'package:flutter/material.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/colors.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/drink.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/drinkCard.dart';
import 'package:toastification/toastification.dart';

class YakultScreen extends StatefulWidget {
  const YakultScreen({super.key});
  @override
  State<YakultScreen> createState() => _YakultScreenState();
}

class _YakultScreenState extends State<YakultScreen> with SingleTickerProviderStateMixin {
  late PageController pageController;
  double pageOffset = 0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); // Liberar recursos cuando ya no sea necesario
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          buildToolbar(),
          buildLogo(size),
          buildPager(size),
          buildPageIndecator(),
        ],
      )),
    );
  }

  Widget buildToolbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-200*(1-animation.value).toDouble(), 0),
                child: Tooltip(
                  message: 'Mapa de Sucursales',
                  child: Image.asset(
                    'assets/coffeeChallenge/yakult/location.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              );
            }
          ),
          Spacer(),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-200*(1-animation.value).toDouble(), 0),
                child: Image.asset(
                  'assets/coffeeChallenge/yakult/drawer.png',
                  width: 30,
                  height: 30,
                ),
              );
            }
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform(
            transform: Matrix4.identity()
            ..translate(0.0,size.height/2*(1-animation.value))
            ..scale(1+(1-animation.value)),
            origin: Offset(25, 25),
            child: InkWell(
              onTap: () {
                if(controller.isCompleted){
                  controller.reverse();
                  toastification.show(
                    context: context,
                    style: ToastificationStyle.flatColored,
                    type: ToastificationType.success,
                    title: Text('¡Hasta la próxima!'),
                    autoCloseDuration: const Duration(seconds: 4),
                    closeButtonShowType: CloseButtonShowType.onHover,
                    showProgressBar: false,
                    alignment: Alignment.topCenter,
                  );
                } else {
                  controller.forward();
                }
              },
              child: Image.asset(
                'assets/coffeeChallenge/yakult/yakultlogo.png',
                width: 50,
                height: 50,
              ),
            ),
          );
        }
      )
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(400*(1-animation.value).toDouble(),0),
            child: PageView.builder(
                controller: pageController,
                itemCount: getDrinks().length,
                itemBuilder: (context, index) =>
                    DrinkCard(getDrinks()[index], pageOffset, index)),
          );
        }
      ),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
        'Yakult',
        'Or',
        'assets/coffeeChallenge/blur_image.png',
        'assets/coffeeChallenge/yakult/bean_top.png',
        'assets/coffeeChallenge/yakult/bean_small.png',
        'assets/coffeeChallenge/yakult/bean_blur.png',
        'assets/coffeeChallenge/yakult/yakultsplash.png',
        'El de siempre, con más de 8 mil Lactobacillus casei Shirota',
        yOriginal,
        yOriginal2));
    list.add(Drink(
        'Yakult',
        'Lt',
        'assets/coffeeChallenge/mocha_image.png',
        'assets/coffeeChallenge/yakult/chocolate_top.png',
        'assets/coffeeChallenge/yakult/chocolate_small.png',
        'assets/coffeeChallenge/yakult/chocolate_blur.png',
        'assets/coffeeChallenge/yakult/yakultlighsplash.png',
        'Yakult reducido en azúcar y calorías.',
        greenLight,
        greenDark));
    list.add(Drink(
        'Yakult',
        'Yg',
        'assets/coffeeChallenge/green_image.png',
        'assets/coffeeChallenge/yakult/green_top.png',
        'assets/coffeeChallenge/yakult/green_small.png',
        'assets/coffeeChallenge/yakult/green_blur.png',
        'assets/coffeeChallenge/yakult/sofulyakultsplash.png',
        'Leche fermentada con Lactobacillus casei Shirota.',
        yLecheF,
        ylecheF2));
    return list;
  }
  
  Widget buildPageIndecator() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(children: List.generate(getDrinks().length, (index)=>buildContainer(index)),)
          ),
        );
      }
    );
  }
  
  Widget buildContainer(int index) {
    double animate = pageOffset-index;
    double size = 10;
    animate = animate.abs();
    Color color = Colors.grey;
    if(animate <= 1 && animate >= 0){
      size = 10+10*(1-animate);
      color = ColorTween(begin: Colors.grey, end: mAppGreen).transform((1-animate))!;
    }
    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }

}
