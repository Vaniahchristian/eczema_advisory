enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

class AppointmentModel {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final AppointmentStatus status;
  final String? notes;
  final String? diagnosisId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.status,
    this.notes,
    this.diagnosisId,
    required this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      notes: json['notes'] as String?,
      diagnosisId: json['diagnosisId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'status': status.toString().split('.').last,
      'notes': notes,
      'diagnosisId': diagnosisId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  AppointmentModel copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    DateTime? dateTime,
    AppointmentStatus? status,
    String? notes,
    String? diagnosisId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      diagnosisId: diagnosisId ?? this.diagnosisId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
