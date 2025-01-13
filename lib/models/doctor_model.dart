class DoctorModel {
  final String id;
  final String name;
  final String email;
  final String specialization;
  final String? imageUrl;
  final String? bio;
  final List<String> availableDays;
  final String startTime;
  final String endTime;
  final double rating;
  final int reviewCount;
  final bool isAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.specialization,
    this.imageUrl,
    this.bio,
    required this.availableDays,
    required this.startTime,
    required this.endTime,
    required this.rating,
    required this.reviewCount,
    required this.isAvailable,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      specialization: json['specialization'] as String,
      imageUrl: json['imageUrl'] as String?,
      bio: json['bio'] as String?,
      availableDays: (json['availableDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'bio': bio,
      'availableDays': availableDays,
      'startTime': startTime,
      'endTime': endTime,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
    };
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    String? email,
    String? specialization,
    String? imageUrl,
    String? bio,
    List<String>? availableDays,
    String? startTime,
    String? endTime,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
      availableDays: availableDays ?? this.availableDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
