import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// normal provider
final Provider valueProvider = Provider<int>(
    (ref) => 34
);

// state provider
final StateProvider valueState = StateProvider<int>(
        (ref) => 30
);

//  ChangeNotifier
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  bool _isLoading = false;

  int get count => _count;
  bool get isLoading => _isLoading;

  Future<void> fetchCount() async {
    updateLoadingState(true);
    await Future.delayed(const Duration(seconds: 2));
    _count = 0;
    updateLoadingState(false);

  }

  updateLoadingState(bool state){
    _isLoading = state;
    notifyListeners();
  }

  updateCount(int val) {
    _count += val;
    notifyListeners();
  }
}
final counterProvider = ChangeNotifierProvider.autoDispose<CounterProvider>(
    (ref) => CounterProvider()
);

// StateNotifier
class CounterStateProvider extends StateNotifier<int> {

  // initialization of state
  CounterStateProvider() : super(0);

  void incrementCount(int val){
    state++;
  }

  void decrementCount(int val){
    state--;
  }
}
final counterStateProvider = StateNotifierProvider.autoDispose<CounterStateProvider, int>(
        (ref) => CounterStateProvider()
);



class RiverPodTest extends StatelessWidget {
  const RiverPodTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RiverPod Testing"), centerTitle: true,
      ),
      body: Center(
        child: Consumer(
            builder: (_, watch, __){
              final val = watch(counterProvider);
              if(val.isLoading) {
                return Center(child: CircularProgressIndicator(),);
              } else {
                return Text('${val.count}');
              }
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: (){
          context.read(counterProvider).fetchCount();
          // context.read(counterProvider).updateCount(4);
        }
      ),
    );
  }
}
