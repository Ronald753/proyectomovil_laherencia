import 'package:json_annotation/json_annotation.dart';

part 'modelResetPass.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  ResetPasswordResponse();

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
