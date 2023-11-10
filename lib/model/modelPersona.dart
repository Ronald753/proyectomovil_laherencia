import 'package:json_annotation/json_annotation.dart';

part 'modelPersona.g.dart';

@JsonSerializable()
class Persona {
  @JsonKey(name: 'nombres')
  String nombres;

  @JsonKey(name: 'apellidos')
  String apellidos;

  @JsonKey(name: 'telefono')
  String telefono;

  @JsonKey(name: 'ci')
  String ci;

  @JsonKey(name: 'correo')
  String correo;

  @JsonKey(name: 'password')
  String password;

  Persona({
    required this.nombres,
    required this.apellidos,
    required this.telefono,
    required this.ci,
    required this.correo,
    required this.password,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => _$PersonaFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaToJson(this);
}
