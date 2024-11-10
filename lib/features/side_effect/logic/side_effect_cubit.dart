import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_reminder/core/network/firebase_services.dart';
import 'package:medication_reminder/features/side_effect/logic/side_effect_state.dart';

import '../../../core/model/side_effect.dart';

class SideEffectCubit extends Cubit<SideEffectState> {
  SideEffectCubit() : super(SideEffectState());

  TextEditingController reportController = TextEditingController();

  String medID = 'UhHDvuEHlTtMuV65zbQJ';




 void getSideEffects() async {
    log("Get Side Effects");
    emit(LoadSideEffectLoading());
    try {
      List<SideEffect> sideEffects = await FirebaseServices.getSideEffects(medID);
      log("Get Side Effects Success");
      log(sideEffects[0].description.toString());
      emit(LoadSideEffectSuccess(sideEffects));
    } catch (e) {
      log("Get Side Effects Success");
      emit(LoadSideEffectFailure(e.toString()));
    }
  }


 void reportSideEffect() async {

   if(reportController.text.isEmpty){
     emit(ReportSideEffectFailure("Report can't be Description empty"));
     return;
   }


    SideEffect sideEffect = SideEffect(
      description: reportController.text,
      medID: medID,
      reportDate: DateTime.now(),
      severity: 4,
      sideEffectID: DateTime.now().toString(),
      symptom: "Cough",

    );

    log("Report Side Effect");
    emit(ReportSideEffectLoading());
    try {
      await FirebaseServices.sendReport(sideEffect);
      emit(ReportSideEffectSuccess());
    } catch (e) {
      log("Report Side Effect Failure");
      emit(ReportSideEffectFailure(e.toString()));
    }
  }

}
