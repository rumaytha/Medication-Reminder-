import 'package:cloud_firestore/cloud_firestore.dart';

class SideEffect {
  final String? sideEffectID;
  final String? symptom;
  final int? severity; // 1 to 10 scale
  final String? duration;
  final String? description;
  final String? medID;
  final String? reportedBy;
  final String? imageUrl;
  final DateTime? reportDate;

  SideEffect(
      {this.medID,
      this.sideEffectID,
      this.symptom,
      this.severity,
      this.duration,
      this.description,
      this.reportedBy,
      this.reportDate,
      this.imageUrl});

  // Convert Fire store document to SideEffect instance
  factory SideEffect.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SideEffect(
      imageUrl: data['imageUrl'] ?? '',
      sideEffectID: data['sideEffectID'] ?? '',
      symptom: data['symptom'] ?? '',
      severity: data['severity'] ?? 0,
      duration: data['duration'] ?? '',
      description: data['description'] ?? '',
      reportedBy: data['user_id'] ?? '',
      medID: data['med_id'] ?? '',
      reportDate: data['reportDate'] == null
          ? null
          : (data['reportDate'] as Timestamp).toDate(),
    );
  }

  // Convert SideEffect instance to map for Fire store
  Map<String, dynamic> toMap() {
    return {
      'sideEffectID': sideEffectID,
      'symptom': symptom,
      'severity': severity,
      'duration': duration,
      'description': description,
      'user_id': reportedBy,
      "med_id": medID,
      'reportDate': reportDate,
      "imageUrl": imageUrl
    };
  }
}
