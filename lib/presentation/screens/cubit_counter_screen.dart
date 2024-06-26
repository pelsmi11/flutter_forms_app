import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // example whit watch
    // final counterState = context.watch<CounterCubit>().state;

    void increaseCounterBy(BuildContext context, [int value = 1]) {
      context.read<CounterCubit>().increaseBy(value);
    }

    return Scaffold(
      appBar: AppBar(
        // title: Text('Cubit Counter: ${counterState.transactionCount}'), //example of watch
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${value.state.transactionCount}');
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<CounterCubit>().reset();
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Text("Counter Value: ${state.counter}");
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => {increaseCounterBy(context, 3)},
            child: const Text('+3'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () => {increaseCounterBy(context, 2)},
            child: const Text('+2'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () => {increaseCounterBy(context)},
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}
