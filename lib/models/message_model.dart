enum MessageType {
  text,
  image,
  file,
}

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final MessageType type;
  final String content;
  final String? fileUrl;
  final String? fileName;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    this.fileUrl,
    this.fileName,
    required this.isRead,
    required this.createdAt,
    this.readAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      content: json['content'] as String,
      fileUrl: json['fileUrl'] as String?,
      fileName: json['fileName'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type.toString().split('.').last,
      'content': content,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
    };
  }

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    MessageType? type,
    String? content,
    String? fileUrl,
    String? fileName,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
    );
  }
}
