import 'package:proyectomovil/model/modelCategorias.dart';
import 'package:proyectomovil/model/modelLogin.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/model/modelPedido.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://herencia-api.onrender.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;


  //Obtener productos
  @GET('/productos')
  Future<List<Productos>> getProductos();

  //Obtener categroias
  @GET('/categorias')
  Future<List<Categorias>> getCategorias();

  //Login
  @FormUrlEncoded()
  @POST('/session/loginMovil')
  Future<bool> loginMovil(
    @Field('email') String email,
    @Field('password') String password,
  );

  //Enviar pedido
  @POST('/pedidos/')
  Future<void> enviarPedido(@Body() Pedido pedido);
  
}
