import 'package:azam_shoshin_task/model/model_details.dart';
import 'package:azam_shoshin_task/screens/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({super.key});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().readJson1();
    context.read<AppCubit>().readJson2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Offer detail',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.data1.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        child: state.data1.isNotEmpty
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    state.data1.isNotEmpty
                                        ? state.data1[0].thumbnail
                                        : '',
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.data1.isNotEmpty
                                                ? state.data1[0].brand.title
                                                : '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(state.data1.isNotEmpty
                                              ? state.data1[0].shortDesc
                                              : ''),
                                          const SizedBox(height: 10),
                                          RatingBarIndicator(
                                            rating: 0,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 24,
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const CircularProgressIndicator(),
                      ),
                const Divider(indent: 20, endIndent: 20, thickness: 0.5),
                const SizedBox(height: 10),
                state.data2.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        'Steps (1/${state.data2.isNotEmpty ? state.data2.length : 0})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(height: 10),
                state.data2.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: FutureBuilder<List<Model2>>(
                          future: context.read<AppCubit>().readJson2(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (state.data2.isNotEmpty) {
                                state.data2.sort(
                                  (a, b) =>
                                      (b.isCompleted ? 1 : 0) -
                                      (a.isCompleted ? 1 : 0),
                                );
                              }
                              return ListView.builder(
                                itemCount: state.data2.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: state.data2[index].isCompleted
                                            ? Colors.green
                                            : state.data2[index] !=
                                                    state.data2[2]
                                                ? Colors.amber
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        state.data2[index].title,
                                        style: TextStyle(
                                            decoration:
                                                state.data2[index].isCompleted
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: !state.data2[index].isCompleted
                                          ? Text(
                                              state.data2[index].description,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            )
                                          : null,
                                      leading: state.data2[index].isCompleted
                                          ? Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            )
                                          : state.data2[index] != state.data2[2]
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Icon(
                                                    MdiIcons.timerSandEmpty,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: null),
                                      trailing: Container(
                                        width: 50,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: state.data2[index].isCompleted
                                              ? Colors.green
                                              : state.data2[index] !=
                                                      state.data2[2]
                                                  ? Colors.amber
                                                  : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          state.data2[index].payout
                                              .toString()
                                              .replaceAll('.00', ''),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                state.data2.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.lightningBolt, color: Colors.amber),
                          Text(
                              '${NumberFormat.compact().format(int.parse(state.data1[0].totalLead))} users has already participated'),
                        ],
                      ),
                state.data2.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 80, 163, 222)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Get ${state.data2[0].payoutCurrency}${state.data2[0].payoutAmt + state.data2[1].payoutAmt + state.data2[2].payoutAmt}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
