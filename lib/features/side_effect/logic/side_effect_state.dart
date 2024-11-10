import '../../../core/model/side_effect.dart';

class SideEffectState {}

class SideEffectInitial extends SideEffectState {}

class LoadSideEffectLoading extends SideEffectState {}

class LoadSideEffectSuccess extends SideEffectState {
  final List<SideEffect> sideEffects;

  LoadSideEffectSuccess(this.sideEffects);
}

class LoadSideEffectFailure extends SideEffectState {
  final String message;

  LoadSideEffectFailure(this.message);
}

class ReportSideEffectLoading extends SideEffectState {}

class ReportSideEffectSuccess extends SideEffectState {}

class ReportSideEffectFailure extends SideEffectState {
  final String message;

  ReportSideEffectFailure(this.message);
}
