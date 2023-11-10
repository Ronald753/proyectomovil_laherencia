// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelPersona.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      telefono: json['telefono'] as String,
      ci: json['ci'] as String,
      correo: json['correo'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'nombres': instance.nombres,
      'apellidos': instance.apellidos,
      'telefono': instance.telefono,
      'ci': instance.ci,
      'correo': instance.correo,
      'password': instance.password,
    };
