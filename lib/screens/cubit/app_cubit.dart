import 'dart:convert';

import 'package:azam_shoshin_task/model/model_details.dart';
import 'package:azam_shoshin_task/model/model_main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
            data1: [],
            data2: [],
          ),
        );

  Future<List<Model1>> readJson1() async {
    final String response =
        await rootBundle.loadString('assets/dummy_tasks.json');
    final List<dynamic> data = json.decode(response);
    final List<Model1> tasks =
        data.map((item) => Model1.fromJson(item)).toList();
    emit(state.copyWith(data1: tasks));
    return tasks;
  }

  Future<List<Model2>> readJson2() async {
    final String response =
        await rootBundle.loadString('assets/dummy_details.json');
    final data = await json.decode(response) as List<dynamic>;
    final List<Model2> details = data
        .map((item) => Model2.fromJson(item as Map<String, dynamic>))
        .toList();
    emit(state.copyWith(data2: details));
    return details;
  }

  late AnimationController controller;
  late Animation<double> animation;

  void animationFunction() {
    animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.3),
        weight: 1.0,
      ),
    ]).animate(controller);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  void startAnimation() {
    controller.forward(from: 0.0);
  }
}

class TestVSync extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
