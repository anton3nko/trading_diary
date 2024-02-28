import 'package:flutter/material.dart';
import 'package:trading_diary/features/strategies/presentation/strategy_add_page.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

class StrategiesPage extends StatefulWidget {
  const StrategiesPage({super.key});

  static const String id = 'strategies_page';

  @override
  State<StrategiesPage> createState() => _StrategiesPageState();
}

//Добавил сохранение и выгрузку стратегий с базы.
class _StrategiesPageState extends State<StrategiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, StrategyAddPage.id);
        },
      ),
      body: BlocBuilder<StrategyBloc, StrategyState>(
        builder: (context, state) {
          // if (state is StrategyInitialState) {
          //   context.read<StrategyBloc>().add(const FetchStrategiesEvent());
          // }
          if (state is DisplayStrategiesState) {
            return SafeArea(
                child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height,
              child: state.strategies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.strategies.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(3.0),
                          child: ListTile(
                            shape: Styles.kRoundedRectangleTileShape,
                            leading: Icon(
                              Icons.area_chart_sharp,
                              color: state.strategies[index].strategyColor,
                            ),
                            title: Text(
                              state.strategies[index].title,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<StrategyBloc>().add(
                                          DeleteStrategyEvent(
                                              id: state.strategies[index].id!));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        content: Text("Deleted Strategy"),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        );
                      })
                  : const Text(''),
            ));
          }
          return const Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: Text(
                'Loading Data From The Database...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
