import 'dart:convert';

class UserProfile {
  final String displayName;
  final String avatarUrl;

  UserProfile({required this.displayName, required this.avatarUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      displayName: json['displayname'],
      avatarUrl: json['avatar_url'],
    );
  }

  factory UserProfile.fromDecodeJson(Map<String, dynamic> json) {
    return UserProfile(
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  // Convert UserProfile to JSON
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }

  // Convert UserProfile to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Convert a JSON string to UserProfile
  factory UserProfile.fromJsonString(String jsonString) {
    return UserProfile.fromDecodeJson(jsonDecode(jsonString));
  }
}
