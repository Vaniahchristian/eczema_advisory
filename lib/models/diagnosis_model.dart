class DiagnosisModel {
  final String id;
  final String patientId;
  final String imageUrl;
  final String result;
  final String description;
  final double confidence;
  final Map<String, double> probabilities;
  final List<String> recommendations;
  final DateTime createdAt;
  final String? doctorId;
  final String? doctorNotes;
  final DateTime? reviewedAt;

  DiagnosisModel({
    required this.id,
    required this.patientId,
    required this.imageUrl,
    required this.result,
    required this.description,
    required this.confidence,
    required this.probabilities,
    required this.recommendations,
    required this.createdAt,
    this.doctorId,
    this.doctorNotes,
    this.reviewedAt,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      imageUrl: json['imageUrl'] as String,
      result: json['result'] as String,
      description: json['description'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      probabilities: Map<String, double>.from(
        json['probabilities'] as Map<String, dynamic>,
      ),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      doctorId: json['doctorId'] as String?,
      doctorNotes: json['doctorNotes'] as String?,
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'imageUrl': imageUrl,
      'result': result,
      'description': description,
      'confidence': confidence,
      'probabilities': probabilities,
      'recommendations': recommendations,
      'createdAt': createdAt.toIso8601String(),
      'doctorId': doctorId,
      'doctorNotes': doctorNotes,
      'reviewedAt': reviewedAt?.toIso8601String(),
    };
  }

  DiagnosisModel copyWith({
    String? id,
    String? patientId,
    String? imageUrl,
    String? result,
    String? description,
    double? confidence,
    Map<String, double>? probabilities,
    List<String>? recommendations,
    DateTime? createdAt,
    String? doctorId,
    String? doctorNotes,
    DateTime? reviewedAt,
  }) {
    return DiagnosisModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      imageUrl: imageUrl ?? this.imageUrl,
      result: result ?? this.result,
      description: description ?? this.description,
      confidence: confidence ?? this.confidence,
      probabilities: probabilities ?? this.probabilities,
      recommendations: recommendations ?? this.recommendations,
      createdAt: createdAt ?? this.createdAt,
      doctorId: doctorId ?? this.doctorId,
      doctorNotes: doctorNotes ?? this.doctorNotes,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }
}
