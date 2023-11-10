import 'package:json_annotation/json_annotation.dart';

part 'modelLogin.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool status;
  @JsonKey(name: 'id_persona')
  final String idPersona;

  LoginResponse({
    required this.status,
    required this.idPersona,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}