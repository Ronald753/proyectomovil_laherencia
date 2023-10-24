import 'package:json_annotation/json_annotation.dart';

part 'modelLogin.g.dart';

@JsonSerializable()
class LoginResponse {
  bool success;

  LoginResponse({required this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}