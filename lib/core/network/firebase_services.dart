import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/medication.dart';
import '../model/side_effect.dart';

class FirebaseServices {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<Medication?> getMedication(String medID) async {
    try {
      // Fetch the Medication by med_id
      QuerySnapshot medicationSnapshot = await fireStore
          .collection('medications')
          .where('med_id', isEqualTo: medID)
          .limit(1)
          .get();

      if (medicationSnapshot.docs.isEmpty) {
        print('Medication with med_id $medID not found.');
        return null;
      }

      // Convert document to Medication instance
      final medication = Medication.fromJson(medicationSnapshot.docs.first);
      return medication;
    } catch (e) {
      print('Error fetching medication: $e');
      return null;
    }
  }

 static Future<List<SideEffect>> getSideEffects(String medID) async {
    try {
      // Fetch all side effects with the matching med_id
      QuerySnapshot sideEffectsSnapshot = await fireStore
          .collection('side_effects')
          .where('med_id', isEqualTo: medID)
          .get();

      // Convert documents to SideEffect instances
      final sideEffects = sideEffectsSnapshot.docs
          .map((doc) => SideEffect.fromFireStore(doc))
          .toList();

      log(sideEffects[0].description.toString());

      return sideEffects;
    } catch (e) {
      print('Error fetching side effects: $e');
      return [];
    }
  }


 static Future<void> sendReport(SideEffect sideEffect) async {
    try {
      // Add side effect report to the "side_effects" collection in Firestore
      await fireStore.collection('side_effects').add(sideEffect.toMap());
      print('Side effect report sent successfully.');
    } catch (e) {
      print('Failed to send side effect report: $e');
    }
  }
}
