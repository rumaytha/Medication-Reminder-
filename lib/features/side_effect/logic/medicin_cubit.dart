import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_reminder/features/side_effect/logic/medication_state.dart';

import '../../../core/model/medication.dart';
import '../../../core/network/firebase_services.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(LoadMedicationInitial());
  String medID = 'UhHDvuEHlTtMuV65zbQJ';

  getMedication() async {
    log("Get Medication");

    emit(LoadMedicationLoading());
    try {
      Medication? medication = await FirebaseServices.getMedication(medID);
      log("Get Medication Success");
      log(medication!.name.toString());
      emit(LoadMedicationSuccess(medication));
    } catch (e) {
      log("Get Medication Success");
      emit(LoadMedicationFailure(e.toString()));
    }
  }

}
