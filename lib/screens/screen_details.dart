import 'dart:convert';

import 'package:azam_shoshin_task/model/model_main.dart';
import 'package:azam_shoshin_task/model/model_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({super.key});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  late List _data1 = [];
  late List _data2 = [];

  Future<List<Model1>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/dummy_tasks.json');
    final data = await json.decode(response);
    setState(() {
      _data1 = data;
    });
    final List<Model1> tasks = [];
    for (var i = 0; i < data.length; i++) {
      tasks.add(Model1.fromJson(data[i]));
    }
    return tasks;
  }

  Future<List<Model2>> readJsonDetails() async {
    final String response =
        await rootBundle.loadString('assets/dummy_details.json');
    final data = await json.decode(response);
    final List<Model2> details = [];
    setState(() {
      _data2 = data;
    });
    for (var i = 0; i < data.length; i++) {
      details.add(Model2.fromJson(data[i]));
    }
    return details;
  }

  @override
  void initState() {
    super.initState();
    readJson();
    readJsonDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _data1.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    child: _data1.isNotEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                _data1.isNotEmpty
                                    ? _data1[0]['thumbnail'] ?? ''
                                    : '',
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _data1.isNotEmpty
                                            ? _data1[0]['brand']['title'] ?? ''
                                            : '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(_data1.isNotEmpty
                                          ? _data1[0]['shortDesc']
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
            _data2.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    'Steps (1/${_data2.isNotEmpty ? _data2.length : 0})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 10),
            _data2.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: FutureBuilder<List<Model2>>(
                      future: readJsonDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (_data2.isNotEmpty) {
                            _data2.sort(
                              (a, b) =>
                                  (b['isCompleted'] ? 1 : 0) -
                                  (a['isCompleted'] ? 1 : 0),
                            );
                          }
                          return ListView.builder(
                            itemCount: _data2.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: _data2[index]['isCompleted']
                                        ? Colors.green
                                        : _data2[index] != _data2[2]
                                            ? Colors.amber
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    _data2[index]['title'],
                                    style: TextStyle(
                                        decoration: _data2[index]['isCompleted']
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: !_data2[index]['isCompleted']
                                      ? Text(
                                          _data2[index]['description'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )
                                      : null,
                                  leading: _data2[index]['isCompleted']
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
                                      : _data2[index] != _data2[2]
                                          ? Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                                                    BorderRadius.circular(50),
                                              ),
                                              child: null),
                                  trailing: Container(
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: _data2[index]['isCompleted']
                                          ? Colors.green
                                          : _data2[index] != _data2[2]
                                              ? Colors.amber
                                              : Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      _data2[index]['payout']
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
            _data2.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.lightningBolt, color: Colors.amber),
                      Text(
                          '${NumberFormat.compact().format(int.parse(_data1[0]['total_lead']))} users has already participated'),
                    ],
                  ),
            _data2.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 80, 163, 222)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Get ${_data2[0]['payout_currency']}${_data2[0]['payout_amt'] + _data2[1]['payout_amt'] + _data2[2]['payout_amt']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
