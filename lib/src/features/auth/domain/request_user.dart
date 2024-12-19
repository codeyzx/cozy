class RequestUser {
  final String? id;
  final String? name;
  final String? photoUrl;

  RequestUser({
    this.id,
    this.name,
    this.photoUrl,
  });

  factory RequestUser.fromJson(Map<String, dynamic> json) {
    return RequestUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  RequestUser copyWith({
    String? id,
    String? name,
    String? photoUrl,
  }) {
    return RequestUser(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
