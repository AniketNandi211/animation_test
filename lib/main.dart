import 'package:animation_test/widgets/hero_container_test.dart';
import 'package:animation_test/widgets/popup_box.dart';
import 'package:animation_test/widgets/riverpod_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Test",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HybridPage());
  }
}

class PageWithButton extends StatelessWidget {
  const PageWithButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            150,
            (index) => const Card(
                  child: Text('hijsahsdjsj'),
                )),
      ),
    );
  }
}

//Sidebar animation page
class HybridPage extends StatefulWidget {
  final Size? screenSize;

  const HybridPage({Key? key, this.screenSize}) : super(key: key);

  @override
  _HybridPageState createState() => _HybridPageState();
}

class _HybridPageState extends State<HybridPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;
  late Animation<double> _top;
  late Animation<double> _left;
  late Animation<double> _border;
  late CurvedAnimation _curvedAnimation;
  late bool isMenuOpen;

  @override
  void initState() {
    super.initState();
    isMenuOpen = false;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.linearToEaseOut);
    _scale = Tween<double>(begin: 1.0, end: 0.78).animate(_curvedAnimation);
    _top = Tween<double>(begin: 0, end: 120).animate(_curvedAnimation);
    _left = Tween<double>(begin: 0, end: 240).animate(_curvedAnimation);
    _border = Tween<double>(begin: 0, end: 35).animate(_curvedAnimation);
    // _optionalAnim = Tween<double>(begin: 0, end: 2).animate(_curvedAnimation);
  }

  void toggleAnimation() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          backgroundColor: const Color(0xff001936),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.purple.shade900,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(20))),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 34, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) {
            return Transform(
                transform: Matrix4.translationValues(_left.value, _top.value, 0)
                  ..scale(_scale.value),
                origin: const Offset(0.5, 0.5), // not sure how it does this :(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_border.value),
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.teal,
                      title: const Text('Main'),
                      centerTitle: true,
                      leading: InkWell(
                        child: const Icon(Icons.menu),
                        onTap: () {
                          toggleAnimation();
                          Popup(context: context, message: 'switched').show();
                        },
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      child: const Icon(Icons.ac_unit),
                      onPressed: () {
                        Popup.error(context: context, message: 'Network error')
                            .show();
                      },
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      backgroundColor: Colors.purple,
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.animation), label: 'he12y'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.animation), label: 'hsasdy'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.animation), label: 'hiols'),
                      ],
                    ),
                  ),
                ));
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
