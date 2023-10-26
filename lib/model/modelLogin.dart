class ModelLogin {
  final String mensaje;

  ModelLogin({required this.mensaje});

  factory ModelLogin.fromJson(Map<String, dynamic> json) {
    return ModelLogin(mensaje: json['mensaje']);
  }
}