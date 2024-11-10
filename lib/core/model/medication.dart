import 'package:cloud_firestore/cloud_firestore.dart';

class Medication {
  final String? medID;
  final String? name;
  final String? description;
  final int? dosage;
  final String? improvementTips;
  final int? quantity;
  final String? sideEffects;
  final String ? thresholdLevel;
  final String? usageInstructions;

  Medication({
     this.medID,
     this.name,
     this.description,
     this.dosage,
     this.improvementTips,
     this.quantity,
     this.sideEffects,
     this.thresholdLevel,
     this.usageInstructions,
  });

  // Factory method to create a Medication instance from Fire store data
  factory Medication.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Medication(
      medID: data['med_id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      dosage: data['dosage'] ?? 0,
      improvementTips: data['improvement_tips'] ?? '',
      quantity: data['quantity'] ?? 0,
      sideEffects: data['side_effects'] ?? '',
      thresholdLevel: data['threshold_level'] ?? '',
      usageInstructions: data['usage_instructions'] ?? '',
    );
  }

  // Convert a Medication instance to a map for Fire store
  Map<String, dynamic> toJson() {
    return {
      'med_id': medID,
      'name': name,
      'description': description,
      'dosage': dosage,
      'improvement_tips': improvementTips,
      'quantity': quantity,
      'side_effects': sideEffects,
      'threshold_level': thresholdLevel,
      'usage_instructions': usageInstructions,
    };
  }
}
