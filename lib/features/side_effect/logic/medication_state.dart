import '../../../core/model/medication.dart';

class MedicationState {}
class LoadMedicationInitial extends MedicationState {}
class LoadMedicationLoading extends MedicationState {}

class LoadMedicationSuccess extends MedicationState {
  final Medication medication;

  LoadMedicationSuccess(this.medication);
}

class LoadMedicationFailure extends MedicationState {
  final String message;
  LoadMedicationFailure(this.message);
}
