import 'package:animation_test/page_route_test.dart';
import 'package:flutter/material.dart';

// Ready

const String heroTag = 'container';

class HeroPageTest extends StatelessWidget {
  const HeroPageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First page'),
      ),
      body: Column(
        children: [
          const Hero(
            tag: heroTag,
            child:  Material(
              color: Colors.purple,
              child: Padding(
                padding: EdgeInsets.all(22.0),
                child: Icon(Icons.add_rounded),
              ),
            ),
          ),
          const SizedBox(height: 6,),
          GestureDetector(
            onTap: () {
              Navigator.push(context, FancyRoute(
                builder: (BuildContext context) => const SecondPage(),
              ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.purple,
              child: const Center(child: Text('centered text'),),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //
      // ),
    );
  }
}

// second page
class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: heroTag,
          child:  Material(
            color: Colors.purple,
            child: Padding(
              padding:  const EdgeInsets.all(22.0),
              child:  SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 180,
                      child: const Text('centered text',),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
