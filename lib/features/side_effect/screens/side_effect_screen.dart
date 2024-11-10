import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_reminder/core/model/medication.dart';
import 'package:medication_reminder/core/model/side_effect.dart';
import 'package:medication_reminder/features/side_effect/logic/medication_state.dart';
import 'package:medication_reminder/features/side_effect/logic/medicin_cubit.dart';
import 'package:medication_reminder/features/side_effect/screens/report_side_effect_details.dart';
import '../logic/side_effect_cubit.dart';
import '../logic/side_effect_state.dart';

class SideEffectScreen extends StatefulWidget {
  const SideEffectScreen({super.key});

  @override
  State<SideEffectScreen> createState() => _SideEffectScreenState();
}

class _SideEffectScreenState extends State<SideEffectScreen> {
  @override
  void initState() {
    context.read<MedicationCubit>().getMedication();
    context.read<SideEffectCubit>().getSideEffects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Medication? medication;
    List<SideEffect> sideEffects = [];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: BlocBuilder<MedicationCubit, MedicationState>(
              builder: (context, state) {
            log(state.toString());

            if (state is LoadMedicationLoading) {
              return const Center(
                  child: SafeArea(child: CircularProgressIndicator()));
            }
            if (state is LoadMedicationFailure) {
              return const Center(child: Text("Some Error Occurred"));
            }

            if (state is LoadMedicationSuccess) {
              medication = state.medication;
            }

            if (state is LoadMedicationSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * .45,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 30,
                          // to shift little up
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 250,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFFa995ec),
                                  Color(0xFF878cff),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          height: 200,
                          left: 10,
                          right: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 12),
                              color: const Color(0xFFf5f5d7),
                              child: Column(
                                children: [
                                  Text(
                                    "${medication?.name}, Usage and Side Effects",
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            medication!.usageInstructions ?? "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Image.asset(
                                              "assets/images/medcin_icon.png",
                                              width: 50,
                                              height: 70),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildInfoSection("Impact on over all health",
                      "Abnormal levels of calcium can occur "),
                  _buildInfoSection("How to improve health conditions ",
                      medication?.improvementTips ?? ""),
                  BlocBuilder<SideEffectCubit, SideEffectState>(
                      builder: (context, sate) {
                    log(state.toString());

                    if (sate is LoadSideEffectSuccess) {
                      sideEffects = sate.sideEffects;
                    }
                    return _buildInfoSection(
                      "Side Effects",
                      sideEffects.map((e) => e.description).join(",\n"),
                    );
                  }),
                  SizedBox(height: constraints.maxHeight * .10),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        onPressed: () async {
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => SideEffectCubit(),
                                child: const ReportSideEffectDetails(),
                              ),
                            ),
                          );
                         context.read<SideEffectCubit>().getSideEffects();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 56)),
                        child: const Text(
                          "Report Side Effect",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                  )
                ],
              );
            } else {
              return const Center(child: Text(" Error Occurred"));
            }
          }),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return ExpansionTile(
      title: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      // Hide divider line by setting shape and collapsedShape with no borders
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.transparent),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.transparent),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
